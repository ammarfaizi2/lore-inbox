Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315190AbSEHVU3>; Wed, 8 May 2002 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315194AbSEHVU2>; Wed, 8 May 2002 17:20:28 -0400
Received: from vpl.usc.edu ([128.125.21.202]:52096 "EHLO vpl.usc.edu")
	by vger.kernel.org with ESMTP id <S315190AbSEHVU0>;
	Wed, 8 May 2002 17:20:26 -0400
Date: Wed, 8 May 2002 14:20:14 -0700
From: Joaquin Rapela <rapela@usc.edu>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 sound problem
Message-ID: <20020508142014.A1665@plato.usc.edu>
In-Reply-To: <20020507215024.B11180@plato.usc.edu> <20020508095713.1f661dd1.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kristian,

I am using a scsi adapter ADAPTEC AIC-7896. The scsi is using irq 10 and the
sound card irq 11:

[root@plato rapela]# cat /proc/interrupts 
CPU0       
0:     511053          XT-PIC  timer
1:       1665          XT-PIC  keyboard
2:          0          XT-PIC  cascade
8:          1          XT-PIC  rtc
9:      29691          XT-PIC  eth0
10:     345860          XT-PIC  aic7xxx, aic7xxx
11:        654          XT-PIC  es1371
12:      17839          XT-PIC  PS/2 Mouse
NMI:          0 
ERR:          0

Just for fun I tried "options es1371 irq=5 dma=1" in /etc/modules.conf but I
cannot change the irq mapping of es1371.

>From what I read from /var/log/messages the frozen state concludes when the
module unloads:

May  8 12:08:39 vpl kernel: ac97_codec: AC97 Audio codec, id: 0x4352:0x5903
(Cirrus Logic CS4297)
May  8 12:09:39 vpl kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 1, lun 0 Read (10) 00 00 ec 53 27 00 00 08 00
May  8 12:10:39 vpl kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 1, lun 0 Write (10) 00 00 00 17 bf 00 00 10 00
May  8 12:10:39 vpl kernel: (scsi0:0:1:0) SCSISIGI 0x4, SEQADDR 0x162, SSTAT0
0x2, SSTAT1 0x3
May  8 12:10:39 vpl kernel: (scsi0:0:1:0) SG_CACHEPTR 0x2, SSTAT2 0x0, STCNT 0x0
May  8 12:10:39 vpl kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 2, lun 0 Write (10) 00 00 2f db ab 00 00 02 00
May  8 12:11:00 vpl kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 1, lun 0 Read (10) 00 00 08 01 d7 00 00 08 00
May  8 12:11:00 vpl kernel: es1371: unloading
May  8 12:11:05 vpl kernel: es1371: version v0.30 time 17:36:47 Sep  6 2001
May  8 12:11:05 vpl kernel: es1371: found chip, vendor id 0x1274 device id
0x1371 revision 0x08

Finally, the sndconfig utility adds the following lines to /etc/modules.conf:

alias sound-slot-0 es1371
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1
|| :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1
|| :  

If you come up with any suggestiong I will greatly appreciate it.

Thanks for your reply, Joaquin

On Wed, May 08, 2002 at 09:57:13AM +0200, Kristian Peters wrote:
> Joaquin Rapela <rapela@usc.edu> wrote:
> > sndconfig tells reports an Ensoniq|ES1371 [AudioPCI-97]
> > 
> > After my machine recovers from the frozen stage I read the following in
> > /var/log/messages:
> > 
> > May  7 21:34:58 plato kernel: scsi : aborting command due to timeout : pid 0,
> > scsi0, channel 0, id 0, lun 0 Write (10) 00 01 05 aa 19 00 00 26 00 
> 
> It seems that there're Interrupt conflicts with your scsi-controller and your sound card. Please try to add irq=5 (or any other free irq you have) when loading the module oder add "options es1371 irq=5 dma=1" to your modules.conf. That should work.
> 
> *Kristian
> 
>   :... [snd.science] ...:
>  ::                             _o)
>  :: http://www.korseby.net      /\\
>  :: http://gsmp.sf.net         _\_V
>   :.........................:
