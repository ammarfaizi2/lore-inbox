Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314543AbSDSEj7>; Fri, 19 Apr 2002 00:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSDSEj7>; Fri, 19 Apr 2002 00:39:59 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:5129 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314543AbSDSEj6> convert rfc822-to-8bit; Fri, 19 Apr 2002 00:39:58 -0400
Date: Thu, 18 Apr 2002 21:39:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide-2.4.19-p7.all.convert.5.patch
In-Reply-To: <3CBF996D.1070900@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.10204182123450.17538-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One caviate just found ... HPT372 is not ultra 133 friendly.
At least the 1103:0004 rev5 which is the 366 device id.

Currently the HPT37/HPT374 do not like Ultra133.

So patch number 6 will come soon.

Export the error handling to the local personality drivers as proper.

Will now begin adding in the MMIO trasition HOST interface for the future
MMIO/ADMA/VirtualDMA (future is now) support of these devices.

It will generate its own nasty bug reports that will begin to expose the
lack of error recovery paths back to the top layer FS.  

Fix the error recovery to be handled local in the driver and then permit
the goal of partial completions w/ fast/safe path IO's.

Final add in TCQ that has been on hold since 2.3.99-pre6, but requires a
working clean taskfile data-phase handler set to work proper.  The
soft-driver junk will be added after adding the golden jewels of hardware
driven TCQ so using any drive with the new ATA-Bridge support to be
announced later will do it clean.  This is hardware PCI-ATA card is a TOE
for TCQ.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Fri, 19 Apr 2002, [ISO-8859-15] François Cami wrote:

> Andre Hedrick wrote:
> > http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.5.patch.bz2
> > 
> > This now has clean taskfile io tested on two archs.
> > 
> > Both PowerMac UP and x86 all appear stable with taskfile io enabled.
> > PPC well generate a random missed interrupt in mult-mode pio on a sync
> > call but it never misses a beat or hangs.
> > 
> > Feed back from a few people have stated Sparc ?? amnd PPC64 appear stable.
> > 
> > IA-64 is the only know broken arch.  Since returning the heater^WItanic^box 
> > testing various hardware there is not practical.
> > 
> > Cheers and Complain if it does not work.
> 
> Testing begins immediately on 3 different comps (x86) with
> different IDE controllers and hard drives.
> 
> > Andre Hedrick
> > LAD Storage Consulting Group
> 
> I'll report any bugs / unusual behaviour.
> 
> François Cami
> 
> 

