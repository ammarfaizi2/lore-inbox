Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbULBO11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbULBO11 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbULBO11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:27:27 -0500
Received: from lucidpixels.com ([66.45.37.187]:11206 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261627AbULBO1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:27:21 -0500
Date: Thu, 2 Dec 2004 09:27:20 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 undecoded slave problem, fixed in 2.6.10-rc2-bk8!
Message-ID: <Pine.LNX.4.61.0412020925040.25494@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed this issue but I just wanted to let others that have this 
issue know that 2.6.10-rc2-bk8 has fixed the issue.

-------------------------------------------------------------------------

Problem: Only one of my CDROM's is recognized when both drives are 
attached to the 1 IDE bus of a PROMISE 20269 controller.  When I have them 
attached to the motherboard (Intel 440BX), I do not have this problem.

>From dmesg:

hde: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
hdf: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
ide-probe: ignoring undecoded slave

In: http://www.uwsg.iu.edu/hypermail/linux/kernel/0410.3/1288.html

There is a message that states:

<bzolnier@trik.(none)> (04/10/26 1.2191)
[ide] ide-probe: undecoded slave fixup

Undecoded slave fixup is a oneliner patch to ide-probe to
recognize both of my Maxtor drives that appear to have the same
serial number, D3000000.

Another thread:
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.2/1665.html

The interesting part of all of this is that this only occurs when I have 
the two cdroms on a promise controller, on the same IDE channel, normally 
I have them both on the motherboard as master and slave.  I wanted to make 
sure the card worked however, so switched the connection over to the 
promise board and then I am getting the same error as the guy above, 
except in my case it is with two identical CDROMS and not hard drives.

The problem occurs with 2.6.9.

-------------------------------------------------------------------------

Update: With 2.6.10-rc2-bk8, it has fixed the problem!

hde: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
hdf: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
ide2 at 0xd8f8-0xd8ff,0xd8f2 on irq 11
hde: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.20
hdf: ATAPI 40X CD-ROM drive, 128kB Cache
Probing IDE interface ide3...

root@p500b:~# mount /dev/hde /mnt/cd1
mount: block device /dev/hde is write-protected, mounting read-only
root@p500b:~# mount /dev/hdf /mnt/cd2
mount: block device /dev/hdf is write-protected, mounting read-only
root@p500b:~#

