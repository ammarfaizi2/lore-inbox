Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUBQUGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 15:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBQUGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 15:06:14 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10946 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266614AbUBQUGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 15:06:02 -0500
Date: Tue, 17 Feb 2004 21:05:46 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: GCS <gcs@lsc.hu>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
Message-ID: <20040217200545.GP1308@fs.tum.de>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org> <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 11:09:45AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 17 Feb 2004, GCS wrote:
> >
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
> 
> CONFIG_FB_RADEON_I2C should depend on CONFIG_I2C, and it selects 
> I2C_ALGOBIT, but your error messages seem to imply that you don't have i2c 
> enabled at all.
> 
> Which implies a configuration error (but the Kconfig file looks correct, 
> so I wonder if you found a bug in the configurator).

Most likely the problem is CONFIG_I2C=m and the fact that FB_RADEON_I2C
is a bool.

I don't know whether there's a better way to express this, but something 
like the following is required:

--- linux-2.6.3-rc4/drivers/video/Kconfig.old	2004-02-17 21:00:24.000000000 +0100
+++ linux-2.6.3-rc4/drivers/video/Kconfig	2004-02-17 21:01:53.000000000 +0100
@@ -644,7 +644,7 @@
 
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-	depends on FB_RADEON && I2C
+	depends on (FB_RADEON=m && I2C) || (FB_RADEON=y && I2C=y)
 	select I2C_ALGOBIT
 	default y
 	help


> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

