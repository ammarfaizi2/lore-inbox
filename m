Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268007AbRHATPC>; Wed, 1 Aug 2001 15:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbRHATOx>; Wed, 1 Aug 2001 15:14:53 -0400
Received: from lech.pse.pl ([194.92.3.7]:22691 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S267974AbRHATOk>;
	Wed, 1 Aug 2001 15:14:40 -0400
Date: Wed, 1 Aug 2001 21:14:44 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: linux-kernel@vger.kernel.org
Subject: PCI network card detection/initalization order
Message-ID: <20010801211444.A3413@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine (IBM x330) with a dual on-board FastEthernet
card (eepro100) and one additional (3c900) card in one of the
PCI slots. Kernel inits the 3COM card earlier than the Intel
one, assigning eth0 to 3c900 and eth[12] to Etherexpresses.
For a bunch of reasons (making the machine free of the "eth1
becomes eth0 when the additional card is removed" symptom being
one of them) I would like to reverse the initialization order
for the cards - or, to be more exact, make the on-board Intel
cards always detected and initialized first (as eth0 and eth1).
Since this machine has only PCI slots (and I don't really feel
anyone would ever try to attach to it anything like a parport
network card :) I believe in general there are two cases:
(a) another Etherexpress Pro - one or more - inserted into
    PCI slot(s),
(b) another type of NIC - one or more - inserted into PCI slot(s).

I came to conclusion that editing drivers/net/Makefile
and moving "obj-$(CONFIG_EEPRO100) += eepro100.o" entry
towards the start of the section beginnig with "link order
important here" would solve the (b) case. Indeed, when I put
eepro100.o entry before the 3c59x.o one I was able to have
kernel init Intel-based interfaces as eth0 and eth1. And I
believe that in general case (a) is impossible to solve
because it depends on the actual motherboard design/wireing.

Is changing linking order the right way to control initalization
ordering of PCI network cards? Is my assumption about case (a) right?

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
