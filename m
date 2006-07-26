Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWG0AAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWG0AAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWG0AAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:00:30 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:3539 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751827AbWG0AA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:00:29 -0400
Date: Thu, 27 Jul 2006 00:59:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] vm/agp: remove private page protection map
In-Reply-To: <Pine.LNX.4.64.0607270023120.23571@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0607270059220.17518@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0607181905140.26533@skynet.skynet.ie>
 <Pine.LNX.4.64.0607262135440.11629@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0607270023120.23571@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 27 Jul 2006 00:00:14.0992 (UTC) FILETIME=[A35B1900:01C6B10F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Dave Airlie wrote:
> > agp_convert_mmap_flags still using its own conversion from PROT_ to VM_
> > while there's an inline in mm.h (though why someone thought to optimize

My mistake: calc_vm_prot_bits() is actually in include/linux/mman.h
(which you are already #including, so no problem).

> > AGP keeps its own copy of the protection_map, upcoming DRM changes will
> > also require access to this map from modules.
> >
> > Signed-off-by: Hugh Dickins <hugh@veritas.com>
> 
> Signed-of-by: Dave Airlie <airlied@linux.ie>

Thanks.  By the way, I hope you noticed that some architectures
(arm, m68k, sparc, sparc64) may adjust protection_map[] at startup:
so the old agp_convert_mmap_flags would supply the compiled in prot,
whereas the new agp_convert_mmap_flags supplies the adjusted prot.

I assume this is either irrelevant to you (no AGP on some arches?)
or an improvement (the adjusted prot more appropriate); but if you
weren't aware of it, please do check that those do what you want.

Hugh
