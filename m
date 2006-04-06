Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWDFKWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWDFKWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 06:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWDFKWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 06:22:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39439 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932162AbWDFKWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 06:22:00 -0400
Date: Thu, 6 Apr 2006 11:21:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Zou Nan hai <nanhai.zou@intel.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060406102154.GB28056@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn.helgaas@hp.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Zou Nan hai <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
References: <20060404014504.564bf45a.akpm@osdl.org> <200604051015.34217.bjorn.helgaas@hp.com> <20060405211757.GA8536@agluck-lia64.sc.intel.com> <200604051601.08776.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604051601.08776.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 04:01:08PM -0600, Bjorn Helgaas wrote:
> [PATCH] vgacon: make VGA_MAP_MEM take size, remove extra use

Ah, seems to be what I just suggested...

> @@ -1020,14 +1019,14 @@
>  	char *charmap;
>  	
>  	if (vga_video_type != VIDEO_TYPE_EGAM) {
> -		charmap = (char *) VGA_MAP_MEM(colourmap);
> +		charmap = (char *) VGA_MAP_MEM(colourmap, 0);

Don't like this though - can't we pass a real size here rather than zero?
There seems to be several clues as to the maximum size:

#define cmapsz 8192

        if (!vga_font_is_default)
                charmap += 4 * cmapsz;

                        charmap += 2 * cmapsz;
                                for (i = 0; i < cmapsz; i++)
                                        vga_writeb(arg[i], charmap + i);

so that's about 7 * cmapsz - call that 8 for completeness, which is 64K.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
