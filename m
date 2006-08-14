Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbWHNVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbWHNVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWHNVO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:14:26 -0400
Received: from us.cactii.net ([66.160.141.151]:29706 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S932693AbWHNVOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:14:22 -0400
Date: Mon, 14 Aug 2006 23:13:38 +0200
From: Ben B <kernel@bb.cactii.net>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
Message-ID: <20060814211338.GA30680@cactii.net>
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <20060813224413.GA21959@cactii.net> <20060813232549.GG28540@redhat.com> <20060814115556.GA13159@cactii.net> <20060814202004.GE16280@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814202004.GE16280@redhat.com>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> uttered the following thing:
>  > > > [  734.156000]  [<e01f2665>] cpufreq_governor_dbs+0x2b5/0x310 [cpufreq_ondemand]
>  > > 
>  > > This makes no sense at all, because in -mm __create_workqueue doesn't
>  > > call lock_cpu_hotplug().
>  > > 
>  > > Are you sure this was from a tree with -mm1 applied ?
>  > 
>  > Definitely 2.6.18-rc4-mm1, and I've done a clean rebuild + removal of
>  > all modules under /lib/modules beforehand.
> 
> It's a real mystery.  Andrew ?

This seems to be specific to the ondemand governor - I just tried with
conservative, and alternating it with performance, with no problems, but
as soon as I loaded ondemand, the message appeared. It seems to fire off
the message as soon as I either set the governor to ondemand, or revert
it from ondemand to something else. But going from, eg performance to
conservative, wont give the message, even with ondemand loaded.

I wonder if this might also be related to my 1.83GHz cpu only being set
to a maximum of 1.33GHz via cpufreq? cpuinfo_max_freq is correct, but
scaling_max_freq is wrong. Though doing "cat cpuinfo_max_freq >
scaling_max_freq" has fixed it up, it should be correct already.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 14
model name      : Genuine Intel(R) CPU           T2400  @ 1.83GHz
stepping        : 8
cpu MHz         : 1000.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni
monitor
vmx est tm2 xtpr
bogomips        : 3667.27

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 14
model name      : Genuine Intel(R) CPU           T2400  @ 1.83GHz
stepping        : 8
cpu MHz         : 1333.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx constant_tsc pni
monitor
vmx est tm2 xtpr
bogomips        : 3657.79


Ben

