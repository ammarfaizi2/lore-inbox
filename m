Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286189AbRLaDXJ>; Sun, 30 Dec 2001 22:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286193AbRLaDXA>; Sun, 30 Dec 2001 22:23:00 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:10131 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S286189AbRLaDWu>; Sun, 30 Dec 2001 22:22:50 -0500
Date: Sun, 30 Dec 2001 19:21:04 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Kernel panic from usb-ohci
To: j.derudder@btinternet.com
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <04b201c191aa$2e84af80$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is the driver you're using on top of usb-ohci,
seemingly whatever talks to that ADSL modem.  It might
be fixed in a more recent kernel, I wouldn't know.

> usb-ohci.c : bus 00:0c.0 devnum 2 deletion in interrupt
> Kernel BUG at usb_ohci.c: 886!

As it says in the comment on line 884, the problem is likely
(all but certainly) that "some interface's driver has a refcount
bug".  Specifically, the OHCI driver is being told the device
has gone away.  Because it's in_interrupt(), that's a lie ...
only khubd is allowed to declare that, and of course that can't
ever say that in_interrupt().

- Dave


