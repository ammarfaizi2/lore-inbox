Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUAMBK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUAMBK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:10:58 -0500
Received: from mailgate5.cinetic.de ([217.72.192.165]:31680 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id S263618AbUAMBK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:10:57 -0500
Date: Tue, 13 Jan 2004 02:10:21 +0100
Message-Id: <200401130110.i0D1ALQ08941@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: "Kai Krueger" <kai.a.krueger@web.de>
To: "BartSamwel" <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Samwel <bart@samwel.tk> schrieb am 12.01.04 22:54:41:
>
> Dumitru Ciobarcianu wrote:
> >>>I'm currently trying kernel 2.6.1-mm1 with laptop-mode on a reiserfs partition.
> >>>If I kill all daemons running on the system and do nothing with it, I can achieve the 10 minutes spin down time I had expected from laptop-mode. However as soon as I start up X with KDE I get regular spin ups every 30 seconds. Looking at the output of "echo 1 > /proc/sys/vm/block_dump", I see an entry every 30 seconds of "kdeinit(15145): WRITE block 65680 on hda1" followed by a whole load of "reiserfs/0(12): dirtied page" and "reisers/0(12): WRITE block XXXXX on hda1".
> >>>
> >>>Due to the regular 30 second interval writes of kdeinit: kded to block 65680, laptop-mode is not particularly usable on this system.
> >>>Is this a problem with reiserfs or with kde and is there any fix available?
> >>
> >>Can you take a look at the message that Dumitru Ciobarcianu just sent to
> >>the list (about syslog), and check if it's that?
> >
> > Won't help him if kdeinit is doing fsync() on every friggind write.
> > syslog has an option to disable that, that's all.
> 
> I would be surprised if "kdeinit: kded" would do that. In fact, I run
> KDE, and it doesn't spin up the disk because of that, even though I have 
> about 15 kdeinit instances running, including one for kded. Of course, I 
> might be mistaken.
> 
> Kai, can you check the following: is the WRITE of kdeinit preceded by
> one or more "kdeinit: kded([some pid]): dirtied page" lines? And if they
> are, are they coming directly before the WRITE, or 5 seconds before it, 
> or 30 seconds before it? This distance might give a clue about the 
> cause. If it's directly before it (within a second), it's likely that 
> kded calls fsync. If it's about 5 or 30 seconds before it, it might have
> to do with some kind of writeback or expiry interval.

I can not see any log entries for "kdeinit: [some pid]: dirtied page". There are only the "kdeinit: () WRITE block 65680 on hda1". By the way, it is always block 65680; also across reboots if that is any indication and I have seen other processes like artsd write to that block without dirtying pages before as well.

Is there a way to find out what kdeinit writes to disk?

the sysklog daemon was shut down during the time of testing, so that shouldn't have effected it.

Thanks for the help,
Kai

> -- Bart
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

______________________________________________________________________________
Nachrichten, Musik und Spiele schnell und einfach per Quickstart im 
WEB.DE Screensaver - Gratis downloaden: http://screensaver.web.de/?mc=021110

