Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWHROnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWHROnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWHROnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:43:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62879 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030436AbWHROnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:43:18 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E57689.9070209@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>
	 <1155754029.9274.21.camel@localhost.localdomain>	<44E46FC4.2050002@sw.ru>
	 <1155825379.9274.39.camel@localhost.localdomain>  <44E57689.9070209@sw.ru>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 07:43:08 -0700
Message-Id: <1155912188.9274.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 12:12 +0400, Kirill Korotaev wrote:
> LDT takes from 1 to 16 pages. and is allocated by vmalloc.
> do you propose to replace it with slab which can fail due to memory
> fragmentation?

Nope.  ;)

> the same applies to fdset, fdarray, ipc ids and iptables entries. 

The vmalloc area, along with all of those other structures _have_ other
data structures.  Now, it will take a wee bit more patching to directly
tag those thing with explicit container pointers (or accounting
references), but I would much prefer that, especially for the things
that are larger than a page.

I worry that this approach was used instead of patching all of the
individual subsystems because this was easier to maintain as an
out-of-tree patch, and it isn't necessarily the best approach.

-- Dave

