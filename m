Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284280AbRLMPo7>; Thu, 13 Dec 2001 10:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284282AbRLMPot>; Thu, 13 Dec 2001 10:44:49 -0500
Received: from neuron.com ([209.61.186.37]:22793 "EHLO server1.neuron.com")
	by vger.kernel.org with ESMTP id <S284280AbRLMPoc>;
	Thu, 13 Dec 2001 10:44:32 -0500
Date: Thu, 13 Dec 2001 09:52:55 -0600 (CST)
From: <stewart@neuron.com>
To: Hans Reiser <reiser@namesys.com>
cc: Ryan Cumming <bodnar42@phalynx.dhs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: passing params to boot readonly
In-Reply-To: <3C1874D5.5050205@namesys.com>
Message-ID: <Pine.LNX.4.30.0112130947450.12809-100000@server1.neuron.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Hans Reiser wrote:

> Ryan Cumming wrote:
>
> >On December 12, 2001 21:50, Stewart Allen wrote:
> >
> >>I'm in a bit of a pickle and need to find a way to pass boot params to a
> >>reiserfs rootfs to *prevent* it from replaying the journal on single-user
> >>boot. This may seem like a strange request, but I've got a degraded RAID
> >>array that I need to poke around in before deciding whether or not to send
> >>a disk off to a rehab lab. If the replay occurs, it will potentially
> >>destroy the fs since I'm using a degraded snapshot of the failed disk in
> >>hopes of reclaiming *some* of my data. The system is running 2.2.x (can't
> >>remember and can't find out w/out booting).
> >>
> >>Do I have a snowball's chance of pulling this off?
> >>
> >
> >Well, kinda. The only thing that can deter ReiserFS from replaying the
> >journal is convincing it that the physical media it's on is actually read
> >only. Some quick less/grep work revealed that there is no option that makes
> >the SCSI subsystem claim its devices are readonly (although it'd be extremely
> >useful for situations such as this).
> >
> >It'd probably be pretty easy to make a boot disk using a hacked version of
> >ReiserFS that refuses to replay the journal, by adding a "return 0;" near the
> >top of journal_read(struct super_block *) in journal.c. However, you might
> >feel more comfortable sending it off for data recovery than testing kernel
> >hacks on it ;)
> >
> >-Ryan
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> why not just edit the source code directly and recompile?
>
> Hans


There are a couple of potential problems with this approach:

1. I thought the on-disk structures for ReiserFS changed sometime
   between 2.2.something (the system in question) and now. Since I
   cannot pinpoint the kernel/patch version, I'm not sure this hack
   will work.

2. I have no other systems like this one to test the read-only hack on.
   Without a fairly high degree of confidence that I'm actually booting
   in a no-replay read-only state, I'm not going to take chances with
   this data.

stewart


