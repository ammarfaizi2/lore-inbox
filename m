Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGRMrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGRMrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGRMrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:47:18 -0400
Received: from news.cistron.nl ([62.216.30.38]:43717 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S932181AbWGRMrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:47:17 -0400
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: Re: [PATCH] SCSI disk won't spinup, so boot hangs
Date: Tue, 18 Jul 2006 12:47:16 +0000 (UTC)
Organization: Wurtelization
Message-ID: <e9il8k$n71$1@news.cistron.nl>
References: <20060712141441.GA16473@wurtel.net> <20060712144848.GD7328@harddisk-recovery.com>
X-Trace: ncc1701.cistron.net 1153226836 23777 83.68.3.130 (18 Jul 2006 12:47:16 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw  <erik@harddisk-recovery.com> wrote:
>On Wed, Jul 12, 2006 at 04:14:41PM +0200, Paul Slootman wrote:
>> I was recently confronted by a SCSI disk that had crashed somehow
>> ("mechanical positioning error" during the first signs of trouble). The
>> kernel hung after that, despite the fact that everything was on RAID-1
>> and the first disk still was working...
>
>Sounds like a worn bearing or a head crash.

Probably a head crash, this was a 5 month old 15krpm 73GB scsi disk.

>> I reasoned that if the spinup fails, it doesn't make much sense to try
>> and read the capacity, the partition tables, etc..  Hence I came up with
>> the patch below that sets media_present to 0 when the spinup doesn't
>> respond. It works for me (TM); there may be a better way, however the
>> current behaviour sucks big time.
>
>I've seen disks where the 100s timeout is not enough and which only
>came into a useful state after 10 minutes or even longer. Your patch

I'd consider disks that take 10 minutes or more to become ready
extremely obsolete :-)

>would make those disks useless, even though they can be used. Also I'm

Not really, wait your 10 minutes, echo "scsi remove-single-device a b c
d" > /proc/scsi/scsi; echo "scsi add-single-device a b c d" >
/proc/scsi/scsi; and there it is.

>not sure your patch is the right approach: a disk doesn't have
>removable media and yet it reports that there's no media present.

For all intents and purposes, the media isn't there...
Do you really think that the current behaviour (wait until eternity for
the drive to become ready on read capacity) to be the correct behaviour?
If so, why bother with the delay (of max. 100s) until spinup? Simply
issue the spinup command, and start trying to read the capacity would be
enough then.


Paul Slootman

