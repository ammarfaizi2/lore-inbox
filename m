Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUAXJ22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 04:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266897AbUAXJ22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 04:28:28 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:15640 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S266896AbUAXJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 04:27:44 -0500
From: "Emmanuel Hislen" <hislen@mindspring.com>
To: "Hugo Mills" <hugo-lkml@carfax.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: SiI2112 + Seagate + nFroce2: no DMA!
Date: Sat, 24 Jan 2004 01:27:24 -0800
Message-ID: <IEEHKGFDFPBODOHJKGLIKEIJCAAA.hislen@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20040120085800.GB31330@carfax.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hugo,

I have re-installed my machine with Fedora Core 1 (thinking a newer version
than RH9 would make the jump to 2.4.24 or 2.6 easier), and this fixed the
DMA issue :-)

Now my SATA drive is running stable in UDMA6.

However, performance is still way below expectations.

I got a huge improvement: my disc read speed (hdparm -t) went from 1.3 to 25
MB/sec.
This is still slower than my PATA drive on my 3 years old AMD 900 PC running
Redhat 9.0 (around 35 MB/sec).

Could you please let me know what you are getting so I know what to expect?


My next step is to try 2.4.24 or 2.6.1 as you suggested, but googling around
a little bit before I do so I found out a few worrying things:

- people have reported a drop in performance on SATA in some 2.6 based
kernel (2.6.0-test9), with reported speeds around 20MB/sec. Apparently there
is no more way to tune max_kb_per_req in 2.6??
- I have found reports that both ide and libdata libraries are limiting
max_kb_per_req to 15 Kb specifically for Seagate drives. So It looks like I
can't even set it to 128 (I did not even try as I saw reports of memory
corruption).

So basically since you've got it to work I'd like to know:

* what speed you get, and what is the RPM of your Seagate
* what is your max_kb_per_req setting (I have 15K)
* what is your accoustic management setting (I have 0)


I could not fix the time on linux so I am sending this mail from WinXP (just
kidding I lost my mails on the linux machine after re-installing :-).


Thanks,


Emmanuel.



-----Message d'origine-----
De : Hugo Ranger Mills [mailto:hrm@carfax.org.uk]De la part de Hugo
Mills
Envoye : Tuesday, January 20, 2004 12:58 AM
A : manu
Cc : linux-kernel@vger.kernel.org
Objet : Re: SiI2112 + Seagate + nFroce2: no DMA!


On Tue, Dec 31, 2002 at 09:55:59PM -0800, manu wrote:

   Incidentally, did you know that the date on your computer is very,
very wrong?

> I'm about to give up on my SATA drive as I can't get it to work properly.
> So I thought I may try asking the experts before falling back to PATA.
>
> I have seen many mails reporting the same issue, some of them 6-month old:
>
> - SATA drive comes up in pio mode, not in dma
> - trying to turn on dma with hdparm is a nightmare: I/O errors, crash
> with data corruption... I tried both:
>
>  hddarm -d1 /dev/hde
>
> and:
>
>  hdparm -u1 -c3 -d1 -X66 /dev/hde
>
> crash in both cases :-((
>
>
> Here's my equipment:
>
>
> ABIT AN7 motherboard (nForce2 chipset, SiI3112 SATA controller)
> AMD Athlon XP 2600+ (+ 512 DDR / 400 MHz)
> SATA HD Seagate Barracuda 160 Gb
>
> The SATA HD is my only drive. The only thing connected to my IDE
> controllers is a DVD/CD combo.
>
> Running Linux Redhat 9.0
> kernel 2.4.20-28.9
  ^^^^^^^^^^^^^^^^^^
   This is your problem. There have been a number of bug-fixes to the
SiI drivers since 2.4.20. Try it again with a newer kernel -- such as
2.4.24.

> I've been googling for days now and could not come accross a solution,
> on the contrary I came under the impression that the combination of
> SiI3112 +and Seagate was doomed.

   Not so. I have a SiI3112 controller and a 120GiB Seagate drive, and
they work very well together. I'm using 2.6.1, although 2.4.23 also
worked well for me.

[snip]
> Isn't there a solution??
>
> I am willing to try patches of experimental code. At this point I am
> looking at reinstalling everything on a PATA drive anyway, so  I have
> nothing to loose.

   Try using 2.4.24 or 2.6.1.

   Hugo.

--
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
           --- All hope abandon,  Ye who press Enter here. ---

