Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSK2JyP>; Fri, 29 Nov 2002 04:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbSK2JyP>; Fri, 29 Nov 2002 04:54:15 -0500
Received: from vortex.physik.uni-konstanz.de ([134.34.143.44]:265 "EHLO
	vortex.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S266996AbSK2JyO>; Fri, 29 Nov 2002 04:54:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: partmaps@vortex.physik.uni-konstanz.de
Subject: 2.4.20 compile problem
Date: Fri, 29 Nov 2002 11:01:29 +0100
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211291101.29880.partmaps@vortex.physik.uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys and gals,

there is still a (minor) compile problem in 2.4.20 which has been pointed out 
before. See analysis in message attached below.

concerns
mod_firmware_load() in drivers/media/video/bttv-cards.c

Cheers,
Max

----------  Forwarded Message  ----------

Date: Mon, 2 Sep 2002 15:59:07 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
To: partmaps@vortex.physik.uni-konstanz.de,
 Gerd Knorr <kraxel@bytesex.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19(-pre5) problems

On Mon, 2 Sep 2002 partmaps@vortex.physik.uni-konstanz.de wrote:
> Hi,

Hi Max,

> I have a few problems here moving up from a 2.4.18 (which is working well).
> Hope this will be useful to somebody.

yes, thanks for your mail.

>...
> 2.4.19-pre5 (make oldconfig again) fails to compile with an obscure
> undefined reference. (see output below.)
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

