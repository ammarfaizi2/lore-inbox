Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSCXMlT>; Sun, 24 Mar 2002 07:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSCXMlJ>; Sun, 24 Mar 2002 07:41:09 -0500
Received: from fungus.teststation.com ([212.32.186.211]:9491 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S287631AbSCXMkz>; Sun, 24 Mar 2002 07:40:55 -0500
Date: Sun, 24 Mar 2002 13:40:45 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.teststation.com
To: Ivan Gurdiev <ivangurdiev@yahoo.com>
cc: Andy Carlson <naclos@andyc.dyndns.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Via-Rhine stalls - transmit errors
In-Reply-To: <20020321052039.11197.qmail@web10108.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0203241231250.30731-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Ivan Gurdiev wrote:

> > Here is a patch the Urban Widmark originally came up
> > with for 2.4.17, 
> > and I retrofitted to 2.4.18.  I do not know if it 
> > will patch vs 2.4.19-pre3:
> 
> It does. However the problem persists.
> I changed the default debug value to 7 again.

That patch was an attempt to fix failed transmission and it contains all
sorts of junk. It worked for Andy, but not for one of the others with that
problem (and that motherboard, a Dragon+ with on-board eth chip).

You probably shouldn't use that patch at all ...


VIA has drivers for VT86c100A, the VT6102 and the VT6105, available here:
http://www.viaarena.com/?PageID=71

They are all obviously derived from the Donald Becker and the in-kernel
driver and are as such GPL, even if there is no mention of any license.
(someone should probably talk to VIA about that ...)


What you could do is:
a) Try those drivers instead and see if any one works better.
   The 6105 driver should work with the older chips too.

b) Start moving bits of code from those drivers to the kernel driver.
   The drivers have lots of "if vt3065 do this" comments, and then they
   flip some bit that you couldn't have guessed needed flipping ...

   I think there is very little chance of you frying your controller by
   doing this.

   But watch out for the multiple entry points, they support 2.2 and 2.4
   by having both old and new init code.


There is also the Donald Becker driver at http://www.scyld.com/

There is an explanation of common "something wicked" errors on
http://www.scyld.com/network/ethercard.html

001a would be
  0010 "Transmit FIFO underrun" = Slow or busy PCI bus
  0008 "Transmit error" = Transmit aborted because of excessive collisions

So if you trust the explanations of the errors it could just be something
with cable/hub/switch or a fun PCI error. I know some have solved their
001a's by switching slots for their cards.


> The opposite side repeatedly logs:
> eth0: lost link beat
> eth0: found link beat
> eth0: autonegotiation complete: 100BaseT-FD selected

You had a "VT86c100A"?  I think this is a bug in that patch where it
misdetects link changes or something. There were ideas on changed meaning
of an interrupt bit (0x0200) and the "fix" for that is probably causing
this.

The other main idea for Andy's problem was that the initial tx threshold
should be increased. The 6105 driver has code that allows you to set the
default as a module parameter, which could be useful.

/Urban

