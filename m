Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265821AbRFYAbs>; Sun, 24 Jun 2001 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265822AbRFYAbj>; Sun, 24 Jun 2001 20:31:39 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:57352 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S265821AbRFYAbY>; Sun, 24 Jun 2001 20:31:24 -0400
Date: Mon, 25 Jun 2001 08:32:23 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Anthony Heading <aheading@jpmorgan.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: replay on read-only filesystem
In-Reply-To: <20010625085436.A23111@tkd-fires-01.ja.jpmorgan.com>
Message-ID: <Pine.LNX.4.33.0106250828070.1740-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Jun 2001, Anthony Heading wrote:
> Did you get a satisfactory answer?  I'd be interested to know...

Here's what I got from Alan. I've "crashed" my system quite a quite time
by yanking out the power plug, and so far, the system is still ok.
Much better than ext2 as there's no fsck.

Jeff

------------------------------------------------------
From: Alan Cox <alan@lxorguk.ukuu.org.uk>

> what's the impact of mounting reiserfs as Read-Only (specified in
fstab)?
> >From syslog ...
>
> Jun 24 01:10:30 boston kernel: Warning, log replay starting on readonly
> filesystem
>
> Is this a problem?

In normal configurations it shouldnt be. Both ext3 and reiserfs currently
have the problem that they need to replay the log to get a stable file
system. Obviously you cant replay the log to disk if its read only, so
they replay the log to disk read/write then mount the fixed fs read only.

It breaks if your hardware has given up writing (certain disk fails) or if
you are running the swsuspend patch (serious disk corruption) but really
the swsusp patch interaction is the only problem one


