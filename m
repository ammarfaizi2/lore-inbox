Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbTFZDZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 23:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbTFZDZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 23:25:35 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24588 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265383AbTFZDZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 23:25:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Crusoe's performance on linux?
Date: 25 Jun 2003 20:39:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bddptk$gqc$1@cesium.transmeta.com>
References: <3EF1E6CD.4040800@thai.com> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EF67AD4.4040601@thai.com>
By author:    Samphan Raruenrom <samphan@thai.com>
In newsgroup: linux.dev.kernel
>
> Vojtech Pavlik wrote:
> > Could you a test just for me? Take vanilla 2.4.21 and then
> > make oldconfig; make dep; time make bzImage 
> > That's basically what I want to know how long will take, since
> > it's one of the most common time consuming tasks the thing will
> > have to handle.
> Done! Here're the results:-
> 
> Desktop - Pentium III 1 G Hz 754 MB	->	10.x min.
> Tablet PC - Crusoe TM5800 1 GHz 731 MB	->	17.x min.
> 
>  From freshdiagnos benchmack, the TPC has about 2x faster RAM.
> I use tmpfs for the whole process so disk speed didn't count.
> Both test run without X or any foreground process using
> 2.4.21-ac1 and RedHat kernel.
> 

For what it's worth, we have been completely unable to reproduce these
kinds of results at Transmeta; our results are in fact very consistent
with the numbers reported by some people for the Sharp MM-10 "Kitty"
which is also a 1 GHz TM5800; all of them have been in the 10 minute
ballpark.

I have written a script to try to give a consistent compile benchmark;
however, one still needs to make sure that DMA is turned on (hdparm -d
/dev/hda); obviously, the compiler etc should not be on NFS.

The timed portion (make -j3 bzImage) part of this script takes
10m15.035s real time (user 9m10.890s, sys 0m43.350s) on my 1067 MHz
Crusoe prototype system (256MB SDR, 256MB DDR, ATA33 disk) -- don't
have TC1000 Tablet PC numbers yet, but I have asked someone to run it
-- running RedHat 9 including distro kernel and gcc 3.2.2.  It
produced a bzImage file that's 1151608 bytes long when I ran it.

Note that it uses "make -j3" for the bzImage, and so aren't really
comparable to your times listed above.

You obviously need to point the KERNEL variable at a suitable copy of
linux-2.4.21.tar.gz.  The script needs to run as root in order to
create the tmpfs.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
