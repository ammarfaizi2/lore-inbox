Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVCNAge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVCNAge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCNAge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:36:34 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:12466 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261605AbVCNAg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:36:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16948.56475.116221.135256@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 11:36:43 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
In-Reply-To: <9e473391050312075548fb0f29@mail.gmail.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU>
	<9e473391050312075548fb0f29@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:

Jon> On Fri, 11 Mar 2005 14:36:10 +1100, Peter Chubb
Jon> <peterc@gelato.unsw.edu.au> wrote:
>>  As many of you will be aware, we've been working on infrastructure
>> for user-mode PCI and other drivers.  The first step is to be able
>> to handle interrupts from user space. Subsequent patches add
>> infrastructure for setting up DMA for PCI devices.

Jon> I've tried implementing this before and could not get around the
Jon> interrupt problem. Most interrupts on the x86 architecture are
Jon> shared.  Disabling the IRQ at the PIC blocks all of the shared

Fortunately, most interrupts on IA64, ARM, etc.,  are unshared.  And
with PCI-Express, the problem will go away.  Even on X86, things
aren't all bad: one can usually find a PCI slot which doesn't share
interrupts with anything you care about.

The scenario I'm thinking about with these patches are things like
low-latency user-level networking between nodes in a cluster, where
for good performance even with a kernel driver you don't want to share
your interrupt line with anything else.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
