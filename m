Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266949AbUBRAjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266906AbUBRAjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:39:17 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:37509 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S266152AbUBRAiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:38:10 -0500
Date: Wed, 18 Feb 2004 01:21:27 +0100
From: GCS <gcs@lsc.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
Message-ID: <20040218002127.GA27422@lsc.hu>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org> <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 11:09:45AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > drivers/built-in.o(.text+0xb2c44): In function `radeon_do_probe_i2c_edid':
> > : undefined reference to `i2c_transfer'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > .config snippshet:
> > # CONFIG_FB_RADEON_OLD is not set
> > CONFIG_FB_RADEON=y
> > CONFIG_FB_RADEON_I2C=y
> > CONFIG_FB_RADEON_DEBUG=y
> 
> I don't see this. What's your I2C config, and how did you generate your 
> config file?
 I do not attach it, as I think I have found the root of the problem.
Usually I save my .config to a safe place, copy it into the kernel
source, do 'make oldconfig', and only if necessary I do 'make menuconfig'
as well.

> CONFIG_FB_RADEON_I2C should depend on CONFIG_I2C, and it selects 
> I2C_ALGOBIT, but your error messages seem to imply that you don't have i2c 
> enabled at all.
 I have. My shot would be that as CONFIG_FB_RADEON_I2C is y-n, but
CONFIG_I2C and CONFIG_I2C_ALGOBIT are tri-state as m in my case, the
problem can be that the functions are compiled into the module and
CONFIG_FB_RADEON_I2C can't find them in the static part of the kernel.
At least I do confirm that changing CONFIG_I2C and CONFIG_I2C_ALGOBIT
from m to y makes the problem disappear.

> Which implies a configuration error (but the Kconfig file looks correct, 
> so I wonder if you found a bug in the configurator).
 Can the configurator force the dependencies to the same state? For my
case it should have change my m's to y's.

Cheers,
GCS
