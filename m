Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266409AbSKUIcK>; Thu, 21 Nov 2002 03:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSKUIcK>; Thu, 21 Nov 2002 03:32:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60402 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266409AbSKUIcJ>; Thu, 21 Nov 2002 03:32:09 -0500
Date: Thu, 21 Nov 2002 09:39:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5 kconfig doesn't handle "&& m" correctly
Message-ID: <20021121083912.GE11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

while looking for the reason for a compile error in 2.5.48 I noticed the
following that seems to be a bug in the new kconfig:

The following is with a .config that was generated using
"make oldconfig":

<--  snip  -->

$ grep SOUND_WAVEFRONT .config
CONFIG_SOUND_WAVEFRONT=y
$ 

<--  snip  -->


sound/oss/Kconfig contains the following:

<--  snip  -->

...
config SOUND_WAVEFRONT
	tristate "Full support for Turtle Beach WaveFront (Tropez Plus, Tropez, Maui) synth/soundcards"
	depends on SOUND_OSS && m
...

<--  snip  -->


It seems the "&& m" (a common way to ensure that something can only be
built modular) isn't handled correctly.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

