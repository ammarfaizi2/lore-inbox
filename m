Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRKTG2c>; Tue, 20 Nov 2001 01:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKTG2W>; Tue, 20 Nov 2001 01:28:22 -0500
Received: from [196.28.7.2] ([196.28.7.2]:19146 "HELO netfinity.realnet.co.sz")
	by vger.kernel.org with SMTP id <S280938AbRKTG2A>;
	Tue, 20 Nov 2001 01:28:00 -0500
Date: Tue, 20 Nov 2001 08:17:30 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: MP FP struct in the EBDA
Message-ID: <Pine.LNX.4.33.0111200814170.30806-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just noticed the following comment in mpparse.c:find_intel_smp

"If it is an SMP machine we should know now, unless the
configuration is in an EISA/MCA bus machine with an extended bios data
area."

I'd presume this statement isn't true today, e.g. one of the IBM Netfinity
boxes here (3500M20) has the MP tables in the EBDA. Also how come we
search the whole EBDA (4k)? Whilst the MP 1.4 spec sheet says search the
first kilobyte only.

<--snip-->
address = *(unsigned short *)phys_to_virt(0x40E);
address <<= 4;
smp_scan_config(address, 0x1000);
<--snip-->

The FreeBSD (4.3-REL) MP probe code also only searches the first K
(mp_machdep.c:mp_probe)

if ((segment = (u_long) * (u_short *) (KERNBASE + 0x40e)) != 0) {
	/* search first 1K of EBDA */
	target = (u_int32_t) (segment << 4);
	if ((x = search_for_sig(target, 1024 / 4)) >= 0)
		goto found;

Just Curious,
	Zwane Mwaikambo


