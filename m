Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTCENHO>; Wed, 5 Mar 2003 08:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTCENHO>; Wed, 5 Mar 2003 08:07:14 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:38863 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S267153AbTCENHL>;
	Wed, 5 Mar 2003 08:07:11 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15973.63728.763833.140185@gargle.gargle.HOWL>
Date: Wed, 5 Mar 2003 14:17:36 +0100
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Local APIC support interacting badly with cardbus/orinoco
In-Reply-To: <20030305063801.GB25599@delft.aura.cs.cmu.edu>
References: <20030305063801.GB25599@delft.aura.cs.cmu.edu>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes writes:
 > I've been tracing a problem where my wavelan card causes lockups on my
 > thinkpad X20 laptop.
 > 
 > 2.5.58 by itself can't load the cardbus modules, but after applying the
 > cardbus.c patch from 2.5.59 it works fine. 2.5.59 was broken in other
 > fun ways, but pulling the kernel/module.c changes out of 2.5.60 makes it
 > at least not Oops during boot. However, bringing up the wireless network
 > causes the system to lock up within a couple of minutes, where the code
 > seems to think that the cardbus card was removed.
 > 
 > Disabling "Local APIC support on uniprocessors" (X86_UP_APIC) seems to
 > solve the problem and 2.5.59 doesn't lock up at all. The most
 > interesting part of this is that with Local APIC configured the
 > following shows up in dmesg,
 > 
 > Mar  4 23:42:55 mentor kernel: Local APIC disabled by BIOS -- reenabling.
 > Mar  4 23:42:55 mentor kernel: Could not enable APIC!
 > 
 > Which made me think that the APIC code wasn't used, so I don't know how
 > any changes in that area could be responsible for the cardbus/orinoco
 > flakiness.

The message means that you have one of those mobile P6 processors
where Intel actually removed the local APIC.
(`grep flags /proc/cpuinfo` should not contain "apic" in your case.)

So the local APIC really isn't being enabled or used, and any
instability is caused by something else.

Please try 2.5.63 or .64 instead. Your 2.5.58/.59/.60 hybrid is
getting old, and your mixing of stuff may itself cause problems.
