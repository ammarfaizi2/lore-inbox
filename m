Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSIBNym>; Mon, 2 Sep 2002 09:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSIBNym>; Mon, 2 Sep 2002 09:54:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43234 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318300AbSIBNyl>; Mon, 2 Sep 2002 09:54:41 -0400
Date: Mon, 2 Sep 2002 15:59:07 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: partmaps@vortex.physik.uni-konstanz.de, Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19(-pre5) problems
In-Reply-To: <200209021124.47296.partmaps@vortex.physik.uni-konstanz.de>
Message-ID: <Pine.NEB.4.44.0209021548360.147-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002 partmaps@vortex.physik.uni-konstanz.de wrote:

> Hi,

Hi Max,

> I have a few problems here moving up from a 2.4.18 (which is working well).
> Hope this will be useful to somebody.

yes, thanks for your mail.

>...
> 2.4.19-pre5 (make oldconfig again) fails to compile with an obscure undefined
> reference. (see output below.)
>
> I will also attach my '.config' file (as obtaind after doing a 2.4.19-pre5
> make oldconfig and answering (ENTER) to all questions. Please contact me if
> you need more information. (Mind I am not on lkml).
>
> Regards,
> Max
>...
>         --end-group \
>         -o vmlinux
> drivers/media/media.o: In function `pvr_boot':
> drivers/media/media.o(.text+0x6e99): undefined reference to
> `mod_firmware_load'
> make: *** [vmlinux] Error 1


This is caused by Gerd Knorr's bttv driver update. The problem is:
drivers/media/video/bttv-cards.c uses
  extern int mod_firmware_load(const char *fn, char **fp);

mod_firmware_load is in drivers/sound/sound_firmware.c but since your
sound is completely modular it's not in the kernel.

Workarounds (untested):
Either compile the bt848 driver modular or compile the sound supprt
statically into your kernel (the driver for your sound card can stay
modular).


Gerd:
If you want to use mod_firmware_load in drivers/media/video/bttv-cards.c
you must make this driver depend on CONFIG_SOUND (IIRC there was a
similar problem reported by someone who's bt848 driver was modular but
CONFIG_SOUND was completely unset which resulted in a depmod error).


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

