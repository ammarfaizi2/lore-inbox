Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTAEUZD>; Sun, 5 Jan 2003 15:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAEUZD>; Sun, 5 Jan 2003 15:25:03 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:22159 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265065AbTAEUZD>;
	Sun, 5 Jan 2003 15:25:03 -0500
Date: Sun, 5 Jan 2003 21:33:37 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301052033.VAA07415@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: 2.5 SYSENTER context-switch overhead on P4 :-(
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've measured the cost of the two wrmsr()'s added to the
context-switch path to support SYSENTER in 2.5 kernels.
Here's the data (clock cycles, averaged):

CPU			wrmsr	only	only
type			both	cs	esp
----			----	---	---
P4 2.4GHz (Xeon)	1722	860	863
P4 1.7GHz (Willamette)	1642	816	817
P3 800MHz (Coppermine)	 158	 76	 76
P3 450MHz (Katmai)	 216	105	105
P2 233MHz (Deschutes)	 176	 88	 88
P2 233MHz (Klamath)	 150	 75	 75

The other implementation with keeps the MSRs constant and
uses a trampoline stack might be a better alternative.

/Mikael
