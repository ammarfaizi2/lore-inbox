Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVDCXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVDCXlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 19:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVDCXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 19:41:24 -0400
Received: from smtp06.auna.com ([62.81.186.16]:29631 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261958AbVDCXlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 19:41:19 -0400
Message-ID: <42507F12.6070009@latinsud.com>
Date: Mon, 04 Apr 2005 01:41:06 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in set_spdif_output in i810_audio
References: <424F20F6.8010804@latinsud.com> <424FC409.3020808@funkmunch.net>
In-Reply-To: <424FC409.3020808@funkmunch.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Triffid Hunter wrote:

> try turning off your internal modem in bios until someone works out 
> whats going on here

* It's one of those modern bios, no way of configuring that.

* It seems to me that it detects only 1 card with 1 only codec which is 
the sound card (sound works if i avoid the null pointer oops). So one of 
the problems is the wrong detection.
Googling i found that  jgarzik already got a patch for this 
(ac97_codec.c:158):
+    {0x43585430, "CXT48",            &default_ops,        
AC97_DELUDED_MODEM },

* About fixing i810_probe/i810_ac97_init, the safest and simplest 
solution may be changing "continue" for "break" (i810_audio.c:3089), 
i.e. give up scanning for sound codecs when the first modem is found. I 
don't if that would prevent any real-world device from working, but the 
alternative is add a lot of checks everywhere.

See you.
