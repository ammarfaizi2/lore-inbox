Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287005AbSAGUib>; Mon, 7 Jan 2002 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286841AbSAGUiW>; Mon, 7 Jan 2002 15:38:22 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:35821 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S287005AbSAGUiO>; Mon, 7 Jan 2002 15:38:14 -0500
Date: Mon, 07 Jan 2002 12:36:32 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
        mochel@osdl.org
Message-id: <17b801c197ba$febd13c0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /sbin/hotplug is called from the kernel only, right?
>
> Right.  But there's no reason it can't be called from any other place.
> It's just a userspace program with a well documented interface :)

Actually, it's already called from other places ... :)
/sbin/hotplug is called from the init.d/hotplug startup script.

There's a period during initial system boot when not all filesystems
or system services are available.  When the kernel calls out to
/sbin/hotplug in such a situation, hotplugging can't yet do it's job.

It's too early, the system isn't "hot" yet ... which is why I call this
problem the "coldplug" issue.   Even simple device setup
operations like modprobing may not be possible, much less
more complex ones like alerting/starting daemons.  So the
init.d/hotplug script, invoked later, fakes hotplug events to
make sure the same setup gets done, without requiring users
to unplug/replug devices.

- Dave


