Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWBBBTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWBBBTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWBBBTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:19:32 -0500
Received: from ns2.suse.de ([195.135.220.15]:19128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161071AbWBBBTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:19:31 -0500
From: Neil Brown <neilb@suse.de>
To: linux-kernel@vger.kernel.org
Date: Thu, 2 Feb 2006 12:19:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17377.24090.486443.865483@cse.unsw.edu.au>
Subject: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules at least)
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been testing md/raid in 2.6.16-rc1-mm4 on a dual Xeon with most
of the md personalities compiled as modules, and weird stuff if
happening.

In particular I'm getting lots of 

    BUG: atomic counter underflow at:

reports in raid10 and raid5, which are modules.

I reverted to 2.6.16-rc1-mm2, which still has that BUG check, but
doesn't muck about with the LOCK prefix, and the "atomic" problems go
away (leaving me to look into the other problems of my own making:-).

My guess is there is there is something wrong with the 'alternative'
stuff which strips out the lock prefix, but I couldn't see anything
obviously wrong.  The CPUs don't have FEATURE_UP (see below) so it
cannot possibly be removing the 'lock' prefix... but it certainly acts
like it is.

Help?

NeilBrown



processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 4
cpu MHz         : 3192.524
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni monitor ds_cpl cid xtpr
bogomips        : 6389.26

