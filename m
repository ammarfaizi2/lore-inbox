Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSKSMRI>; Tue, 19 Nov 2002 07:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSKSMRH>; Tue, 19 Nov 2002 07:17:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:35558 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265321AbSKSMRG>;
	Tue, 19 Nov 2002 07:17:06 -0500
Date: Tue, 19 Nov 2002 12:22:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Nathan Scott <nathans@sgi.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Memory leak in 2.4 vmalloc.c get_vm_area
Message-ID: <20021119122221.GC27292@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Nathan Scott <nathans@sgi.com>, alan@redhat.com,
	linux-kernel@vger.kernel.org
References: <20021118233202.GB535@frodo.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118233202.GB535@frodo.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 10:32:02AM +1100, Nathan Scott wrote:
 > hi Alan,
 > 
 > I noticed you recently merged this patch with Marcelo in the
 > 2.4 BK tree (lists you as author, and annotation says it came
 > from DaveM originally)...
 > 
 >         --- 1.10/mm/vmalloc.c   Tue Feb  5 06:10:20 2002
 >         +++ 1.11/mm/vmalloc.c   Thu Sep  5 05:22:42 2002
 >         @@ -177,6 +177,8 @@
 >                 if (!area)
 >                         return NULL;
 >                 size += PAGE_SIZE;
 >         +       if(!size)
 >         +               return NULL;
 >                 addr = VMALLOC_START;
 >                 write_lock(&vmlist_lock);
 >                 for (p = &vmlist; (tmp = *p) ; p = &tmp->next) {
 > 
 > 
 > This looks to me like it introduces a memory leak in the new !size
 > case - either the "size" bump and test needs to be moved before the
 > "area" kmalloc, or we need to kfree(area) before returning NULL.
 > 
 > If you like, I'll make a (trivial) patch to do one of these?

Correct diagnosis. Patch went to Marcelo a while back.
(Which I thought he took). Alan already picked it up iirc.

Will retransmit, as this is -rc material IMO.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
