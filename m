Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279532AbRJZXnF>; Fri, 26 Oct 2001 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279607AbRJZXmy>; Fri, 26 Oct 2001 19:42:54 -0400
Received: from [63.220.7.190] ([63.220.7.190]:47574 "HELO gamerack.com")
	by vger.kernel.org with SMTP id <S279532AbRJZXmi>;
	Fri, 26 Oct 2001 19:42:38 -0400
Subject: Re: SiS/Trident 4DWave sound driver oops
From: "Michael F. Robbins" <compumike@compumike.com>
To: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: linux-kernel@vger.kernel.org,
        "Michael F. Robbins" <compumike@compumike.com>,
        Robert Love <rml@tech9.net>,
        Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins> 
	<7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 26 Oct 2001 19:43:02 -0400
Message-Id: <1004139782.1176.10.camel@tbird.robbins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick summary: sound now works on the ALi 5451 chip, 
but has some non-fatal error messages.

On Thu, 2001-10-25 at 21:37, Tachino Nobuhiro wrote:
> diff -u -r linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c linux-2.4.12-ac5/drivers/sound/ac97_codec.c
> --- linux-2.4.12-ac5.org/drivers/sound/ac97_codec.c	Mon Oct 22 09:34:21 2001
> +++ linux-2.4.12-ac5/drivers/sound/ac97_codec.c	Fri Oct 26 10:26:41 2001
> @@ -143,7 +143,6 @@
>  	{0x83847656, "SigmaTel STAC9756/57",	&sigmatel_9744_ops},
>  	{0x83847684, "SigmaTel STAC9783/84?",	&null_ops},
>  	{0x57454301, "Winbond 83971D",		&null_ops},
> -	{0,}
>  };
>  
>  static const char *ac97_stereo_enhancements[] =

I just removed that final data set and the preceeding comma and
recompiled 2.4.12-ac6.  I'm pleased to report that the sound now works
just fine!  The module loads, and I do get some (non-fatal) error
messages, but once its loaded it runs like a champ.

BTW, I was also getting these error messages on my old 2.4.7 install. 
This is my 2.4.12-ac6 log after `modprobe trident`.  Take a look:
----------
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version
0.14.9d, 19:15:41 Oct 26 2001
PCI: Assigned IRQ 10 for device 00:03.0
trident: ALi Audio Accelerator found at IO 0xc400, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x414c:0x4326 (Unknown)
ali: AC97 CODEC read timed out.
ali: AC97 CODEC write timed out.
ali: AC97 CODEC read timed out.
last message repeated 2 times
ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
ali: AC97 CODEC write timed out.
ali: AC97 CODEC read timed out.
ali: AC97 CODEC write timed out.
last message repeated 10 times
ali: AC97 CODEC read timed out.
last message repeated 127 times
----------
This hangs the system totally for about 5 seconds.  After this, it's all
fine and the sound works great.  One strange thing I notice from the
above log is the different codec IDs showing up...

Thanks,

Mike Robbins
compumike@compumike.com
(Please also cc your reply to me.)




