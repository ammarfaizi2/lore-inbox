Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUE1JGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUE1JGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 05:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265965AbUE1JGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 05:06:13 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:24976 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262391AbUE1JGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 05:06:00 -0400
Message-ID: <40B700F2.80208@eidetix.com>
Date: Fri, 28 May 2004 11:05:54 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davidwnwelton@gmail.com
Subject: boot from usb flash - wake boot process when disk is ready?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me - thanks! ]

Hi,

We're toying around with the idea of booting an embedded system off of 
USB flash (pros, cons, and advice about this would be appreciated, by 
the way), and I had a look at several of the existing patches to do this 
without going through the process of creating an initrd image.  That 
adds complexity and time to the boot process that we would prefer to 
avoid, although it appears that the kernel folks in the first thread 
cited are in favor of initrd....

http://www.uwsg.iu.edu/hypermail/linux/kernel/0301.3/1182.html

This mentions a couple of patches, both the "keep looping until it 
works" one, which I couldn't get working with 2.6.6, and Willy Tarreu's 
"wait a given period of time before continuing" patch:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0405.0/0224.html

I don't think either of those approaches are particularly elegant... 
although I'm sure my own efforts are good for a snort as well.

In genhd.c I wake up a waitqueue when the disk comes on line.    The 
init process waits on this before going on with prepare_namespace(). 
Ideally, this would look and make sure it's the right disk, that 
selected for the root fs:-)  Not being very familiar with the 'lay of 
the land' in the kernel, I declared the wait queue as a global in 
genhd.c.  The thing I don't like about this approach is that it builds a 
connection between two bits of the kernel that seem separate... maybe 
(ok, quite probably) there is a better/cleaner way of doing this?

Patch is at: http://dedasys.com/freesoftware/files/usb-wakeup.patch

Thanks for comments/constructive criticism, and thanks for reading,
-- 
David N. Welton
davidw@eidetix.com
