Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSEILbg>; Thu, 9 May 2002 07:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSEILbf>; Thu, 9 May 2002 07:31:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:19435 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315709AbSEILbe>; Thu, 9 May 2002 07:31:34 -0400
Date: Thu, 9 May 2002 13:26:34 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: alsa-devel@alsa-project.org
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ALSA .text.exit compile errors in 2.5.14-dj2
Message-ID: <Pine.NEB.4.44.0205091306270.19321-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while trying to compile a non-modular 2.5.14-dj2 kernel I got the
following ALSA-related .text.exit errors at the final linking:


<--  snip  -->

...
sound/sound.o: In function `snd_card_es968_probe':
sound/sound.o(.text.init+0x22222): undefined reference to `local symbols
in discarded section .text.exit'
sound/sound.o: In function `alsa_rme9652_mem_init':
sound/sound.o(.text.init+0x2b78a): undefined reference to `local symbols
in discarded section .text.exit'
sound/sound.o(.data+0x36fd4): undefined reference to `local symbols in
discarded section .text.exit'
...

<--  snip  -->

The problems are

In sound/isa/sb/es968.c:
snd_card_es968_probe isn't __exit (more exactly it's __init) but it calls
snd_card_es968_free that is __exit

In sound/pci/rme9652/rme9652_mem.c:
alsa_rme9652_mem_init isn't __exit (more exactly it's __init) but it calls
rme9652_free_buffers that is __exit


I'm not sure whether removing the __exit is the right solution or whether
there's a better solution.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

