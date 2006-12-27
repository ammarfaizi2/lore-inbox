Return-Path: <linux-kernel-owner+w=401wt.eu-S1753635AbWL0SSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbWL0SSe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbWL0SSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 13:18:33 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43191 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbWL0SSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 13:18:33 -0500
Date: Wed, 27 Dec 2006 19:18:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Paul Slootman <paul+nospam@wurtel.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: idle RAID1 cpu usage
In-Reply-To: <20061227180900.GA10373@msgid.wurtel.net>
Message-ID: <Pine.LNX.4.61.0612271915400.10556@yvahk01.tjqt.qr>
References: <20061227180900.GA10373@msgid.wurtel.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 27 2006 19:09, Paul Slootman wrote:
>
>This works fine, but I noticed that quite some time was being used by
>the mdX_raid1 threads; even on a partition that's not even being used at
>this time... (it was an empty mounted filesystem, but I umounted it to
>be sure the filesystem code wasn't causing some IO).
>
>My question is: why is CPU being used by the RAID1 threads, even for
>those devices that are otherwise unused? What are they doing?

First-time synchronization (if applies), otherwise I suspect some
housekeeping (bitmap perhaps?).
Otherwise it seems like a question who does what. On a raid5 array (i.e.
cpu-heavy), both smbd and mdx_raid5 accumulate time for, of course, xor
calculation.

>I even started distributed-net to check that it wasn't just idle CPU
>cycles that were being used :-)
>
>Note: it did seem that the activity was a bit more during the first
>day after booting; in fact, the mdX_raid1 threads together had used
>about one hour's worth of CPU in the first 24 hours, i.e. 4% CPU
>(according to ps and top).


	-`J'
-- 
