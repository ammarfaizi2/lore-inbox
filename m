Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272533AbRIRWWg>; Tue, 18 Sep 2001 18:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272552AbRIRWW0>; Tue, 18 Sep 2001 18:22:26 -0400
Received: from acl.lanl.gov ([128.165.147.1]:27142 "HELO acl.lanl.gov")
	by vger.kernel.org with SMTP id <S272533AbRIRWWV>;
	Tue, 18 Sep 2001 18:22:21 -0400
Date: Tue, 18 Sep 2001 16:22:44 -0600 (MDT)
From: Ronald G Minnich <rminnich@lanl.gov>
X-X-Sender: <rminnich@snaresland.acl.lanl.gov>
To: <linux-kernel@vger.kernel.org>
cc: <linuxbios@lanl.gov>
Subject: LinuxBIOS + ASUS CUA + 2.4.5 works; with 2.4.6 locks up
Message-ID: <Pine.LNX.4.33.0109181612380.28482-100000@snaresland.acl.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the scenario. We have LinuxBIOS working fine with 2.4.5 on an ASUS
CUA mainboard (Acer M1631 TNT2 northbridge, m1535d southbridge). It boots
to multiuser and works fine. All versions of linux from 2.4.0 to 2.4.5
also work.

If we upgrade to 2.4.6 we see the 'Posix compliance by Unifix' (or
whatever) message and then ... that's it. The machine appears to lock up.
Testing with the ICE shows that it is repeatedly going to address
0xfefe0c0, or similar (it varies). Note that is 7 digits of hex, not 8:
it's not going after high PCI or BIOS memory, we think.

It does appear to get through creating the kernel_thread for init, and we
think it might be dying when it goes idle, but we're not sure.

We sometimes get into the kernel thread for init and can single step it
into pci setup. At some point however the machine will again lock up. The
last POST code is 97.

THe 0xfefec00 address is suspicious. Is there any APIC (NOT ACPI, I mean
IO-APIC) change that came into 2.4.6? Is there any way the kernel could be
trying to call the BIOS for some reason (we have APM etc. OFF). Does
anyone have a hint at what we could look at? FWIW, we have run this kernel
under linuxbios on other boxes. It only fails on the Acer, and only for
2.4.6 and later (we've tested up to 2.4.9).

Thanks in advance.

ron

