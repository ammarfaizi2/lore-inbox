Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbTCKIRs>; Tue, 11 Mar 2003 03:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262857AbTCKIRs>; Tue, 11 Mar 2003 03:17:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:34136
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262856AbTCKIRr>; Tue, 11 Mar 2003 03:17:47 -0500
Date: Tue, 11 Mar 2003 03:25:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpu-2.5.64-1
In-Reply-To: <Pine.LNX.4.50.0303110213390.29169-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303110222320.29169-100000@montezuma.mastecende.com>
References: <20030311042457.GL465@holomorphy.com>
 <Pine.LNX.4.50.0303110213390.29169-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Mar 2003, Zwane Mwaikambo wrote:

> Have you had an opportunity to test this code yet? If you can't get that 
> large a 32bit SMP box, you could fire off some 'extra' cpus on i386 then 
> fail them during boot around cpu_up, making sure to put the failed cpus 
> somewhere in the middle of your cpu map so that not only do you get a 
> sparse map but some on the other side of 32.

Something crackpot ala;

The new boot process would look something like this (pseudo code as i 
don't know the types you use yet), just watch out for num_booting_cpus 
users.

/* the fake cpus we're going to fire up and fail */
cpumask_t fake_cpu_map = (1 << 13) | (1 << 14) | (1 << 15);

arch/i386/kernel/smpboot.c

smp_boot_cpus() {
	...
	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
	for (bit = 0; bit < NR_CPUS; bit++) {
		if ((1 << bit) & fake_cpu_map))
			set_bit(bit, cpu_callin_map);
		....
	}
}

do_boot_cpu() {
	cpu = ++cpucount;
	if ((1 << cpu) & fake_cpu_map) {
		/* you could probably stop here and set the boot error 
		 * without decrementing the cpucount */
		goto skip_hardware_wakeup_bits;
	}

skip_hardware_wakeup_bits:
	return boot_error;
}

Anyway coffee is wearing off and i must sleep...

	Zwane
-- 
function.linuxpower.ca
