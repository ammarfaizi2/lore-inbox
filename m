Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWH3SjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWH3SjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWH3SjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:39:14 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35342 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751302AbWH3SjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:39:13 -0400
Date: Wed, 30 Aug 2006 19:39:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] re-add -ffreestanding
Message-ID: <20060830183905.GB31594@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Roman Zippel <zippel@linux-m68k.org>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608302013.58122.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 08:13:58PM +0200, Andi Kleen wrote:
> On Wednesday 30 August 2006 19:57, Adrian Bunk wrote:
> > I got the following compile error with gcc 4.1.1 when trying to compile 
> > kernel 2.6.18-rc4-mm2 for m68k:
> 
> If anything then -ffreestanding needs to be added to arch/m68k/Makefile
> (assuming it doesn't compile at all right now)

Looking at the effect of -ffreestanding on ARM, it appears that on one
hand, the overall image size is reduced by 0.016% but we end up with worse
code - eg, strlen() of the same string in the same function evaluated
multiple times vs once without -ffreestanding.

The difference probably comes down to the lack of __attribute__((pure))
on our string functions in linux/string.h.

If we are going to go for -ffreestanding, we need to fix linux/string.h
in that respect _first_.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
