Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266624AbUGKR36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUGKR36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 13:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUGKR36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 13:29:58 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:3014 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266624AbUGKR3z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 13:29:55 -0400
Message-ID: <b8bf377804071110291e61d19b@mail.gmail.com>
Date: Sun, 11 Jul 2004 14:29:47 -0300
From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ck] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Cc: Con Kolivas <kernel@kolivas.org>,
       ck kernel mailing list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040711143853.GA6555@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20040709182638.GA11310@elte.hu>
	<20040709195105.GA4807@infradead.org>
	<20040710124814.GA27345@elte.hu> <40F0075C.2070607@kolivas.org>
	<40F016D9.8070300@kolivas.org> <20040711064730.GA11254@elte.hu>
	<40F14E53.2030300@kolivas.org> <20040711143853.GA6555@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, can anyone explain this:

Using Ingo's first patch when I:
echo 1 > /proc/sys/kernel/kernel_preempt

my system hang up after 2 seconds aproximately.

Using Ingo's modifications + Con's it doesn't lock anymore 

and is the best kernel that I have used to test..

Thanks!


On Sun, 11 Jul 2004 16:38:53 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
> 
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> > Ok I've done one better than that ;) I had wli help make some
> > instrumentation for me to help find the remaining non preemptible
> > kernel portions and set the cutoff to 2ms. Here is what I found:
> >
> > 7ms non-preemptible critical section violated 2 ms preempt threshold
> > starting at reiserfs_sync_fs+0x2d/0xc2 and ending at reiser
> > fs_lookup+0xe2/0x221
> >
> > 9ms non-preemptible critical section violated 2 ms preempt threshold
> > starting at reiserfs_dirty_inode+0x37/0x10e and ending at r
> > eiserfs_dirty_inode+0xb0/0x10e
> >
> > These seem to be the two offenders. Hope this helps.
> 
> great!
> 
> meanwhile i spent an afternoon with another latency testing suite:
> 
>   http://www.alsa-project.org/~iwai/latencytest-0.5.3.tar.gz
> 
> it was reporting more accurate latencies, except that there were strange
> spikes of latencies. It turned out that for whatever reason, userspace
> RDTSC is not always reliable on my box (!).
> 
> I've attached two fixes against latencytest - one makes rdtsc timestamps
> more reliable, the other one fixes an SMP bug in the kernel module (it
> would lock up under SMP otherwise.).
> 
> here's a latencytest QuickStart: 'cd latencytest; make', then
> 'insmod kernel/latency-test.ko', then 'cd tests; ../bin/run_tests'.
> 
> Assuming you have RTC and audio enabled in your kernel it should work
> fine. It produces PNGs in the same format as Benno's latencytest suite.
> 
>         Ingo
> 
> 
> 


-- 
[]s,

André
