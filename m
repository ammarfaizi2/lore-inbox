Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTLKMsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTLKMsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:48:50 -0500
Received: from [195.255.196.126] ([195.255.196.126]:40648 "EHLO
	gw.compusonic.fi") by vger.kernel.org with ESMTP id S264925AbTLKMsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:48:47 -0500
Date: Thu, 11 Dec 2003 14:47:49 +0200 (EET)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Driver API (was Re: Linux GPL and binary module exception clause?)
In-Reply-To: <20031211100627.GJ4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0312111427530.12975@zeus.compusonic.fi>
References: <Pine.LNX.4.58.0312100809150.29676@home.osdl.org>
 <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
 <20031210175614.GH6896@work.bitmover.com> <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
 <20031210180822.GI6896@work.bitmover.com> <Pine.LNX.4.58.0312101016010.29676@home.osdl.org>
 <20031210183833.GJ6896@work.bitmover.com> <Pine.LNX.4.58.0312101108150.29676@home.osdl.org>
 <Pine.LNX.4.58.0312102256520.3787@zeus.compusonic.fi>
 <20031211100627.GJ4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Dec 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> It doesn't work.  Let me give you an example: right now we have a way to get
> from struct inode to struct block device - inode->i_bdev.  You can wrap it
> into helper functions, whatever - it won't live to 2.8.
>
> 	Why?  Because if we want to handle device removal in a sane way, that
> association will have to go.  We will still have a need (and a way) to get
> from opened struct file of block device to its struct block_device.  And _that_
> association will remain stable through the entire life of struct file.  Even
> when the mapping from inode to block device gets changed.
I don't see this as a problem. I'm talking about an ABI for _character_
drivers only. Everybody who needs a "loosely coupled" device driver
will probably want to implement a character driver. If you look at any
operating systems there are very few differences between the character
driver interfaces of them. There have not been any dramatic changes in
this interface since Linux 0.99.x times. Some parameters have changed but
that's almost it.

Block devices, network devices and things like that are tighter coupled
by nature. I don't eventry to claim it's going to be possible to create
an ABI for them. At least I don't see it necessary.

In a charcter driver all you need to know from the inode structure is
basicly just the device (minor) number. It's not hard to implement the
ABI layer so that the minor number can be provided regardless of the
changes made to the kernel behind it.

To the client driver the ABI "wrapper" is a black box. It can't
see what is inside the box. In particular it can't see the kernel behind
it. If something changes in the kernel some changes are needed to the
internals of the box too.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
