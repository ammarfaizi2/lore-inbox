Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTAYU0P>; Sat, 25 Jan 2003 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTAYU0P>; Sat, 25 Jan 2003 15:26:15 -0500
Received: from mailout.nordcom.net ([213.168.202.90]:21121 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S262201AbTAYU0K>; Sat, 25 Jan 2003 15:26:10 -0500
To: linux-kernel@vger.kernel.org
Cc: khromy@lnuxlab.ath.cx (khromy)
Subject: Re: Mozilla stalls in 2.4.21-pre3
In-Reply-To: <20030125193013$7145@gated-at.bofh.it>
References: <20030125193013$7145@gated-at.bofh.it>
Reply-To: pharao90@tzi.de
Message-Id: <E18cX1P-0000iI-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
Date: Sat, 25 Jan 2003 21:35:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2003 20:30:13 +0100, you wrote in linux.kernel:

> When playing an mp3 with xmms and using mozilla, sometimes when I click
> on a link, mozilla stalls.  When I stop the mp3, the page finally loads.
> Let me know if you need any more information. TIA.
> 
> My kernel is 2.4.21-pre3.
> 
> My soundcard uses es1371.

The es1371 driver only provides one digital playback channel. So, if one
application uses /dev/dsp, other applications trying to do the same will
block.

Most likely, the web page you're trying to open has some flash animation
on it (even some ad banners use flash) and the flashplayer plugin tries
to open /dev/dsp and blocks, and since mozilla waits for the plugin
to initialize, it blocks, too.
  
-- 
Ciao,
Pascal
