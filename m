Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVFYA62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVFYA62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 20:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVFYA62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 20:58:28 -0400
Received: from smtpout.mac.com ([17.250.248.83]:22738 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263176AbVFYA6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 20:58:23 -0400
In-Reply-To: <20050624081808.GA26174@kroah.com>
References: <20050624081808.GA26174@kroah.com>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Fri, 24 Jun 2005 20:57:55 -0400
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the things that most annoys me about udev is that I still need
a minimal static dev in order for the system to boot.  Could something
like this be used as follows?

1)  Boot kernel with an arg "automount_ndevfs", which automounts on /dev

2)  Init scripts use console, ttyX, hda, sda, etc from ndevfs

3)  Init script for udev does:
# mount -t tmpfs udev /.dev
# udevstart /.dev
# mount --move /.dev /dev
# mount -t ndevfs ndevfs /dev/.kerndev

4)  Normal userspace apps use /dev

5)  When udev is stopped, it can just umount /dev/.kerndev, then umount
/dev, then the basic stuff should still work.

Ideally ndevfs should support basic subdirectories and symlinks, so that
a simple /dev/pts could be mounted over top of it without any hassle.

Cheers,
Kyle Moffett

--
Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't.  
That's why
I draw cartoons. It's my life."
-- Charles Shultz

