Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWJNPEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWJNPEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 11:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWJNPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 11:04:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:62675 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1752171AbWJNPEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 11:04:05 -0400
From: Dominique Dumont <domi.dumont@free.fr>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user <alsa-user@lists.sourceforge.net>,
       Francesco Peeters <Francesco@FamPeeters.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-user] PCM distorsion snapshots from SATA/ALSA conflict
References: <877izsp3dm.fsf@gandalf.hd.free.fr>
	<13158.212.123.217.246.1159186633.squirrel@www.fampeeters.com>
	<87y7rusddc.fsf@gandalf.hd.free.fr>
	<1160081110.2481.104.camel@mindpipe>
	<87r6xmscif.fsf@gandalf.hd.free.fr>
	<1160082761.2481.106.camel@mindpipe>
	<1160085016.1607.26.camel@localhost.localdomain>
	<878xjrqeh2.fsf_-_@gandalf.hd.free.fr>
	<1160325674.17615.107.camel@mindpipe>
Date: Sat, 14 Oct 2006 17:04:03 +0200
In-Reply-To: <1160325674.17615.107.camel@mindpipe> (Lee Revell's message of
	"Sun, 08 Oct 2006 12:41:13 -0400")
Message-ID: <87hcy76isc.fsf@gandalf.hd.free.fr>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: domi.dumont@free.fr
X-SA-Exim-Scanned: No (on gandalf.hd.free.fr); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> (it's probably a bad idea to attach .jpgs to a LKML post - please post
> them on the web and send a URL)

(ok. But is there a site that will guarantee the availability of the
jpg attachments when people are searching the lklm or alsa archives ?
)

> You seem to be using a period size of 256 samples - any change if you
> use a larger period size?

Unless I'm wrong, you want me to test the PCM output while modifying
the --period option of speaker-test.

So I've tested this command:
  speaker-test -D iec958 -c 2 -f 1000 -p 4096 -t sine -s 2

No change: I still have a lot of spikes in the sine wave.

> Any change if you use setpci to increase LATENCY_TIMER for the SBLive!
> card?

To be sure I've done the correct tests, here are the commands are used:

$ lspci
[...]
01:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
01:07.1 Input device controller: Creative Labs SB Live! Game Port (rev 0a)
[...]
01:0b.0 RAID bus controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)

$ sudo setpci -s 01:07.0 latency_timer=80
$ sudo setpci -s 01:07.0 latency_timer=f8
$ sudo setpci -s 01:0b.0 latency_timer=10

No change at all :-(

Cheers

