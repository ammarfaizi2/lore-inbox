Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVASUvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVASUvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVASUvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:51:14 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:15121 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261887AbVASUtf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:49:35 -0500
Date: Wed, 19 Jan 2005 21:52:09 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Jonas Munsin <jmunsin@iki.fi>, Simone Piunno <pioppo@ferrara.linux.it>,
       LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050119215209.77950499.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
References: <200501080150.44653.pioppo@ferrara.linux.it>
	<20050108172020.64999e50.khali@linux-fr.org>
	<200501082023.54881.pioppo@ferrara.linux.it>
	<200501102023.44847.pioppo@ferrara.linux.it>
	<20050110203427.5061cf0d.khali@linux-fr.org>
	<Pine.LNX.4.61.0501191448160.5315@localhost.localdomain>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> FWIW, I have a Gigabyte motherboard with an it87 chip too.  Reading 
> about this it87 polarity thing I'm suspecting something is really
> wrong  here:
> 
> When system is idle, the sensors report shows:
> CPU temp = +25°C and CPU fan = 2136 RPM (and rather noisy)
> 
> When system is 100% busy (with dd if=/dev/urandom of=/dev/null):
> CPU temp = +41°C and CPU fan =   1288 RPM (and obviously much quieter)
> 
> I'm running a 2.6.10 kernel (not -mm) so I guess the BIOS settings for
> fan control are not altered.  And incidentally the BIOS has a setting 
> called "smart fan control" set to "enabled" which maps to the ITxxF 
> automatic PWM control mode I suppose.  So if the BIOS actually set the
> fan polarity wrong then the fan would slow down when the temperature 
> rises and vice versa, right?

That's right, what you describe really sounds like a wrong polarity
setting.

Could you please tell us what model it is, with what BIOS revision? I
would also appreciate a dump of the chip (isadump 0x295 0x296 unless it
lives at some uncommon address) to confirm the guess.

The code Jonas and I have been adding to the it87 driver recently will
probably not work for you if you leave the "smart fan control" enabled
in your BIOS setup screen (because we supposed that no reponsible
motherboard maker would enable this mode without properly configuring
the polarity beforehand - wrong guess in your case - and are not
allowing a polarity inversion in this case). However, by disabling this
mode in the BIOS setup screen, you should be able to use the new
fix_pwm_polarity module register to get the polarity fixed, with manual
PWM control (no auto mode yet).

You might also search for a BIOS update for your board. I consider the
behavior your describe a major problem and would expect Gigabyte to fix
it at some point in time.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
