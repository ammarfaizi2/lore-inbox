Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264640AbRFPSQF>; Sat, 16 Jun 2001 14:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264641AbRFPSPz>; Sat, 16 Jun 2001 14:15:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:16653 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264640AbRFPSPk>; Sat, 16 Jun 2001 14:15:40 -0400
Date: Sat, 16 Jun 2001 11:15:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Eric Smith <eric@brouhaha.com>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com, mj@ucw.cz
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <E15BKPA-0008O7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0106161111041.9713-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Jun 2001, Alan Cox wrote:
>
> > core should be more than just the kissing cousins they are now.  OTOH I
> > still don't like how much we trust firmware PCI bus setup on x86..
> 
> The BIOS may make assumptions we dont know about such as the bus layout. What
> minimises the problem is effectively to validate the firmware provided PCI
> setup and if its crap, then do the job ourselves. That minimizes the problems
> 
> Hence I think it should not be a define but an __init validator for the bus
> setup

Yes.

Regardless, it would certainly make sense to have a manual override, with
a kernel command line. If for no other reason than to allow for mistakes
and let the user force the old/new behaviour.

So the #define should be a variable with a kernel command line override,
along with a heuristic for the kernel to do a good guess on its own (and
the heuristic should probably not be as global as the current
"pcibios_assign_all_busses()" test - the heuristic will be able to tell on
a bridge basis on whether that bridge may need assignment. This might
imply giving the "pcibios_assign_all_busses()" thing the "dev" as an
argument).

		Linus

