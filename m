Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbRLML1Q>; Thu, 13 Dec 2001 06:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLML1D>; Thu, 13 Dec 2001 06:27:03 -0500
Received: from s2.relay.oleane.net ([195.25.12.49]:36626 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S282525AbRLMLWG>; Thu, 13 Dec 2001 06:22:06 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Shiyuan <csy@hjc.edu.sg>
Cc: <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>
Subject: Re: Kernel-2.4.17pre8 & invalidate: busy buffer
Date: Thu, 13 Dec 2001 10:29:08 +0100
Message-Id: <20011213092908.6764@smtp.wanadoo.fr>
In-Reply-To: <1008174218.3c17848ab4b69@home.hjc.edu.sg>
In-Reply-To: <1008174218.3c17848ab4b69@home.hjc.edu.sg>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello,
>
>Currently while running on a RedHat Linux 7.2 box with kernel-
>2.4.17pre8, whenever I run the "hdparm -t /dev/sda3" command, the 
>following error message will appear around 33+ times 
>in /var/log/messages as well as "dmesg" .
>
>invalidate: busy buffer
>
>The machine in question is a Dell PowerEdge 2550 with an AACRAID 
>controller and 2 x 18GB HDs in RAID-1 configuration and /dev/sda3 being 
>mount as / .

That's interesting. I've been seeing this message for some time now
(I think since around 2.4.15 at least, maybe longer). I modified the
printk to display the device number, and at that time, it seemed to
always originate from the partition that had a mounted HFS volume.
So I just added that to my (long) list of HFS bugs to fix when I
find enough time to dive into it.

However, I just got a report from some users having the same message
displayed when using parted and with no HFS partition (HFS filesystem
not loaded). I personally see this messages when using/leaving MacOnLinux
emulator (which is opening the block device of a partition that is also
mounted), or when shutting down the box.

Al, any clue ? Something you want me to do to track it further down ?

Ben.


