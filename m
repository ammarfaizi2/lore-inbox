Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283500AbRLMGlp>; Thu, 13 Dec 2001 01:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283501AbRLMGlf>; Thu, 13 Dec 2001 01:41:35 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:7342 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S283500AbRLMGl0>;
	Thu, 13 Dec 2001 01:41:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Stewart Allen <stewart@neuron.com>
Subject: Re: passing params to boot readonly
Date: Wed, 12 Dec 2001 22:41:20 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C1841BB.8010003@neuron.com>
In-Reply-To: <3C1841BB.8010003@neuron.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16EPYW-0003nW-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 12, 2001 21:50, Stewart Allen wrote:
> I'm in a bit of a pickle and need to find a way to pass boot params to a
> reiserfs rootfs to *prevent* it from replaying the journal on single-user
> boot. This may seem like a strange request, but I've got a degraded RAID
> array that I need to poke around in before deciding whether or not to send
> a disk off to a rehab lab. If the replay occurs, it will potentially
> destroy the fs since I'm using a degraded snapshot of the failed disk in
> hopes of reclaiming *some* of my data. The system is running 2.2.x (can't
> remember and can't find out w/out booting).
>
> Do I have a snowball's chance of pulling this off?

Well, kinda. The only thing that can deter ReiserFS from replaying the 
journal is convincing it that the physical media it's on is actually read 
only. Some quick less/grep work revealed that there is no option that makes 
the SCSI subsystem claim its devices are readonly (although it'd be extremely 
useful for situations such as this).

It'd probably be pretty easy to make a boot disk using a hacked version of 
ReiserFS that refuses to replay the journal, by adding a "return 0;" near the 
top of journal_read(struct super_block *) in journal.c. However, you might 
feel more comfortable sending it off for data recovery than testing kernel 
hacks on it ;)

-Ryan
