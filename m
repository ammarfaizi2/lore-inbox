Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265363AbSJRRlG>; Fri, 18 Oct 2002 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSJRRjv>; Fri, 18 Oct 2002 13:39:51 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:52651 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265277AbSJRRjW>;
	Fri, 18 Oct 2002 13:39:22 -0400
Date: Fri, 18 Oct 2002 18:47:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCHSET 1/25] add support for PC-9800 architecture (apm)
Message-ID: <20021018174720.GA3884@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Osamu Tomita <tomita@cinet.co.jp>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021019015619.A1516@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019015619.A1516@precia.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 01:56:19AM +0900, Osamu Tomita wrote:
 > This patchset adds support for NEC PC-9800 architecture, against 2.5.43.
 > Fixed bad things commented by Russell King.
 > 
 > PC-9800 series machines are made by NEC. But sold only in japan.
 > Formaly, they were best sellers in japan.
 > We port linux for PC-9800 since 2.1.57.
 > 
 > I'm testing 2.5.43 with this patchset on some boxes.
 > - PC-9800 i586 UP with IDE drive
 > - PC-9800 i686 SMP with SCSI drive
 > - AT compatible with IDE drive (patch applied but not set CONFIG_PC9800).
 > They works well.
 > We are doing our best, patchset has no effect on original without configuring
 > for PC-9800.
 > Please apply this patchset.

The biggest sticking point as far as I'm concerned with this patchset
is the source readability after applying it.
Something really needs to be done about the #if pollution this
patch adds before it's ready for inclusion. The whole patchset adds
over 700 #if's/ifdefs/ifndefs.

In a lot of cases you even do this..

+#ifdef PC9800
+	unsigned long foo
+#endif

	...

+#ifdef PC9800
+ code using foo
+#endif

where foo could have been moved inside a {} section in the ifdef
which is using it.   This is one of the simpler cases, there's
also a whole bunch of stuff where you don't even need ifdefs at all
(around #defines for example)

I see you've gone to the effort of making sure the generated code
is the same if PC9800 support is compiled out, which is good.
The next step is to get the source clean enough that those that
don't care about PC9800 don't have to hurt their eyes untangling
a web of #if's.
		
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
