Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268794AbRG0JlK>; Fri, 27 Jul 2001 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268795AbRG0JlA>; Fri, 27 Jul 2001 05:41:00 -0400
Received: from [195.157.147.30] ([195.157.147.30]:65292 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S268794AbRG0Jku>; Fri, 27 Jul 2001 05:40:50 -0400
Date: Fri, 27 Jul 2001 10:32:21 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Strange remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010727103221.F18669@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au>; from akpm@zip.com.au on Thu, Jul 26, 2001 at 05:34:19PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Following the announcement on lkml, I have started using ext3 on one of my
servers.  Since the server in question is a farily security-sensitive box, my
/usr partition is mounted read only except when I remount rw to install
packages.

I converted this partition to run ext3 with the mount options
"nodev,ro,data=writeback,defaults" figuring that when I need to install new
packages etc, that I could just mount rw as before and that metadata-only
journalling would be ok for this partition as it really sees very little write
activity.

When I try to remount it r/w I get a log message saying:
Jul 27 09:54:29 henry kernel: EXT3-fs: cannot change data mode on remount

...even if I give the full mount option list with the remount instruction.

I can, however, remount it as ext2 read-write, but when I try to remount as
ext3 (even read only) I get the same problem.

Wierdly, "mount" lists it as being still an ext3 partition even though it has
been remounted as ext2.  I can't umount /usr because kjournald is currently
listed as using the partition.

The box in question is more-or-less RedHat 7.1, with ext3-2.4-0.9.4, kernel
2.4.7 and with the following relevant package versions:

mount-2.11g-4
util-linux-2.11f-3
e2fsprogs-1.22-2

...all from rawhide rpms.

Sean
