Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWHNXor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWHNXor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWHNXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:44:47 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:44689
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932741AbWHNXoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:44:46 -0400
Date: Mon, 14 Aug 2006 16:44:23 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060814234423.GA31230@gnuppy.monkey.org>
References: <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com> <20060811211857.GA32185@gnuppy.monkey.org> <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:56:39AM -0700, Robert Crocombe wrote:
> I assume that replies were trimmed on accident, so I have resplattered 
> everyone.
> 
> On 8/11/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >Can you try it without RAID ? do you have a RAID set up ? You have tons
> >of options turned on in your .config, if you can isolate the problematic
> >system that, would be helpful to me since I don't have a lot of hardware.
> 
> Boo, I thought my config was pretty concise :(.  Okay, I really
> chopped it this time.
> 
> And yeah, it is a RAID config.  But for extra bonus points, I found a
> spare SCSI disk and installed Fedora Core 5 and did a 'yum upgrade' to
> whatever was current as of today.  So it's a single disk config now.
> Problem still occurs with 't2' patched kernel.
> 
> config and dmesg attached, kaboom-like stuff appended.

It looks like a screw interaction between the latency tracer and the mutex
code that creates such a wacked out looking stack trace. Unfortunately,
I've been unsuccessful at reproducing it, so I'm going to focus on a partial
clean up so that the rtmutex is a bit more friendly to the latency tracer.

This is kind of a pain.

You have all sorts of strange things going on in that config like NUMA
emulation and stuff which I can't imagine why you'd have that on, 1000
a sec tick, etc... If you can do a bit of work and narrow which option
is it, then I might be able to reproduce the situation over here. I'm
bothered by that bug, but it's going to need to be attacked from a couple
angles, two of which I just mentioned. If I can get a bit of help from
you where I can isolate the subsystem, it would be helpful while I'll
examine the tracing here.

bill

