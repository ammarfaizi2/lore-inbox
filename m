Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbTCSQNO>; Wed, 19 Mar 2003 11:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbTCSQNO>; Wed, 19 Mar 2003 11:13:14 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:13138 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S263077AbTCSQNN>; Wed, 19 Mar 2003 11:13:13 -0500
Date: Wed, 19 Mar 2003 11:22:51 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Cc: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH 2.5.65] pnp api changes to sound/isa/sb/es968.c
In-Reply-To: <861563974656.20030319180923@wr.miee.ru>
Message-ID: <Pine.LNX.4.53.0303191059100.28260@quinn.larvalstage.com>
References: <Pine.LNX.4.53.0303190650530.28260@quinn.larvalstage.com>
 <861563974656.20030319180923@wr.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm..  I think you're right.  I don't know of a hotplug isa sound card. 
 I've essentially made the changes by looking at how sound/isa/als100.c 
was changed in 2.5.65.
http://linux.bkbits.net:8080/linux-2.5/cset@1.1075.1.7?nav=index.html|ChangeSet@-2w
Since that change was accepted, I just assumed it was right without much 
thought.  I guess I'll have to make a patch for als100 to use __devinit 
and __devexit.

John Kim


On Wed, 19 Mar 2003, Ruslan U. Zakirov wrote:

> JK> Following patch is to make ESS968 driver to work with PNP API.
> [SNIP]
> JK> +static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
> [SNIP]
>       Hello, Adam, Greg and other.
> As I think in this section of kernel it's not necessarily to use
> __devinit and __devexit.
> Soundcards(and other devices) can't be HotPlug as I know.
> And if we look at #define of this attributes, then we see that
> it useless with not HotPlug devices.
> 
> 180 #ifdef CONFIG_HOTPLUG
> 181 #define __devinit
> 182 #define __devinitdata
> 183 #define __devexit
> 184 #define __devexitdata
> 185 #else
> 186 #define __devinit __init
> 187 #define __devinitdata __initdata
> 188 #define __devexit __exit
> 189 #define __devexitdata __exitdata
> 190 #endif
> And with changes from __init to __devinit and enabled CONFIG_HOTPLUG
> we loose advantage of __init.
> May be I've missed something?
>        Best regards, Ruslan.
> 
