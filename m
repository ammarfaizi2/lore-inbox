Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261913AbRETNRj>; Sun, 20 May 2001 09:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbRETNR3>; Sun, 20 May 2001 09:17:29 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:16395 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261877AbRETNRZ>; Sun, 20 May 2001 09:17:25 -0400
Date: 20 May 2001 11:53:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <81Cnv5o1w-B@khms.westfalen.de>
In-Reply-To: <20010519214321.A9550@atrey.karlin.mff.cuni.cz>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Num
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com> <torvalds@transmeta.com> <20010519211717.A7961@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.21.0105191231020.14472-100000@penguin.transmeta.com> <20010519214321.A9550@atrey.karlin.mf
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@suse.cz (Pavel Machek)  wrote on 19.05.01 in <20010519214321.A9550@atrey.karlin.mff.cuni.cz>:

> I think that plan9 uses something different -- they have ttyS0 and
> ttyS0ctl. This would leave us with problem "how do I get handle to
> ttyS0ctl when I only have handle to ttyS0"?

I've seen this question several times in this thread. I haven't seen the  
obvious answer, though.

Have a new system call:

ctlfd = open_device_control_fd(fd);

If fd is something that doesn't have a control interface (say, it already  
is a control filehandle), this returns an appropriate error code.

This has another benefit, in that you can get control descriptors for  
stuff that doesn't currently have a filename (but does have ioctls), such  
as network sockets.

MfG Kai
