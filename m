Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCYA1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCYA1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCYA1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:27:08 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:14042 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751158AbWCYA1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:27:07 -0500
Message-ID: <44248E97.2000900@keyaccess.nl>
Date: Sat, 25 Mar 2006 01:28:07 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ALSA] ISA drivers bailing on first !enable[i]
References: <44238482.50401@keyaccess.nl> <s5hu09onlzd.wl%tiwai@suse.de>
In-Reply-To: <s5hu09onlzd.wl%tiwai@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060901030309040100050101"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060901030309040100050101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>> Assuming this was indeed the idea, I've attached a patch against 2.6.16.
>> If it's correct, but you need it against ALSA CVS instead, please say so
> 
> Yes, these are correct fixes.  Most of them should have been already
> in the latest ALSA tree, i.e. also in Linus git tree now.

I had a feeling I should've checked that when I was composing the message...

> Could you check what's still missing?  I might missed some drivers.

CMI8330 was missing, see attached (generated against -git9). Yes, the 
original patch is still useful for -stable; will submit.

Rene.

--------------060901030309040100050101
Content-Type: text/plain;
 name="alsa_cmi8330_enable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_cmi8330_enable.diff"

Index: linux-2.6.16-git9/sound/isa/cmi8330.c
===================================================================
--- linux-2.6.16-git9.orig/sound/isa/cmi8330.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16-git9/sound/isa/cmi8330.c	2006-03-25 01:10:37.000000000 +0100
@@ -690,9 +690,9 @@ static int __init alsa_card_cmi8330_init
 	if ((err = platform_driver_register(&snd_cmi8330_driver)) < 0)
 		return err;
 
-	for (i = 0; i < SNDRV_CARDS && enable[i]; i++) {
+	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (is_isapnp_selected(i))
+		if (! enable[i] || is_isapnp_selected(i))
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);

--------------060901030309040100050101--
