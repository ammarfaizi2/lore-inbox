Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271466AbRHPEgg>; Thu, 16 Aug 2001 00:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271461AbRHPEg0>; Thu, 16 Aug 2001 00:36:26 -0400
Received: from zero.tech9.net ([209.61.188.187]:4107 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S271463AbRHPEgM>;
	Thu, 16 Aug 2001 00:36:12 -0400
Subject: [PATCH] Optionally let Net Devices feed Entropy
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 00:36:43 -0400
Message-Id: <997936615.921.22.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(patches will be attached in subsequent emails.  there is a set for
2.4.9-pre4 and another for 2.4.8-ac5.  Patch #1 includes the core code
changes, configure changes, etc.  Patch #2 includes some updated network
drivers).

Its a long standing debate whether to allow network drivers to
contribute to the kernel entropy pool.  This e-mail is not to convince
anyone of anything, but give users a choice.

Right now, a very small number of network devices add to /dev/random.
The majority of them don't, presumably because of the fear of an
external attacker manipulating the kernel entropy pool.

The following patches allow the user to configure at compile-time
whether or not network devices should be allowed to feed the pool.  For
those of us who don't fear external attackers, this is a nice addition
of entropy.  It is also useful for those who are on a headless system
and need some more sources of entropy.

A new configure statement is available in Network Devices.  Enabling it
enables CONFIG_NET_RANDOM which sets a new request_irq flag,
SA_SAMPLE_RANDOM_NET.  If enabled, that flag is defined as
SA_SAMPLE_RANDOM.  If disabled, the flag is defined as 0.  Thus there is
no additional code after compile.

The idea, then, should be to add SA_SAMPLE_RANDOM_NET to each network
devices request_irq call.

Patch #2 does this for some devices: 3c501, 3c505, 3c509, 3c523, 3c59x,
8139too, cs89x0, eepro, eepro100, eexpress, ibmlana, ne2k-pci, pcnet_cs,
xircom_tulic_cb, sk_mca, smc9194, tulic_core, and wavelan.  All of the
devices which already contribute entropy have been updated.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

