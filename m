Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVHLT6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVHLT6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVHLT6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:58:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:28371 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932071AbVHLT6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:58:53 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal (version
	2)
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, NAGANO Daisuke <breeze.nagano@nifty.ne.jp>,
       alan@lxorguk.ukuu.org.uk, sailer@ife.ee.ethz.ch,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zaitcev@yahoo.com,
       Christoph Eckert <ce@christeck.de>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20050809174906.GA4006@stusta.de>
References: <20050729153226.GE3563@stusta.de>
	 <1123607633.5601.7.camel@mindpipe>  <20050809174906.GA4006@stusta.de>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 15:58:48 -0400
Message-Id: <1123876729.12680.45.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 19:49 +0200, Adrian Bunk wrote:
> On Tue, Aug 09, 2005 at 01:13:51PM -0400, Lee Revell wrote:
> > On Fri, 2005-07-29 at 17:32 +0200, Adrian Bunk wrote:
> > > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > > support the same hardware) for removal.
> > > 
> > > Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> > > 
> > 
> > Someone on linux-audio-user just pointed out that the OSS USB audio and
> > midi modules were never deprecated, much less scheduled to be removed.
> > 
> > Maybe the best way to deprecate them is to move them to Sound -> OSS,
> > that's where they belong anyway.
> 
> I'd deprecate them without moving them.
> 

Here's the patch.  The bug was that CONFIG_USB_AUDIO and CONFIG_USB_MIDI
need to depend on CONFIG_SOUND_PRIME.

It also fixes some typos and clarifies the help text.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--- linux-2.6.13-rc4/drivers/usb/class/Kconfig~	2005-08-12 15:54:36.000000000 -0400
+++ linux-2.6.13-rc4/drivers/usb/class/Kconfig	2005-08-12 15:57:38.000000000 -0400
@@ -5,12 +5,12 @@
 	depends on USB
 
 config USB_AUDIO
-	tristate "USB Audio support"
-	depends on USB && SOUND
+	tristate "USB Audio support (OSS)"
+	depends on USB && SOUND_PRIME
 	help
 	  Say Y here if you want to connect USB audio equipment such as
 	  speakers to your computer's USB port. You only need this if you use
-	  the OSS sound driver; ALSA has its own option for usb audio support.
+	  the OSS sound system; ALSA has its own option for USB audio support.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called audio.
@@ -39,11 +39,13 @@
 	  module will be called bluetty.
 
 config USB_MIDI
-	tristate "USB MIDI support"
-	depends on USB && SOUND
+	tristate "USB MIDI support (OSS)"
+	depends on USB && SOUND_PRIME
 	---help---
 	  Say Y here if you want to connect a USB MIDI device to your
-	  computer's USB port. This driver is for devices that comply with
+	  computer's USB port. You only need this if you use the OSS 
+	  sound system; USB MIDI devices are supported by ALSA's USB 
+	  audio driver.  This driver is for devices that comply with
 	  'Universal Serial Bus Device Class Definition for MIDI Device'.
 
 	  The following devices are known to work:


