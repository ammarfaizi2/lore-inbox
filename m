Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbTFCQgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265088AbTFCQgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:36:23 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:33162 "EHLO
	quadxeon.emperorlinux.com") by vger.kernel.org with ESMTP
	id S265087AbTFCQgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:36:21 -0400
Subject: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
From: Lincoln Durey <lincoln@EmperorLinux.com>
To: LKML <linux-kernel@vger.kernel.org>, Kent E Yoder <yoder1@us.ibm.com>,
       Burt Silverman <burts@us.ibm.com>, Bradford Jones <brad1@us.ibm.com>,
       Alexandre =?ISO-8859-1?Q?Tr=E9panier?= <atrepani@ca.ibm.com>,
       Ken Aaker <kdaaker@rchland.vnet.ibm.com>,
       Janice Girouard <girouard@us.ibm.com>, Robert Finn <finnr@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>,
       Martin List-Petersen <martin@list-petersen.dk>,
       Greg KH <greg@kroah.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Jon maddog Hall <maddog@li.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 03 Jun 2003 12:49:34 -0400
Message-Id: <1054658974.2382.4279.camel@tori>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This item (and more generally the precedent it sets) will soon have a
disastrous effect on the Linux community, even though it is not
_directly_ a Linux problem.

Most of you have seen my LKML posting: (most of the tech details)
http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1538.html
"IBM T40 _refusing_ to boot with "unauthorized" mini-PCI wifi card"

As I gather more info, it becomes clear that the IBM T40 has a TCPA chip
in it with a "white list" of _allowed_ cards.  Apparently IBM has made a
_policy_ decision to disallow any wifi card not on the list. (more
below).  In doing this they have (perhaps unknowingly) severely limited
the usefulness of the entire T40 (and X31 by extension) laptop lines for
the many users of the Linux OS on those IBM systems.  Surely this was
not intentional....

The solution is a very simple removal of the white list from the BIOS.
_telling_ your customers what they may or may not put in a standard PC
expansion slot at the BIOS level (regardless of OS) is going to be a
disaster...

In reply to my e-mail of 5-30, titled:  (and my replies to them)
"IBM T40 _refusing_ to boot with "unauthorized" mini-PCI wifi card"

Kent E Yoder <yoder1@us.ibm.com> (512) 838-8397 writes:
> (I'm copying Janice here, who is the network device driver lead in
> the LTC, perhaps she can be of more assistance.)  Its really
> surprising that there would be this limitation though.  The fact that
> it says "unauthorized" seems suspect here, since I doubt there's just
> a list of cards you can install...  I see this model has a TCPA chip
> in it; if you've turned that on, you might want to install the card
> and then clear the TCPA ship.  Let me know if this works...

I've tried several variations on this theme, to no avail.  The TCPA chip
was initially not activated, and the 1802 error occurs.  Activating the
chip, and then clearing its settings (all via the BIOS) does nothing.
If the "IBM High Rate Wireless" (22P7701) is in the system, you get the
1802 error before you can even access the BIOS.

So, there indeed must be a "white list" (of what can be put in a
standard expansion slot!)

Burt Silverman <burts@us.ibm.com> writes:
> Sorry I have no experience with any Wireless cards at this point in
> time, and I have not seen this problem with much older PC cards that
> I used to use.
> Tim, do you know if anybody follows ThinkPad/Linux issues and that
> monitors problem areas like this? There used to be someone named
> Keith Frechette, but I cannot locate him in the directory.

PCMCIA cards are not affected, because we all _know_ these are for
peripheral expansion.  But we also all know that mini-PCI is also a
technology to allow expansion of laptops.

Bradford Jones <brad1@us.ibm.com> writes:
> Unfortunately I have not been with the SWAT team for 3yrs, but based
> on what I know from working with development, I can tell you that
> unless you are specifically using one of the min-PCI cards listed as
> a supported option, that is the error you can expect to see. This may
> be in part because of certain FCC regulations regarding wi-fi and
> specifically 802.11a. For instance when the T40 was released, the FCC
> would not allow us to make mini-PCI cards using 802.11a technology
> customer accessible or customer upgradeable.  This regulation does not
> apply to 802.11b, but there could be some other underlying reason for
> only allowing tested options to be installed. I cannot be sure though
> and will forward your inquiry to the current SWAT team.

I don't want the card to be "supported" by IBM, I just want the card
"authorized".  Linux already has support for prism2 cards, but will not
have 802.11a or 802.11g support in the foreseeable future (and only "a"
and "g" cards are on the white list).

Greg KH <greg@kroah.com> writes:
> Heh, sorry, I can't really help you out there.  I have no contacts
> within the thinkpad division, and neither does anyone else within the
> LTC that I know of.  The official statement is that the thinkpad
> division does not support Linux at all.

Again, the Linux community doesn't need support, just authorization.

> That being said, that is really a strange thing for the BIOS to do.
> I'll ask about it on an internal ibm linux mailing list and will let
> you know if anyone responds with anything.

The key thing to keep in mind is that while the affects Linux users
rather adversely, it is really a BIOS and _policy_ issue.  This would
happen if one got a T40 with winXP and put in any 802.11b card.

Alexandre Trépanier <atrepani@ca.ibm.com> (450) 534-7540 writes:
> It's not in my area of expertise but I took time to look in the
> intranet and I found nothing.

well Alex, perhaps you can paste this whole letter in...

	-- Lincoln @ EmperorLinux


