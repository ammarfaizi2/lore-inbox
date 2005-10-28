Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbVJ1VAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbVJ1VAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbVJ1VAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:00:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751720AbVJ1VAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:00:02 -0400
Date: Fri, 28 Oct 2005 21:59:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028205916.GL4464@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
	Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz> <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com> <1130532239.4363.125.camel@mindpipe> <20051028205132.GB11397@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028205132.GB11397@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 10:51:32PM +0200, Pavel Machek wrote:
> Well, keyboard detected and reported an error. Kernel reacted with
> printk(). You are removing that printk(). I can understand that,
> printk is really annoying, but I really believe _some_ error handling
> should be added there if you remove the printk.

What do you suggest?

Having a TP 380XD which regularly produces this annoying message,
it's just logspam.  There's no noticable failure.

Plus, kernels previous to ones with the new input subsystem just
used to ignore the scancode (from v2.[24].xx):

int pckbd_translate(unsigned char scancode, unsigned char *keycode,
                    char raw_mode)
{
...
        /* 0xFF is sent by a few keyboards, ignore it. 0x00 is error */
        if (scancode == 0x00 || scancode == 0xff) {
                prev_scancode = 0;
                return 0;
        }
}

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
