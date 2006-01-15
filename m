Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWAOVOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWAOVOo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWAOVOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:14:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3239 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750883AbWAOVOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:14:43 -0500
Date: Sun, 15 Jan 2006 22:14:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <willy@w.ods.org>
cc: Thomas Fazekas <thomas.fazekas@gmail.com>, linux-kernel@vger.kernel.org,
       arch@archlinux.org
Subject: Re: Modify setterm color palette
In-Reply-To: <20060115133536.GN7142@w.ods.org>
Message-ID: <Pine.LNX.4.61.0601152203380.29696@yvahk01.tjqt.qr>
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com>
 <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
 <20060115131620.GA24976@flint.arm.linux.org.uk> <20060115133536.GN7142@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > drivers/char/vt.c: default_red, default_grn, default_blu
>> > 
>> > You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
>> > digit (range 0-F), and RGB are the components. Check console_codes(4) and 
>> > go figure. :)
>> 
>> I for one prefer the standard VT100 yellow instead of brown, and I
>> have an escape sequence to do that similar to the one you show above.

Cool. I prefer "purified" colors, i.e. {0x00,0x00,0xFF} instead of
{0x55,0x55,0xFF} for brightblue. :D

>> However, there's one major flaw - programs recently (and by that I mean
>> FC2-like recently) have started to do complete console resets, which
>> result in the users settings being completely wiped out.
>> So, in essence, this is a completely useless solution.  I think we need
>> a separate escape sequence to modify the system default so that peoples
>> preferences do not get inadvertently wiped out by programs.
>
>Why not add an escape sequence to lock/unlock the palette ? It might be
>simpler, and we could even stack the locks to ensure recursive protection.

How about putting it into /sys...

Signed-off-by: Jan Engelhardt <jengelh@linux01.gwdg.de>
Applies with fuzz 2 because my values for default_blu are already modified 
and not the same as 2.6.15.

diff --fast -Ndpru linux-2.6.15~/drivers/char/vt.c linux-2.6.15/drivers/char/vt.c
--- linux-2.6.15~/drivers/char/vt.c	2006-01-15 21:29:12.000000000 +0100
+++ linux-2.6.15/drivers/char/vt.c	2006-01-15 22:07:22.225060000 +0100
@@ -916,6 +916,10 @@ int default_grn[] =
 int default_blu[] =
 {0x00,0x00,0x00,0x00,0x80,0xaa,0xaa,0xaa,0x55,0x00,0x00,0x00,0xff,0xff,0xff,0xff};
 
+module_param_array(default_red, int, NULL, S_IRUGO | S_IWUSR);
+module_param_array(default_grn, int, NULL, S_IRUGO | S_IWUSR);
+module_param_array(default_blu, int, NULL, S_IRUGO | S_IWUSR);
+
 /*
  * gotoxy() must verify all boundaries, because the arguments
  * might also be negative. If the given position is out of
#<<eof>>



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
