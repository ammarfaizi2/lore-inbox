Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbRENNBD>; Mon, 14 May 2001 09:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261238AbRENNAw>; Mon, 14 May 2001 09:00:52 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:43968 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261217AbRENNAi>; Mon, 14 May 2001 09:00:38 -0400
Message-ID: <3AFFD5B1.82678220@uow.edu.au>
Date: Mon, 14 May 2001 22:55:13 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Juri Haberland <juri@koschikode.com>
CC: r.verhees@chello.nl, linux-kernel@vger.kernel.org
Subject: Re: 3c900 card and kernel 2.4.3 <
In-Reply-To: <20010504203107.DVQ23593.amsmta01-svc@[192.168.2.1]> <20010514111251.32556.qmail@babel.spoiled.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Haberland wrote:
> 
> r.verhees@chello.nl wrote:
> > Hi there,
> >
> > when i install kernel 2.4.3 or higher on my slackware
> > system the card (3c900) gets detected but doesn't do
> > anything, i also get the line "using NWAY 8" or something
> > like that (had to switch back to 2.4.2 to type e-mail)
> > wondered if anyone else had this problem and if there's
> > some way to solve it?
> 
> Hi Ronnie,
> 
> did you receive any answer?
> 
> Do you use 10Base2 (aka cheaper net)?
> I do and after upgrading to 2.4.3 (I think) I had to force the driver to
> use the BNC connector though the card was configured (via the little config
> program supplied by 3com) to always use the BNC connector...
> This way I lost several hours to figure out why it wasn't working anymore and
> to discover that I have to build it as a module instead of having it compiled
> into the kernel because I couldn't make it work with kernel options - only
> with driver options...
> Any suggestions?

Yes, sorry.

The problem with earlier kernels was that autoselection
would notice the lack of 10baseT link beat and would then
advance on to trying AUI/SQE/10base2/etc.  None of these
interfaces allow the driver to know if there's anything
connected and the driver consequently gets stuck on that
interface.  The net effect: if you unplug the 10baseT
the driver gets stuck and you have to reboot.

So autoselection was turned off if the NIC was found
to have autonegotiation hardware.  If you want to use
the other interfaces, you have to provide an option,
as described in Documentation/networking/vortex.txt.

For non-modular drivers things are less easy.  If you
want to force it to use 10baseT (if_port zero) then
it should work OK if you cheat and use mem_start=0x400.
So `ether=0,0,0x400'.

For BNC, it should work just fine with `ether=0,0,1'.
If it doesn't, please shout at me.   Compile the
driver with `static int vortex_debug = 7;' at line
183 and send me the boot logs.

Thanks.


-
