Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269327AbRGaPrb>; Tue, 31 Jul 2001 11:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRGaPrV>; Tue, 31 Jul 2001 11:47:21 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:31502 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S269325AbRGaPrM>; Tue, 31 Jul 2001 11:47:12 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Controlling Terminal
Date: Tue, 31 Jul 2001 15:47:20 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9k6ju8$suo$3@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.3.95.1010731093430.18329A-100000@chaos.analogic.com>
X-Trace: ncc1701.cistron.net 996594440 29656 195.64.65.67 (31 Jul 2001 15:47:20 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <Pine.LNX.3.95.1010731093430.18329A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>Sorry about off-topic, but how do I create a "controlling
>terminal" for a process.

a) make sure that the process
   !(is session leader && already has a controlling tty)
b) then make the process a session leader by calling setsid()
c) make sure the tty you want to use isn't already the controlling
   tty for another session
d) open tty -> voila

If you're root you can force it by using ioctl(tty, TIOSCTTY, 1)
to steal away a controlling tty from another process, but generally
that is not a good idea.

>I know how to open the device,
>dup it to 0, 1, 2, set up signals, etc. However, the
>shell (bash) won't allow job-control, and ^C kills bash
>instead of what it's executing.

close(0); close(1); close(2); setsid(); fd = open(tty, O_RDWR);
dup(fd); dup(fd);

>I'm trying to run a shell off a multiplexed RF link. I've
>got a good clean 8-bit link. I should not have to use
>a pty. The driver's output "looks" like a terminal so it
>should be able to be a controlling terminal.

But it must be a tty-style device, ofcourse. You can't make a
socket or a block device a controlling tty.

Mike.
-- 
"dselect has a user interface which scares small children"
	-- Theodore Tso, on debian-devel

