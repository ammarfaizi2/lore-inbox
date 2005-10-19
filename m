Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVJSJrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVJSJrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 05:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbVJSJrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 05:47:53 -0400
Received: from mail.fccps.cz ([195.146.112.10]:35332 "EHLO mail.fccps.cz")
	by vger.kernel.org with ESMTP id S964773AbVJSJrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 05:47:52 -0400
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: linux-kernel@vger.kernel.org
Date: Wed, 19 Oct 2005 11:54:49 +0200
MIME-Version: 1.0
Subject: SuperMicro X6DHE-XG2 + 2x Irwindale in 2.4 SMP
Message-ID: <43563409.14883.7715A8DB@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear everyone,

I'd like to report what seems to be a minor SMP misbehavior in the 
2.4 kernel. I can't really say if it's related to the kernel or to 
the "distro" that I'm using. Please consider this message just a 
vague problem report if it's not much use for debugging.

My hardware:
SuperMicro X6DHE-XG2 motherboard (i7520 + 2x PHX)
BIOS versions 1.2c and 1.3a (a flavour of Phoenix server BIOS)
2x Intel XEON Irwindale (2 MB L2) @ 3.4 GHz
2 or 4 GB DDR2 ECC REG (Kingston)
SuperMicro SC823T-R500LP (500W redundant PSU)

I had an opportunity to test six pieces of this setup, all of them 
behaved the same.
The final configuration also contained some RAID controllers and disk 
drives, but I was able to narrow down the problem to the 
aforementioned set of hardware by removing everything else.

Symptoms:

If I try to boot my custom live CD with a 2.4 P4 SMP kernel, it hangs 
during user-space SysV init, usually while starting xinetd, but 
sometimes even earlier, while mounting the key partitions. The system 
stops doing anything (the boot process hangs), numlock gets stuck, 
keyboard stops responding.
There's no panic, nor any other message from the kernel.

The Live CD is based on RedHat 8 components, combined with a 
selection of vanilla kernel binaries, compiled for different CPU's. 
I've been using 2.4.28 for my stress tests for a long time now, but 
I've reproduced this particular problem with 2.4.32-rc1.

The live CD otherwise works fine on many different sorts of hardware 
from 486 through Pentium, Geode, Via C3, UP/SMP P-III, AMD and P4 to 
UP/SMP Xeons.

If I choose a UP kernel (486 to P4), the culprit system boots and 
works fine. Only P4 SMP and P-III SMP kernels fail to boot.

If I leave only one physical CPU in the system, it boots fine
with an SMP kernel (and can see 2 logical CPU cores).

Using pci=noacpi or acpi=off doesn't help - only the APIC 
initialization messages become somewhat different, if memory serves.

I myself have tested the X6DH*-XG2 motherboards in the past with dual 
Xeon Nocona (1 MB L2) CPU's and they always worked without a hint of 
unstability at full throttle in SMP mode - that was BIOS 1.2c and 
1.3a, and even the troublesome 1.2a (that didn't work in FreeBSD 
5.4).

This particular culprit setup is briliant under W2K3 Server, Windows 
XP and FreeBSD 5.4. Fedora Core 4 with the original 2.6.9 kernel 
can't install in 32bit mode, but if I replace that original kernel on 
the installer CD with a fresh 2.6.13, it seems to work fine, too. The 
vanilla 2.6.13, as well as the FreeBSD 5.4, only complain once during 
boot about an interrupt storm - but then the system works without any 
problem.
(I seem to recall that FC4 used to install just fine, out of the box, 
on a dual-Nocona machine with that same motherboard.)

To sum up, I don't know whether to blame the Irwindale (vs. Nocona), 
something within the SuperMicro BIOS, or some part of the 2.4 kernel.

The people at SuperMicro have been very kind and provided some 
helpful hints - yet they haven't been able to solve my marginal issue 
under Linux 2.4.

Unfortunately I don't possess those machines anymore, they've been 
shipped to a customer who runs Windows on them.

I've you've read this far, thanks for your attention :-)

Frank Rysanek

