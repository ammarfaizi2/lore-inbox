Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291593AbSBMLki>; Wed, 13 Feb 2002 06:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291599AbSBMLk2>; Wed, 13 Feb 2002 06:40:28 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:1728 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S291593AbSBMLkS>;
	Wed, 13 Feb 2002 06:40:18 -0500
Date: Wed, 13 Feb 2002 12:42:03 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: SMT, again (was: Re: [PATCH]: Fix MTRR handling on HT CPUs)
In-Reply-To: <Pine.LNX.4.33.0201251237470.1871-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0202131228290.11012-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just found out that Intel specifies that on SMT-enabled
("Jackson") systems the BIOS MP tables list only the physical CPUs.
Logical CPUs will only be available through the ACPI tables.

See http://www.intel.com/technology/hyperthread/platform_nexgen/,
  in particular sld014.htm, sld021.htm.

This will basically obsolete the patch we were discussing, if BIOS
manufacturers comply to that spec, because linux will only see the
2 physical CPUs. (The problem we discovered was caused by our BIOS not
complying to the spec).

Of course, it would also mean that Linux will only run on ~70% of the CPU
power that Win2k/XP systems will have available on such systems.

All my attempts to get ACPI running on our SMT-enabled system have failed
so far (I'm working on a bug report on that for linux-acpi).

A possible workaround would be the "processor affinity algorithm"
sketched in sld021.htm, but it may be unreliable because it overrides
BIOS settings (BIOS-diabled CPUs) that are available only through ACPI.

Sorry to bother if you knew this already.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





