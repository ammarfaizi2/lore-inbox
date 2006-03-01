Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWCARuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWCARuT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWCARuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:50:19 -0500
Received: from gold.veritas.com ([143.127.12.110]:36515 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932455AbWCARuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:50:18 -0500
X-IronPort-AV: i="4.02,157,1139212800"; 
   d="scan'208"; a="56477629:sNHT29914408"
Date: Wed, 1 Mar 2006 17:50:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Kamran Karimi <kamrankarimi@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
In-Reply-To: <BAY104-F30D83DE1A3392B1A69554DC0F40@phx.gbl>
Message-ID: <Pine.LNX.4.61.0603011745350.12629@goblin.wat.veritas.com>
References: <BAY104-F30D83DE1A3392B1A69554DC0F40@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Mar 2006 17:50:18.0087 (UTC) FILETIME=[9A3EEF70:01C63D58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Mar 2006, Kamran Karimi wrote:
> 
> > Since you're already patching base kernel source (you mention
> > arch/xyz/mm/fault.c), why don't you just patch your own VM_SYSVSHM
> > into include/linux/mm.h, and set it on the vma in ipc/shm.c?
> 
> Yes this looks like a good solution. I have changed VM_SHM in mm.h to be
> 0x0800000 and am looking for a good place to include it in the vma->vm_flags.

I already pointed out that several drivers are setting VM_SHM; and that
we shall remove it in due course.  Your DIPC patch should use its own flag.

> shmat() looks like a good place. How can I find the vma of a SysV shm in that
> routine?

shm_mmap would be the right place: shmat's do_mmap will call it.

Hugh
