Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310610AbSCPUib>; Sat, 16 Mar 2002 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCPUiZ>; Sat, 16 Mar 2002 15:38:25 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:18884 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310610AbSCPUhn>;
	Sat, 16 Mar 2002 15:37:43 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.44228.577059.711997@napali.hpl.hp.com>
Date: Sat, 16 Mar 2002 12:36:20 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <davidm@hpl.hp.com>, <yodaiken@fsmlabs.com>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203161144340.31971-100000@penguin.transmeta.com>
In-Reply-To: <15507.41057.35660.355874@napali.hpl.hp.com>
	<Pine.LNX.4.33.0203161144340.31971-100000@penguin.transmeta.com>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 16 Mar 2002 11:58:22 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> I used to be a sw fill proponent, but I've grown personally
  Linus> convinced that while sw fill is good, it needs a few things:

Glad to see you're coming around! ;-)

  Linus>  - large on-chip TLB to avoid excessive trashing (ie
  Linus> preferably thousands of entries)

  Linus>    This implies that the TLB should be split into a L1 and a
  Linus> L2, for all the same reasons you split other caches that way
  Linus> (and with the L1 probably being duplicated among all memory
  Linus> units)

Yes, Itanium has a two-level DTLB, McKinley has both ITLB and DTLB
split into two levels.  Not quite as big though: "only" on the order
of hundreds of entries (partially offset by larger page sizes).  Of
course, operating the hardware walker in hashed mode can give you an
L3 TLB as large as you want it to be.

  Linus>  - ability to fill multiple entries in one go to offset the
  Linus> cost of taking the trap.

The software fill can definitely do that.  I think it's one area where
some interesting experimentation could happen.

	--david
