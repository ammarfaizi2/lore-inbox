Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285290AbRLNBUX>; Thu, 13 Dec 2001 20:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285303AbRLNBUN>; Thu, 13 Dec 2001 20:20:13 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:38410
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S285290AbRLNBUH>; Thu, 13 Dec 2001 20:20:07 -0500
Date: Thu, 13 Dec 2001 20:30:39 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: FWD: NAT question
Message-ID: <20011213203038.A24189@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this on the netfilter list with no responces.

I'm currently using ipchains on 2.2.19 to do masquerading.  I have a static
IP on dialup.  I have my ip-up/down scripts to add/remove masq entries when
I drop/establish the ppp link.  All connections that I have going do continue
to work when the ppp link is dropped and reconnected.  I'm assuming this
works because the default timeout (15 minutes) on the masq'd connection is
still there.

I've been looking at both SNAT and MASQUERADE targets for ipfilter (2.4.x
obviously)

SNAT is fine provided I don't need to dialup to another ISP (for instance
when my current isp is having temporary problems).  If I remove the SNAT
entry, all connections that has hit the SNAT table were remembered.  when I
remove the entry, those connections still work and new connections (same
source/dest host/port) also work.  If I were to remove the current SNAT entry
(ppp drops) and add another SNAT entry (ppp comes back up) but I used a
different ISP this time.  Will those connections still attempt to use the old
entry or will it realize a new entry has been added and work the way as I had
intended?  I haven't tried, but is it possible that if the rule (say
changing the SNAT source address) is changed for it to drop currently SNAT'd
connections?

I thought about using MASQUERADE but if the interface goes down, all
connections that were already established are dropped so that when the link
comes back up, it won't continue, but if I dialup another ISP, then
everything is ok.

I would prefer to use SNAT.  Other than removing the iptable_nat module, is
there anyway to make netfilter forget at connections that have already been
seen?  

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
