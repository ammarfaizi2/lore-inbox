Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSEIHeD>; Thu, 9 May 2002 03:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSEIHeC>; Thu, 9 May 2002 03:34:02 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:23633 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S315627AbSEIHeC>; Thu, 9 May 2002 03:34:02 -0400
Date: Thu, 9 May 2002 09:30:17 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: Joaquin Rapela <rapela@usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 sound problem
Message-Id: <20020509093017.79f29936.kristian.peters@korseby.net>
In-Reply-To: <20020508142014.A1665@plato.usc.edu>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joaquin Rapela <rapela@usc.edu> wrote:
> Just for fun I tried "options es1371 irq=5 dma=1" in /etc/modules.conf but I
> cannot change the irq mapping of es1371.

Yes. Seems like that module has not those options.

> From what I read from /var/log/messages the frozen state concludes when the
> module unloads:
> 
> May  8 12:08:39 vpl kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5903
> (Cirrus Logic CS4297)

  ^^^^^^^^^^^^^ 
     Maybe you own a Cirrus Logic soundcard instead ?
     ac97 reports that your soundcard uses a codec from Cirrus L.
     See /usr/src/linux/Documentation/sound/cs46xx maybe
     It could be possible that your sndconfig from RedHat detects a wrong one..

> post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1
> || :
> pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1
> || :  

These entries only save and restore your mixer settings before/after (un)loading sound-slot-0.
So you can try to modprobe cs46xx or cs4232 for a Cirrus Logic Soundcard - but I suspect that this won't work correctly. Or try to load ac97_codec and ac97 only. Those es1371 soundcards have 2 dsps. ;-) But one should be enough for now.

If your model is not a Creative one try to use ES1370. Try lspci -n for that.
The PCI ID "1274:1371" should indicate that your card is from Creative, the ID "1274:5000" incidates that it is from Ensoniq.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
