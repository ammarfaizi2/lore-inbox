Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRDEUmp>; Thu, 5 Apr 2001 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132763AbRDEUmh>; Thu, 5 Apr 2001 16:42:37 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:29789 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S132541AbRDEUma>; Thu, 5 Apr 2001 16:42:30 -0400
Date: Thu, 5 Apr 2001 22:41:45 +0200 (MET DST)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun4.lrz-muenchen.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: John Fremlin <chief@bandits.org>,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: how to let all others run
In-Reply-To: <Pine.LNX.3.95.1010405124737.15946A-100000@chaos.analogic.com>
Message-Id: <Pine.SOL.4.31.0104052232001.5537-100000@sun4.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Doesn't even show on `top`. Further, it gets the CPU about 100 times
> a second (HZ). This is normally what you want for something that
> polls, buts needs to give up the CPU so that whatever it's waiting
> for can get done as soon as possible.

Hi,

first of all I want to do this in kernel.
I need to do this to prevent a race. To handle removal of a hotpluggable
scsi device. On SMP there's a race between the task blocking the scsi
device and killing obsolete requests and other tasks queueing no requests.
If a task has passed the block before it comes into effect, but the
killing task is done with killing requests before the new request can be
queued the system will oops.
Simply calling the kernel equivalent of sched_yield() is not an option as
the number of runnable tasks can be smaller than the number of CPUs in
which case sched_yield is a nop.

	Regards
		Oliver


