Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132760AbREEP0K>; Sat, 5 May 2001 11:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbREEP0A>; Sat, 5 May 2001 11:26:00 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:29679 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S132760AbREEPZw>; Sat, 5 May 2001 11:25:52 -0400
Message-Id: <l03130309b719c8b64c56@[192.168.239.105]>
In-Reply-To: <E14w3Ff-0000iz-00@the-village.bc.nu>
In-Reply-To: <l03130306b719ba7ef592@[192.168.239.105]> from "Jonathan
 Morton" at May 05, 2001 03:19:15 PM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 5 May 2001 16:17:53 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Athlon and fast_page_copy: What's it worth ? :)
Cc: hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        bergsoft@home.com (Seth Goldberg), linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:41 pm +0100 5/5/2001, Alan Cox wrote:
>> My wild guess is that with the "faster" code, the K7 is avoiding loading
>> cache lines just to write them out again, and is just writing tons of data.
>> The PPC G4 - and perhaps even the G3 - performs a similar trick
>> automatically, without special assembly...
>
>X86 has done that since the K5 era.
>
>No the main thing that the mmx copier does is to read and write in 64bit
>wide chunks

Just for the record, this can be done on any PPC, by using the FPU
registers (which are much faster than x86 FPU).  AltiVec can do 128-bit
wide transfers.

>and then more importantly to prefetch pending data.

That's a tougher one.  AltiVec (in the G4) can do this, but I suspect it
can be emulated using the pipeline on earlier PowerPCs, by queueing up a
line of FPU load instructions and then a queue of FPU saves.  However, the
601 and 603 don't have a superscalar FPU, though I wonder if that would
actually affect a simple load/store operation.

This is rapidly getting offtopic, though...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


