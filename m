Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266824AbUGLNYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUGLNYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266818AbUGLNYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:24:51 -0400
Received: from hoemail1.lucent.com ([192.11.226.161]:29381 "EHLO
	hoemail1.lucent.com") by vger.kernel.org with ESMTP id S266824AbUGLNYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:24:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16626.37135.281501.307880@gargle.gargle.HOWL>
Date: Mon, 12 Jul 2004 09:24:31 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com, linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
In-Reply-To: <20040710222510.0593f4a4.akpm@osdl.org>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew> Ingo Molnar <mingo@elte.hu> wrote:

>> I took a look at latencies and indeed 2.6.7 is pretty bad -
>> latencies up to 50 msec (!) can be easily triggered using common
>> workloads, on fast 2GHz+ x86 system - even when using the fully
>> preemptible kernel!

Andrew> What were those workloads?

Andrew> Certainly 2.6+preempt is not as good as 2.4+LL at this time,
Andrew> but 2.6 isn't too bad either.  Even under heavy filesystem
Andrew> load it's hard to exceed a 0.5 millisecond holdoff.  There are
Andrew> still a few problem in the ext3 checkpoint buffer handling,
Andrew> but those seem pretty hard to hit.  I doubt if the `Jack'
Andrew> testers were running `dbench 1000' during their testing.

I'd like to chime in here with a data point, though I'm not sure how
usefull it really is.  I've got a Dual CPU, 550mhz, 768mb 440BX
system.  Running 2.6.7 plain.  I was playing XMMS and some music, and
trying to do the following from my mirrored data disks, to a new USB
external storage case, with the exact same drive as the pair of
internal systems.

	 cd /home
	 tar cf - . | (cd /mnt/portable; tar xpf -)

And the system load jumped to around 5 or 7.  Part of it was because I
had turned on usb-storage debugging, so syslog was hammering the
disks.  Note, root, /usr, and such are on a seperate SCSI disk from
/home and /local.  I had xmms, some xterms and galeon up and running.
Occassionally, xmms would stutter.  Then the entire system locked up
with xmms stuck in a loop playing the same sound over and over again.
No response on the USB bus, SysRq didn't work.  Had to hit the main
reset button to get it back again.

All filesystems are ext3 on here as well.  More details as I get this
tested out more, and I'll try to fill out a report on the usb-devel
list as well.

So in summary, there are some problems still in 2.6.7, though they are
more related to:

1. The delay in starting writeout to disk when streaming large (I
know, a subjective number) transfers.  The above tar commands didn't
start kicking data to the USB device for quite a while.  I know
there's overheard of reading the directory structure first, so that
could be it.  But it just seems to wait a bit before actually writing
data out.

John
