Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWDFKQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWDFKQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWDFKQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:16:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751150AbWDFKQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:16:13 -0400
Date: Thu, 6 Apr 2006 11:16:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Zou Nan hai <nanhai.zou@intel.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060406101604.GA28056@flint.arm.linux.org.uk>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Zou Nan hai <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
References: <20060404014504.564bf45a.akpm@osdl.org> <20060404233851.GA6411@agluck-lia64.sc.intel.com> <1144202706.3197.11.camel@linux-znh> <200604051015.34217.bjorn.helgaas@hp.com> <20060405211757.GA8536@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405211757.GA8536@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 02:17:57PM -0700, Luck, Tony wrote:
> On Wed, Apr 05, 2006 at 10:15:34AM -0600, Bjorn Helgaas wrote:
> > Huh.  Intel firmware used to just not mention the VGA framebuffer
> > (0xa0000-0xc0000) at all in the EFI memory map.  I think that was
> > clearly a bug.  So maybe they fixed that by marking it WB (and
> > hopefully UC as well).
> 
> Nope ... not fixed (at least not in the f/w that I'm running). The
> VGA buffer is still simply not mentioned in the EFI memory map.
> 
> The problem looks to come from this code in vgacon.c:
> 
> 	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> 	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> 	vga_vram_size = vga_vram_end - vga_vram_base;

Wouldn't it be better to do:

	vga_vram_size = vga_vram_end - vga_vram_base;
	vga_vram_base = VGA_IOREMAP(vga_vram_base, vga_vram_size);
	vga_vram_end = vga_vram_base + vga_vram_size;

and for compatibility:

#define VGA_IOREMAP(base,size)	VGA_MAP_MEM(base)

?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
