Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWGMGvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWGMGvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWGMGvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:51:23 -0400
Received: from quasar.dynaweb.hu ([195.70.37.87]:21736 "EHLO quasar.dynaweb.hu")
	by vger.kernel.org with ESMTP id S1750771AbWGMGvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:51:23 -0400
Date: Thu, 13 Jul 2006 09:01:46 +0200
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: linux-kernel@vger.kernel.org
Subject: Athlon64 + Nforce4 MCE panic
Message-Id: <20060713090146.690d4759.rumi_ml@rtfm.hu>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Tonight I had a kernel panic (full hang) with the following on the console:

CPU 0: Machine Check Exception: 0000000000000004
Bank 4: b200000000070f0f
Kernel panic - not syncing: CPU context corrupt

I tried to decode this:

# ./parsemce -e 0000000000000004 -b 4 -s b200000000070f0f -a 0
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(4): b200000000070f0f @ 0
        External tag parity error
        CPU state corrupt. Restart not possible
        Error enabled in control register
        Error not corrected.
        Bus and interconnect error
        Participation: Generic
        Timeout:
        Request: Generic error
        Transaction type : Invalid
        Memory/IO : Other

# echo 'CPU 0: Machine Check Exception: 0000000000000004 Bank 4: b200000000070f0f' | mcelog --ascii --k8
HARDWARE ERROR. This is *NOT* a software problem!
Please contact your hardware vendor
CPU 0 4 northbridge   Northbridge Watchdog error
       bit57 = processor context corrupt
       bit61 = error uncorrected
  bus error 'generic participation, request timed out
      generic error mem transaction
      generic access, level generic'
STATUS b200000000070f0f MCGSTATUS 4

I've been searching for and found some additional info, it
looks like I'm not the first experiencing this problem:

http://kerneltrap.org/node/4993

Here ^^^ it is suggested that there was some thread about A64 MCEs
on LKML but I failed to find it so I decided to post... sorry if
it's redundant.

The kernel is 2.6.16-gentoo-r9 and the CPU is an A64 "Venice" 3500+
I can post further hw/sw environment information if req'd.

Thanks!

Regards,

Sab
