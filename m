Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263371AbUJ2PDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUJ2PDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUJ2O7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:59:20 -0400
Received: from mail.gmx.de ([213.165.64.20]:14289 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263395AbUJ2Owl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:52:41 -0400
X-Authenticated: #4399952
Date: Fri, 29 Oct 2004 17:09:49 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041029170949.04d68ecf@mango.fruits.de>
In-Reply-To: <20041029142538.GC25204@elte.hu>
References: <20041027205126.GA25091@elte.hu>
	<20041027211957.GA28571@elte.hu>
	<33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	<20041028063630.GD9781@elte.hu>
	<20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	<20041028085656.GA21535@elte.hu>
	<26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	<20041028093215.GA27694@elte.hu>
	<43163.195.245.190.94.1098981230.squirrel@195.245.190.94>
	<20041029163135.1886d67f@mango.fruits.de>
	<20041029142538.GC25204@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 16:25:38 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > ksoftirqd/0:
> > mango:~# chrt -p 2
> > pid 2's current scheduling policy: SCHED_FIFO
> > pid 2's current scheduling priority: 99
> 
> dont do this ... ksoftirqd can spend alot of time processing various
> stuff and it should not be relevant to the audio path. It should be
> SCHED_OTHER.

ah ok, i was wondering about this.. i saw it in rui's setup [SCHED_FIFO with
high prio]. Doesn't seem to make a difference though on first sight. still
xruns plenty above 1ms. 

playback only or rmmod'ing the network adapter driver or using the dummy
soundcard driver instead of snd-cs46xx doesn't make a difference either.

after rmmoding the network card driver i saw:

sis900 0000:00:03.0: Device was removed without properly calling
pci_disable_device(). This may need fixing.

in m dmesg. rmmod'ing snd-cs46xx gives me:

Sound Fusion CS46xx 0000:00:0f.0: Device was removed without properly
calling pci_disable_device(). This may need fixing.

too, so maybe i have already hit a BUG in the kernel and this screwed up all
further test results.

Will build a kernel with debugging stuff to see what's up. I'll also build a
VP only version to see if i still get these pci_disable_device() messages
with a "more vanilla" kernel ;)

flo
