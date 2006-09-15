Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWIODcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWIODcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 23:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWIODcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 23:32:55 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:28881 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751495AbWIODcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 23:32:54 -0400
Date: Fri, 15 Sep 2006 04:32:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       alan <alan@redhat.com>, zxc <zxc@ncic.ac.cn>
Subject: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
In-Reply-To: <20060915005846.07C31FB045@ncic.ac.cn>
Message-ID: <Pine.LNX.4.64.0609150419170.6769@blonde.wat.veritas.com>
References: <20060915005846.07C31FB045@ncic.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Sep 2006 03:32:23.0011 (UTC) FILETIME=[8E802B30:01C6D877]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Yingchao Zhou wrote:
> >
> >You want to mmap MAP_SHARED, which will use PAGE_SHARED instead,
> >including the write bit, both before and after the mprotects.
> >There should be no problem then: do you actually see a problem
> >when MAP_SHARED is used?
> It's ok to mmap MAP_SHARED. But is it not a normal way to malloc() a space and
> then registered to NIC ?

Not that I know of.  How would one register malloc()ed space to a NIC?
Sorry, I may well be misunderstanding you.

> >>      Adding PAGE_RW to PAGE_COPY will resolve this problem.  
> >
> >No!  That would give every user write access to shared files they
> >should have no write access to.
> I guess you refer to mmap a file MAP_READ|MAP_WRITE in MAP_PRIVATE way.
> I think it is probably more logical to read the file data into an anoymous page and filled the pte with _PAGE_RW in the first time page-fault. It will probably reduce numbers of page fault interrupt.

do_no_page() does just that when its fault demands write access; but
doesn't waste memory and time on copying when it's only a read access.

Hugh
