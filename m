Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTCEG1c>; Wed, 5 Mar 2003 01:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTCEG1c>; Wed, 5 Mar 2003 01:27:32 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:18397 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S262871AbTCEG1b>; Wed, 5 Mar 2003 01:27:31 -0500
Date: Wed, 5 Mar 2003 01:38:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Local APIC support interacting badly with cardbus/orinoco
Message-ID: <20030305063801.GB25599@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been tracing a problem where my wavelan card causes lockups on my
thinkpad X20 laptop.

2.5.58 by itself can't load the cardbus modules, but after applying the
cardbus.c patch from 2.5.59 it works fine. 2.5.59 was broken in other
fun ways, but pulling the kernel/module.c changes out of 2.5.60 makes it
at least not Oops during boot. However, bringing up the wireless network
causes the system to lock up within a couple of minutes, where the code
seems to think that the cardbus card was removed.

Disabling "Local APIC support on uniprocessors" (X86_UP_APIC) seems to
solve the problem and 2.5.59 doesn't lock up at all. The most
interesting part of this is that with Local APIC configured the
following shows up in dmesg,

Mar  4 23:42:55 mentor kernel: Local APIC disabled by BIOS -- reenabling.
Mar  4 23:42:55 mentor kernel: Could not enable APIC!

Which made me think that the APIC code wasn't used, so I don't know how
any changes in that area could be responsible for the cardbus/orinoco
flakiness.

Jan

