Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277299AbRJECPs>; Thu, 4 Oct 2001 22:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277300AbRJECPh>; Thu, 4 Oct 2001 22:15:37 -0400
Received: from imo-d07.mx.aol.com ([205.188.157.39]:63977 "EHLO
	imo-d07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S277299AbRJECP2>; Thu, 4 Oct 2001 22:15:28 -0400
Date: Thu, 04 Oct 2001 22:14:29 EDT
From: Telford002@aol.com
Subject: PCI Device Setup Question
To: <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Message-ID: <66.154deb31.28ee7185@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just joined the mailing list and have
a quick question about the PCI Device Setup
logic.  I apologize if this is not the right
forum.

I am writing a multifunction driver for the
Aurora serial cards.  The driver supports 
asynchronous TTYs, synchronous TTYs and a 
sort of serial ethernet emulation as a network
device.  A port may act either as a serial TTY
or as a serial network device, and in fact if
the system is set up for dial up networking,
the synchronous serial network interface is
first brought up by sending commands to the
corresponding asynchronous call out device.

These cards have 4 or 8 synchronous/asynchronous 
ports on each card which hosts either 1 sab82538 or 
2 sab82532 serial interface chips.  These cards use 
the PLX9050 PCI interface chip to communicate with 
the PCI bus.  Aurora also supplies a PCI extender chassis so that one slot can support 7 of either 
type of cards, i.e. up to 56 ports per slot.  The
PCI extender chassis has two DC21150 PCI-PCI
bridges.

The cards are never masters and do no support
PCI PREFETCH and if PCI transactions are made
to them that relate to PCI PREFETCH, they become
confused and hang.  DC21150s try to be really
smart about PREFETCH and push the PREFETCH related
transactions to the limit and therefore drive the
cards insane if any of the cards memory resources
is prefetchable (the cards use base address 0 for
PLX9050 registers and base address 2 for the 
sab8253x registers).  The PCI bus driver allocates
the sab8253x registers as prefetchable memory
resources.  I see no comments in the changelogs
indicating that anyone has run into the problem. 
I intend to fix the problem but I would like to
chat with someone that is knowledgeable about the
subsystem first.  So I am curious if anyone on the
list can point me toward someone who is "in charge"
of this subsystem.

As a sort of secondary almost unrelated question,
I am not sure whether I should treat the Aurora
card driver as a network device driver or as a
TTY driver in the kernel build tree.  I have created
a special directory for it under the path 
drivers/net/wan/8253x.

Thanks in advance for any assistance!

Joachim Martillo



