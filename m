Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262955AbSJGKDv>; Mon, 7 Oct 2002 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbSJGKDv>; Mon, 7 Oct 2002 06:03:51 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:49002 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S262955AbSJGKDu>; Mon, 7 Oct 2002 06:03:50 -0400
Message-Id: <m17yUpC-006hzVC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: "John Tyner" <jtyner@cs.ucr.edu>, "Greg KH" <greg@kroah.com>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Mon, 7 Oct 2002 11:43:21 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco> <m17yJwh-006imUC@Mail.ZEDAT.FU-Berlin.DE> <000e01c26d8f$987153f0$0a00a8c0@refresco>
In-Reply-To: <000e01c26d8f$987153f0$0a00a8c0@refresco>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached is a patch against 2.5.40 with __dev* uses removed and the error
> checking in the open routine fixed.
>
> Let me know if the ordering of the video_unregister_device and tasklet_kill
> is still an issue.

Well, here we go again, there are other issues as well.
There's a race between open() and disconnect(). The best way to deal
with it is to introduce a common semaphore for all devices the driver handles
and to take it as the first thing open() and disconnect() do and release it 
as the last thing. In addition every device needs a flag to show that it has
been opened and a flag to show that it has been unplugged. Alternatively
you could introduce device states, being "present and unused", "present and 
used" and "unplugged but used". As this needs to be checked in release(), it 
needs to take the semaphore as well.

	Regards
		Oliver
