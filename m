Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135976AbRASAWt>; Thu, 18 Jan 2001 19:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRASAWi>; Thu, 18 Jan 2001 19:22:38 -0500
Received: from 148-ZARA-X12.libre.retevision.es ([62.82.225.148]:18693 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S135817AbRASAWb>;
	Thu, 18 Jan 2001 19:22:31 -0500
Message-ID: <3A674160.A6621B8C@zaralinux.com>
Date: Thu, 18 Jan 2001 20:17:52 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.75 [es] (X11; U; Linux 2.4.1-pre7 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Dominik Kubla <dominik.kubla@uni-mainz.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors
In-Reply-To: <Pine.GSO.3.96.1010117120527.22695A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" escribió:
> 
> On Wed, 17 Jan 2001, Dominik Kubla wrote:
> 
> > Just switched to 2.4.0-ac9 (+crypto patches) on our Dual-Pentium MMX
> > webserver yesterday.  Works fine so far, except i keep seeing those
> > APIC erros (about 14 in 12 hrs) indicating receive, send and CS errors.
> >
> > Should i be concerned?
> 
>  At this volume I would treat this as a warning but not a critical issue.
> Inter-APIC messages get retransmitted in case of an error, but the
> checksum circuit is not sophisticated -- a double-bit error might pass
> unnoticed leading to a system unstability under certain conditions.  At
> such a low volume of errors double-bit ones are not likely to happen.
> 
>  It's the first report of APIC errors on a P5 system I have seen, so it's
> probably not a result of a bad motherboard design.  I'd recommend to check
> if the system doesn't get overheated.  You may also be unlucky to have a
> faulty board.
> 
>   Maciej
> 

Hey, it's not the first, some time ago when it began to be reported a
lot of people with various systems asked at the same time about the same
thing :)

I have a dual p200mmx in a Gigabyte 586DX mobo with 96Mb + Voodoo 3
2000pci, Realtek 8139 nic, bt848 tv...

And I usually get a lot of these messages:

[coma@quartz coma]$ cat /proc/interrupts 
           CPU0       CPU1       
  0:     801148     819848    IO-APIC-edge  timer
  1:       7576       7691    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:          0          4    IO-APIC-edge  soundblaster
  8:          1          0    IO-APIC-edge  rtc
  9:       4358       4347    IO-APIC-edge  eth1
 12:     124492     126503    IO-APIC-edge  PS/2 Mouse
 14:     206324     201592    IO-APIC-edge  ide0
 15:    1593094    1593085    IO-APIC-edge  ide1
 17:     785989     785945   IO-APIC-level  eth0
 18:        402        433   IO-APIC-level  bttv
NMI:    1620906    1620904 
LOC:    1620963    1620962 
ERR:       2697
[coma@quartz coma]$ uptime 
  8:14pm  up  4:30,  0 users,  load average: 0.19, 0.11, 0.09

but my system works ok, mostly, now I have just upgraded a Realtek 8029
(10Mb) because it gets hung to a Realtek 8139 (100Mb) just to found the
mobo has some kind of busmastering problems, but that's another story.

P.D. And as you suggested it runs very hot, about 50ºC at the cpus when
both are at full use.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
