Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVCPQsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVCPQsq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVCPQsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:48:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262681AbVCPQs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:48:27 -0500
Message-ID: <42386345.9020800@osdl.org>
Date: Wed, 16 Mar 2005 08:48:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - io_remap_pfn_range
References: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk>
In-Reply-To: <E1DBX27-0000te-00@mta1.cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> This patch introduces a new interface function for mapping bus/device
> memory: io_remap_pfn_range. This accepts the same parameters as
> remap_pfn_range (indeed, by default it is implemented by this existing
> function) but should be used in any situation where the caller is not
> simply remapping ordinary RAM. For example, when mapping device
> registers the new function should be used. 
> 
> The distinction between remapping device memory and ordinary RAM is
> critical for the Xen hypervisor. This may also serve as a starting
> point for cleaning up remaining users of io_remap_page_range (in
> particular, the several sparc-specific sections in various drivers
> that use a special form of io_remap_page_range).
> 
> I have audited the drivers/ and sound/ directories. Most uses of
> remap_pfn_range are okay, but there are a small handful that are
> remapping device memory (mostly AGP and DRM drivers).
> 
> Of particular driver is the HPET driver, whose mmap function is broken
> even for native (non-Xen) builds. If nothing else, vmalloc_to_phys
> should be used instead of __pa to convert an ioremapped virtual
> address to a valid physical address. The fix in this patch is to
> remember the original bus address as probed at boot time and to pass
> this to io_remap_pfn_range.

I'll look over this shortly.  I posted an io_remap_pfn_range() patch
to the linux-mm mailing list last week:
http://marc.theaimsgroup.com/?l=linux-ultrasparc&m=111049550001120&w=2

One of the things that it needs to take into account is that
io_remap_page_range() on sparc/sparc64 has 6 parameters instead of 5.
My patch tries to remedy that...

-- 
~Randy
