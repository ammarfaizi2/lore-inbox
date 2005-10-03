Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVJCXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVJCXQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVJCXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:16:52 -0400
Received: from smtp-out-01.utu.fi ([130.232.202.171]:11221 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S932459AbVJCXQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:16:52 -0400
Date: Tue, 04 Oct 2005 02:16:36 +0300
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: CD writer is burning with open tray
In-reply-to: <20050929162836.GA20178@csclub.uwaterloo.ca>
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: linux-kernel@vger.kernel.org
Message-id: <200510040216.36796.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20050929141924.GA6512@kestrel>
 <20050929162836.GA20178@csclub.uwaterloo.ca>
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 September 2005 19:28, you wrote:
> You should never need to use
> the emergency eject option unless you have a power failure and need a
> disc out badly, or the drive is broken and no longer installed in a
> machine and you need a disc removed from it.  It should not be used
> while the drive is powered.

Actually that is not quite true under Linux in all circumstances. There seems
to be no way to interrupt a mount attempt under Linux. I've sent a kill -9 to
the mount process, went to bed, and it was still attempting to read the disc
when I woke up 8 hours later. I'm not sure if it was due to bad firmware, or
due to Linux retrying failed read requests too many times. Somehow I would
except though, that sending kill -9 to the process in question would also try
abort the pending request rather than retrying it indefinitely.
Ejecting the disc with needle in emergency eject hole always made Linux give up
and mount fail, though, luckily saving me from reboot.

It's even worse on IDE where it can block all devices on the same channel, then
you have some pages on another device on same channel which are needed in
order to execute kill -9 or advance the cursor in your xterm :) Then you don't even
have choice of trying a kill -9 first...
Call me impatient, I usually give it a day or two after ^C and kill -9 before I resort
to emergency eject on the drive. I had a system once where even that didn't unwedge
things, I had to unplug the power from the IDE device in question before things unlocked.
Sure, it resulted in lots of nasty messages in dmesg and in the smartd log on the other
device on same IDE channel, but no data corruption luckily.

Hardware kinda sucks.
