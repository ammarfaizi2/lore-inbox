Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSG2WQn>; Mon, 29 Jul 2002 18:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318077AbSG2WQn>; Mon, 29 Jul 2002 18:16:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54280 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318069AbSG2WQK>;
	Mon, 29 Jul 2002 18:16:10 -0400
Date: Mon, 29 Jul 2002 23:19:27 +0100
From: Matthew Wilcox <willy@debian.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [parisc-linux] 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Message-ID: <20020729231927.D3317@parcelfarce.linux.theplanet.co.uk>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <20020729181702.E25451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020729181702.E25451@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Jul 29, 2002 at 06:17:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 06:17:02PM +0100, Russell King wrote:
> 3. /dev/ttyS*, /dev/ttySA*, /dev/ttyCL*, /dev/ttyAM*, etc
> ---------------------------------------------------------
> 
> All the above are serial ports of various types.  It has been expressed
> several times that people would like to see all of them appear as
> /dev/ttyS* (indeed, there was an, erm, rather heated discussion about
> it a couple of years ago.)  I'm going to be neutral on this point
> here.

I'm not.  All the issues you mention below go away if we make the rule
that _all_ serial ports are /dev/ttyS*.  Userspace can have symlinks to
ease the transition if necessary.

> c. People with many serial ports.  We _could_ change the device number
>    allocations such that ttyS gobbles up the ttySA, ttyCL, ttyAM, etc
>    device numbers so we end up with the same number of port slots
>    available for those with many many serial ports in their machines.

Yep, there really are people with >256 serial ports.  It'd be nice to
support them.  Does anything care about the mapping from device name
to char minor?  I suspect the MAKEDEV maintainer will come and squash
me if i suggest moving the mapping for the first 192 serial devices,
but we should be able to reclaim:

Chase serial card (major 17/18), the Cyclades (major 19/20), Digiboard
(major 22/23), Stallion (major 24/25), Specialix (32/33), isdn4linux
(43/44), Comtrol (46/47), SDL RISCom (48/49), Hayes (57/58), Computone
(71/72), Specialix (75/76), PAM (78/79), Comtrol VS (105/106), ISI
(112/113), Technology Concepts (148/149), Specialix RIO (154/155/156/157),
Chase Research (164/165), ACM (166/167), Moxa (172/173), SmartIO
(174/175), USB (188/189), Low-density misc serial ports (204/205),
userspace (208/209) BlueTooth (216/217), A2232 (224/225) ... holy crap,
that's a lot of char dev space ;-)  52 majors.. think what those must
be worth on the open market ;-)

My only real objection (and it's a problem we have at the moment!) is
that serial ports then become like ethernet interfaces.  Add or remove a
card and everything changes number.  Somehow we already survive with this.
I was very careful when adding a new SIIG 4-port serial card to my console
server the other day to notice which card was first in PCI bus scan
order and make sure all my existing machines were hooked up to that one.

The solution to this has to be to name devices by PCI bus ID, but this is
an argument for an entirely different thread ;-)

-- 
Revolutions do not require corporate support.
