Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274983AbRJAML0>; Mon, 1 Oct 2001 08:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274991AbRJAMLQ>; Mon, 1 Oct 2001 08:11:16 -0400
Received: from tele-2.inweb.net.uk ([212.38.64.10]:10505 "EHLO
	tele2.inweb.co.uk") by vger.kernel.org with ESMTP
	id <S274983AbRJAMLB>; Mon, 1 Oct 2001 08:11:01 -0400
Message-ID: <00c401c14a71$f8c478f0$1e1cd2d5@chris>
From: "Chris Andrews" <chrisa@inweb.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
Date: Mon, 1 Oct 2001 13:09:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evan Harris (eharris@puremagic.com) said:

> I have a 6 disk RAID5 scsi array that had one disk go offline through a
> dying power supply, taking the array into degraded mode, and then another
> went offline a couple of hours later from what I think was a loose cable.

I had much the same happen, except that I lost 6 disks out of 12 (power
failure to one external rack of two), so I had no chance of starting in
degraded mode. In this situation, where there are not enough disks for a
viable raid, what is the recommended solution? In my case, there was nothing
wrong with the six disks, but their superblock event counters were out of
step.

Is the best idea to modify /etc/raidtab as discussed, and run mkraid with
the real force option? What I actually did was to hand-edit the superblocks
on the disks, and got the array going. That experience would lead me to
suggest that there's room for some more options to allow the use of disks
where there's actually nothing wrong, but right now the raid code won't use
them. I'm thinking of a set of '--ignore' options to raidstart:
--ignore-eventcounter, --ignore-failedflag, etc, which an admin could use as
an alternative to trying mkraid.

Right now it seems that software-raid works well, until it doesn't, at which
point you're stuck - there's very little in the way of tools or overrides to
sort problems out. Something other than 'try mkraid force as a last resort'
would be useful.

(If anyone thinks this is a good idea, yes, I am volunteering to provide
patches...)

Chris.

