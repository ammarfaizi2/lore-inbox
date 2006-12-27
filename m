Return-Path: <linux-kernel-owner+w=401wt.eu-S932840AbWL0OhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbWL0OhU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 09:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932945AbWL0OhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 09:37:20 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54122 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932840AbWL0OhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 09:37:19 -0500
Date: Wed, 27 Dec 2006 15:37:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Knoblauch <knobi@knobisoft.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to detect multi-core and/or HT-enabled CPUs in 2.4.x and
 2.6.x kernels
In-Reply-To: <666716.84435.qm@web32603.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.61.0612271528580.10556@yvahk01.tjqt.qr>
References: <666716.84435.qm@web32603.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 27 2006 06:16, Martin Knoblauch wrote:
>
> So far it seems that looking at the "physical id", "core id" and "cpu
>cores" of /proc/cpuinfo is the way to go.

Possibly, but it does not catch all cases. 

$grep '"physical id' /erk/kernel/linux-2.6.20-rc2/ -r

returns exactly three lines, for 
/erk/kernel/linux-2.6.20-rc2/arch/i386/kernel/cpu/proc.c 
/erk/kernel/linux-2.6.20-rc2/arch/ia64/kernel/setup.c 
/erk/kernel/linux-2.6.20-rc2/arch/x86_64/kernel/setup.c

So what'cha doing about, say, sparc64? Here is its procinfo of a 
standard SMP one:

15:31 ares:~ # cat /proc/cpuinfo
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
prom            : OBP 3.30.0 2003/11/11 10:37
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0Bogo        : 800.49
Cpu0ClkTck      : 0000000017d78400
Cpu1Bogo        : 800.05
Cpu1ClkTck      : 0000000017d78400
MMU Type        : Spitfire
State:
CPU0:           online
CPU1:           online


> In 2.6 I would try to find the  distinct "physical id"s and  and sum
>up the corresponding "cpu cores". The question is whether this would
>work for 2.4 based systems.
>
> Does anybody recall when the "physical id", "core id" and "cpu cores"
>were added to /proc/cpuinfo ?

Why don't you check it out? 2.4.34 only has the "physical id" string for 
x86_64. It does not seem to have CONFIG_SCHED_SMT at all. (Time to leave 
the dead horse alone.)


	-`J'
-- 
