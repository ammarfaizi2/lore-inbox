Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTHUBIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTHUBIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:08:45 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:40621
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id S262371AbTHUBIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:08:41 -0400
X-Mailbox-Line: From galia@st-peter.stw.uni-erlangen.de  Thu Aug 21 03:08:38 2003
Message-ID: <1061428118.3f441b964576c@secure.st-peter.stw.uni-erlangen.de>
Date: Thu, 21 Aug 2003 03:08:38 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Fwd: Re: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Svetoslav Slavtchev <galia@st-peter.stw.
uni-erlangen.de> -----
    Date: Thu, 21 Aug 2003 02:55:13 +0200 (CEST)
    From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Reply-To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
 Subject: Re: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
      To: Duncan Laurie <duncan@sun.com>

Quoting Duncan Laurie <duncan@sun.com>:

> > first test run of 2.6 on Epox 8k9a3+ VIA KT400 VT8235,
> > HPT374 and 4 IBM Deskstar GXP120 80Gb on each chanel as master
> > Mandrake-cooker gcc-3.3.1
> >
> > the 3rd and the 4th chanel of the HPT374 are saying that the used 
> > cable is 40 wires, so it forces the drives in UDMA33 which i think
> > causes the lock-ups several seconds after booting in runlevel 1
> 
> Here is a patch (against 2.6.0-test3) for the cable detect problem
> on the 3rd/4th channels of the hpt374.  This same patch made its
> way into 2.4 via the -ac tree but hasn't been put in 2.6 yet.
> 
> It fixes some cable detect issues that stem from the fact that the
> cable detect pins are also used as address/data lines, so they need
> to first be configured as inputs to read valid cable detect state.
> 
> For everything from the 370 to function 0 of the 374:
>   bit 0 of register 0x5b must be cleared in order to make the
>   SCBLID/MA15 and PCBLID/MA16 pins as input.
> 
> For the 374 third/fourth channels (function 1):
>   bit 15 of register 0x52 and bit 15 of register 0x56 must be
>   set for TCBLID/MD6 and FCBLID/MD1 pins to be input.
> 
> I'm not sure it will actually help with your lockups, but at least
> things will be detected right...
> 
> -duncan
> 
> 

Thanks a lot that seems to fix also the lock ups :)

acording to the config.help in 2.4 HPT do not support ATAPI devices
and not a long ago there were reports for lock-ups on promise cards
when the drive did suported only UDMA33, so i thought it might be related

i'll check later one the behaviour on "cat /pro/ide/hpt366"
(i broke my install anyway, so i'll have to reinstall, and can do some 
experiments in the mean time )

copied several Gb to LV leaving on soft-raid-5 on the 4 drives,
no problems yet :-)

best,

svetljo 

----- End forwarded message -----


-- 


