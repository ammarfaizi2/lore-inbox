Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVAUMTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVAUMTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVAUMTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:19:38 -0500
Received: from smtp4.netcabo.pt ([212.113.174.31]:64943 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S262348AbVAUMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:19:33 -0500
Message-ID: <1728.195.245.190.93.1106299090.squirrel@195.245.190.93>
In-Reply-To: <874qhb99rv.fsf@sulphur.joq.us>
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org>
    <873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org>
    <87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org>
    <87oefkd7ew.fsf@sulphur.joq.us>
    <10752.195.245.190.93.1106211979.squirrel@195.245.190.93>
    <65352.195.245.190.94.1106240981.squirrel@195.245.190.94>
    <874qhb99rv.fsf@sulphur.joq.us>
Date: Fri, 21 Jan 2005 09:18:10 -0000 (WET)
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt    
      scheduling
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Jack O'Quin" <joq@io.com>
Cc: "Con Kolivas" <kernel@kolivas.org>, "linux" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com, "CK Kernel" <ck@vds.kolivas.org>,
       "utz" <utz@s2y4n2c.de>, "Andrew Morton" <akpm@osdl.org>,
       alexn@dsv.su.se
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Jan 2005 12:19:32.0039 (UTC) FILETIME=[76315570:01C4FFB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack O'Quin wrote:
>
> [...] Looking at the graph, it appears that your DSP load is hovering
> above 70% most of the time.  This happens to be the default threshold
> for revoking realtime privileges.  Perhaps that is the problem.  Try
> running it with the threshold set to 90%.  (I don't recall exactly
> how, but I think there's a /proc/sys/kernel control somewhere.)
>

It would be nice to know which one really is :) Here are what I have here:

# grep . /proc/sys/kernel
/proc/sys/kernel/bootloader_type:2
/proc/sys/kernel/cad_pid:1
/proc/sys/kernel/cap-bound:-257
/proc/sys/kernel/core_pattern:core
/proc/sys/kernel/core_uses_pid:1
/proc/sys/kernel/ctrl-alt-del:0
/proc/sys/kernel/debug_direct_keyboard:0
/proc/sys/kernel/domainname:(none)
/proc/sys/kernel/hostname:lambda
/proc/sys/kernel/hotplug:/sbin/hotplug
/proc/sys/kernel/kernel_preemption:1
/proc/sys/kernel/modprobe:/sbin/modprobe
/proc/sys/kernel/msgmax:8192
/proc/sys/kernel/msgmnb:16384
/proc/sys/kernel/msgmni:16
/proc/sys/kernel/ngroups_max:65536
/proc/sys/kernel/osrelease:2.6.11-rc1-RT-V0.7.35-01.0
/proc/sys/kernel/ostype:Linux
/proc/sys/kernel/overflowgid:65534
/proc/sys/kernel/overflowuid:65534
/proc/sys/kernel/panic:0
/proc/sys/kernel/panic_on_oops:0
/proc/sys/kernel/pid_max:32768
/proc/sys/kernel/printk:3	4	1	7
/proc/sys/kernel/printk_ratelimit:5
/proc/sys/kernel/printk_ratelimit_burst:10
/proc/sys/kernel/prof_pid:-1
/proc/sys/kernel/sem:250	32000	32	128
/proc/sys/kernel/shmall:2097152
/proc/sys/kernel/shmmax:33554432
/proc/sys/kernel/shmmni:4096
/proc/sys/kernel/sysrq:1
/proc/sys/kernel/tainted:0
/proc/sys/kernel/threads-max:8055
/proc/sys/kernel/unknown_nmi_panic:0
/proc/sys/kernel/version:#1 Mon Jan 17 15:15:21 WET 2005

My eyes can't find anything related, but you know how intuitive these
things are ;)


>
> [...]  The old problem with more than 14 clients has been
> fixed.  I routinely run 30 or 40 without trouble.
>

Yes, but that is with (old) jack_test3 where clients were stand-alone,
without being connected to anyother. With (new) jack_test4, each client
gets all its inputs connected to all the output ports of the preceding
one. In my experience, with this (new) setup you achieve a much greater
workload with a lesser number of running clients.

If seems funny, but highly suspicious, that in both of my machines, a
P4@2.5Ghz/UP laptop and a P4@3.3Ghz/SMP desktop, the limit is somewhat the
same: jackd stops responding as soon the 15th client enters the chain.

Currently on jackd 0.99.47 (cvs), but I'm quite sure that was occurring
before.


> Perhaps we're running out of some port resource?
>

Probably. That was what I thought and then worked around by increasing the
maximum number of ports jackd preallocates (-p/--port-max option), but I
guess it is not enough. It was on jack_test3, but it isn't for jack_test4.

Go figure ;)

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

