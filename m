Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWAFAnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWAFAnN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWAFAnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:43:13 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:56687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbWAFAnL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:43:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qiYuBYbriJGl7miyIiIPmmFTD4Y28XB5GZZWF0bcY9YPzC7UKOqDtHr2YtgG1juvMvXx9FXFqMw86Loeo7U8af8DSzMzqaDMu9sM2VQLkfASl/V2TLwEI4qBSpda/n5ljmvWUe6TyKU0H+l6TTIo/dxCS7XEzAw5KWcFduyy5z8=
Message-ID: <5bdc1c8b0601051643m1d8cf0b5k8abc6697e281ffb7@mail.gmail.com>
Date: Thu, 5 Jan 2006 16:43:10 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.15-rc7-rt1
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <5bdc1c8b0601051258j3bfc390bsa770ddf6506d2deb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228172643.GA26741@elte.hu>
	 <Pine.LNX.4.61.0512311808070.7910@yvahk01.tjqt.qr>
	 <1136051113.6039.109.camel@localhost.localdomain>
	 <1136054936.6039.125.camel@localhost.localdomain>
	 <5bdc1c8b0601010719h40f2393cu85bae52fef35c1d2@mail.gmail.com>
	 <1136205719.6039.156.camel@localhost.localdomain>
	 <5bdc1c8b0601051133g6ed0b3b4ob699d65e4a12b699@mail.gmail.com>
	 <1136492165.847.9.camel@mindpipe>
	 <5bdc1c8b0601051258j3bfc390bsa770ddf6506d2deb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Mark Knecht <markknecht@gmail.com> wrote:
> On 1/5/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Thu, 2006-01-05 at 11:33 -0800, Mark Knecht wrote:
> > > I expect that I am probably still getting a low level of xruns. I
> > > hope one day we can make that work a bit better.
> >
> > Were you ever able to get latency tracing to work on your box?
> >
> > Lee
>
> Not yet, due to the power failure and being off line. I'll give it a
> shot this evening.
>
> Does anyone with an AMD64 platform have this working?
>
> Thanks,
> Mark
>

Hi Lee,
   OK, I rebuilt the new kernel (2.6.15-rt2) with latency tracing
enabled. I still get xruns when running Jack and Aqualung. The tracing
doesn't show anything new although I do have the IRQ off tracing
turned on and don't see the long timer delays that Iused to see.

   What the following shows is that I have a 14uS delay before
mounting my 1394 audio drive. I mount the drive which goes normally. I
then started Aqualung and am just playing some audio from the 1394
drive. I also start MythTV and am streaming a TV show. Along the way I
get another 14uS delay which is fine. However in the process of doing
that I get a 2.9mS xrun but I see nothing in the latency tracing info.

   I can send along the config file if that would help.

<SNIP>
16:20:45.814 Patchbay deactivated.
16:20:45.891 Statistics reset.
16:20:45.952 MIDI connection graph change.
16:20:46.112 MIDI connection change.
16:20:47.701 JACK is starting...
16:20:47.701 /usr/bin/jackd -R -P80 -p512 -dalsa -dhw:1 -r44100 -p64 -n2
16:20:47.713 JACK was started with PID=7942 (0x1f06).
jackd 0.100.5
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details
JACK compiled with System V SHM support.
loading driver ..
apparent rate = 44100
creating alsa driver ... hw:1|hw:1|64|2|44100|0|0|nomon|swmeter|-|32bit
control device hw:1
configuring for 44100Hz, period = 64 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
16:20:49.730 Server configuration saved to "/home/mark/.jackdrc".
16:20:49.731 Statistics reset.
16:20:49.893 Client activated.
16:20:49.895 Audio connection change.
16:20:49.898 Audio connection graph change.
16:21:41.419 Audio connection graph change.
16:21:41.550 Audio connection change.
16:21:43.684 Audio connection graph change.
subgraph starting at qjackctl-7941 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
16:30:47.171 XRUN callback (1).
16:30:47.171 XRUN callback (2).
**** alsa_pcm: xrun of at least 1.422 msecs
**** alsa_pcm: xrun of at least 2.896 msecs
subgraph starting at qjackctl-7941 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
16:34:40.068 XRUN callback (3).
**** alsa_pcm: xrun of at least 1.196 msecs
**** alsa_pcm: xrun of at least 2.906 msecs
16:34:40.628 XRUN callback (1 skipped).
<SNIP>


(               X-7771 |#0): new 14 us maximum-latency critical section.
  => started at timestamp 165360021: <__schedule+0xb8/0x596>
  =>   ended at timestamp 165360035: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014d79f>{check_critical_timing+479}
<ffffffff803c79e0>{unix_poll+ 0}
       <ffffffff8014db78>{sub_preempt_count_ti+88}
<ffffffff80403c0c>{thread_return+70 }
       <ffffffff80403c7b>{thread_return+181} <ffffffff80403de5>{schedule+261}
       <ffffffff804048ed>{schedule_timeout+141}
<ffffffff8013b2e0>{process_timeout+0}
       <ffffffff8018d237>{do_select+967} <ffffffff8018cd80>{__pollwait+0}
       <ffffffff8018d57d>{sys_select+749} <ffffffff8010dc86>{system_call+126}

  =>   dump-end timestamp 165360140

ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c504e0006463]
scsi4 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 6  Model: Y160P0            Rev: YAR4
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
  sdb: sdb1 sdb2 sdb3
sd 4:0:0:0: Attached scsi disk sdb
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
(               X-7771 |#0): new 14 us maximum-latency critical section.
  => started at timestamp 900866152: <__schedule+0xb8/0x596>
  =>   ended at timestamp 900866166: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014d79f>{check_critical_timing+479}
<ffffffff8014db78>{sub_preemp t_count_ti+88}
       <ffffffff80403c0c>{thread_return+70}
<ffffffff80403c7b>{thread_return+181}
       <ffffffff80403de5>{schedule+261} <ffffffff804048ed>{schedule_timeout+141}
       <ffffffff8013b2e0>{process_timeout+0} <ffffffff8018d237>{do_select+967}
       <ffffffff8018cd80>{__pollwait+0} <ffffffff8018d57d>{sys_select+749}
       <ffffffff8010dab2>{sys_rt_sigreturn+578}
<ffffffff8010dc86>{system_call+126}

  =>   dump-end timestamp 900866281

lightning ~ #

Thanks,
Mark
