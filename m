Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTEPIIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 04:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTEPIIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 04:08:40 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:64708 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264370AbTEPIIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 04:08:38 -0400
Date: Fri, 16 May 2003 04:19:12 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
 (fwd)
In-Reply-To: <Pine.LNX.4.44.0305160157010.32563-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.33.0305160354500.23288-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 May 2003, Yoav Weiss wrote:

> Hi,
>
> I got the below from some guy, off the list.
> He may has a point, at least when writable pages are shared between
> processes.
>
> What do you think ?
>
> 	Yoav
>
>  My apologies; I was unclear.
>
>  I think that you need to associate swap encryption keys with memory
> spaces, not with processes, precisely because you need to be able to
> swap out and swap in from any process using that memory space. And
> correspondingly the key can't die on a per-process basis, it has to
> die if and only if the associated memory space is torn down (which
> may be long after the PID that originally creates it goes away).

Hi Yoav,

After sort of thinking about it at this early friday hour (well late
thursday for me), it occurs to me that we may want to maintain keys
either in the vm_area_struct (vma) or for a vma group.

We want to decrypt mostlikely after a page-fault, which triggers a vma
nopage (code here?), has loaded the page so vma key, and swapping out of
course is still in vma domain.

Since we can always go from process to vma to page and back again i think
it is not going to cause any tracking issues.

Further, we have different vma's for shared and other interesting pages
so various optimizations are also doable on a case to case basis.

Does this make any sense? or am I off the cuckoo train at this hour :)

Please comment.

Cheers,

Ahmed.

