Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRFHBUE>; Thu, 7 Jun 2001 21:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbRFHBTy>; Thu, 7 Jun 2001 21:19:54 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:8946 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263748AbRFHBTw>; Thu, 7 Jun 2001 21:19:52 -0400
Message-Id: <l03130324b745d584d0c9@[192.168.239.105]>
In-Reply-To: <0106071629171E.32519@compiler>
In-Reply-To: <Pine.LNX.4.21.0106071722450.1156-100000@freak.distro.conectiva>
 <Pine.LNX.4.21.0106071722450.1156-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 8 Jun 2001 02:18:39 +0100
To: Shane Nay <shane@minirl.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
Cc: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:29 am +0100 8/6/2001, Shane Nay wrote:
>(VM report at Marcelo Tosatti's request.  He has mentioned that rather than
>complaining about the VM that people mention what there experiences were.  I
>have tried to do so in the way that he asked.)

>> By performance you mean interactivity or throughput?
>
>Interactivity.  I don't have any throughput needs to speak of.
>
>I just ran a barage of tests on my machine, and the smallest it would ever
>make the cache was 16M, it would prefer to kill processes rather than make
>the cache smaller than that.

http://www.chromatix.uklinux.net/linux-patches/vm-update-2.patch

Try this.  I can't guarantee it's SMP-safe yet (I'm leaving the gurus to
that, but they haven't told me about any errors in the past hour so I'm
assuming they aren't going to find anything glaringly wrong...), but you
might like to see if your performance improves with it.  It also fixes the
OOM-killer bug, which you refer to above.

Some measurements, from my own box (1GHz Athlon, 256Mb RAM):

For the following benchmarks, physical memory availability was reduced
according to the parameter in the left column.  The benchmark is the
wall-clock time taken to compile MySQL.

mem=	2.4.5		earlier tweaks	now
48M	8m30s		6m30s		5m58s
32M	unknown		2h15m		12m34s

The following was performed with all 256Mb RAM available.  This is
compilation of MySQL using make -j 15.

kernel:		2.4.5		now
time:		6m30s		6m15s
peak swap:	190M		70M

For the following test, the 256Mb swap partition on my IDE drive was
disabled and replaced with a 1Gb swapfile on my Ultra160 SCSI drive.  This
is compilation of MySQL using make -j 20.

kernel:		2.4.5		now
time:		7m20s		6m30s
peak swap:	370M		254M

Draw your own conclusions.  :)

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


