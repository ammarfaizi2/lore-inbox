Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbUB0Bab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 20:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUB0Bab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 20:30:31 -0500
Received: from p10068181.pureserver.de ([217.160.75.209]:19212 "EHLO
	www.kuix.de") by vger.kernel.org with ESMTP id S261667AbUB0BaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 20:30:24 -0500
Message-ID: <403E9D9A.8070906@kuix.de>
Date: Fri, 27 Feb 2004 02:30:02 +0100
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030721 wamcom.org
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: only ieee1394 from 2.4.20 works for me
References: <4038BDC3.9030304@kuix.de>
In-Reply-To: <4038BDC3.9030304@kuix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for your offer to analyze the problem.
I spent the last 6 hours trying to gather some helpful data.

I'm traveling between places a lot these days,
today I had access to one ieee1394 disk only.

I could play with a second disk Saturday.

--------

Let's ignore the small problem that 2.4.20 immediately recognizes
a disk when plugged in, but other versions require me to run
the rescan-scsi-bus script before the device is listed in /proc/scsi.

--------

Let's talk about the major problem, which is stalled data transfers,
when accessing hard disk drives.

I reconfirmed the problem still exists with 2.4.25.
I used 2.4.25 for the following tests.

Depending on the tools I use to access the external ieee1394 disk,
I sometimes get the stall effect very quickly, sometimes it takes a 
minute, sometimes it's difficult to reproduce at all.

When data transfer stalls, there is a period of about 30 seconds
where nothing happens, then I get:

   ieee1394: sbp2: aborting sbp2 command
   Read (10) 00 01 fa 9b 67 00 00 ff 00

After the message is shown, things again work for a random amount
of time, until it eventually stalls again.
(The numbers on the Read line appear to be different each time).

In my tests, I didn't do anything else on the system besides accessing 
the disk.

--------

An excerpt showing 1000 lines from /var/log/messages around the abort
is available at
   http://kuix.de/misc/kernel1394/excerpt

Output from /proc/bus/ieee1394/devices is available at
   http://kuix.de/misc/kernel1394/devices

cat /proc/scsi/scsi
   http://kuix.de/misc/kernel1394/scsi

--------

Because the dmesg output uses a small buffer, which quickly gets
overwritten once the stall period  is over, I didn't
include it here.

But now that I write these lines, I realize, maybe it would
help to catch output from dmesg, while things are stalled.
During that perioud, dmesg probably contains the last messages just 
before the problem. I can try it again Saturday, if you need that output.

--------

The data above was produced using the official 2.4.25 kernel.

I played with three combinations of debug settings.

a) No 1394 debug output enabled, which only gives the abort message.

b) Having set CONFIG_IEEE1394_VERBOSEDEBUG=y
    which gave the output I provided on the server.

c) In addition to b), having set CONFIG_IEEE1394_SBP2_DEBUG to 2.
    With that seeting, it was difficult to watch what's going on,
    because there was so much output on the screen.
    I'm quite sure things did not stall with this debug
    setting activated.

--------

What did I do to reproduce the problem?
Hopefully I found a testcase that you could try yourself.

   mount /fire
   cp linux-2.4.25.tar.bz2 /fire
   cd /fire
   tar xjf linux-2.4.25.tar.bz2

This stalls at least twice for me,
until all data is eventually processed.

--------

While I said in my initial mail, code from 2.4.20 works reliably,
I have to take that back partially.

While 2.4.20 works very good for me when copying a small
amount of larger files, the above scenario, where a lot of small
files are used, does not work reliably.

With the above test case, using ieee1394 from 2.4.20 gives me:
   ieee1394: sbp2: sbp2util_allocate_request_packet - no packets available!
   ieee1394: sbp2: sbp2util_allocate_write_request_packet failed
   ieee1394: sbp2: aborting sbp2 command
   Write (10) 00 01 bb db 77 00 00 06 00

--------

Thanks again for looking into the problem.
I hope the information provided helps.

If you want me to do more, I'd be glad to help,
but would appreciate detailed instructions what to do.

If you want me to try other snapshots of the ieee1394 code,
please feel free to send me a .tar.bz2 of the drivers/ieee1394 directory.

Best Regards,
Kai


Kai Engert wrote:
> In the last year I have been playing with a variety of combinations of 
> ieee1394 controllers, machines, external mass storage devices and linux 
> kernel versions. So have some friends of mine.
> 
> The only version that works for us is the ieee1394 code that was 
> included with kernel version 2.4.20.
> 
> (I removed drivers/ieee1394 completely, and replaced it with 
> drivers/ieee1394 from 2.4.20)
> 
> Using that snapshot, we are able to transfer data to disks and video 
> from a camcorder just fine, in all combinations we have tested.
> 
> Every other kernel version, both older or newer than 2.4.20, is broken. 
> We either see random errors, or writing data to disks stalls 
> immediately, or daisy chained devices don't work.
> 
> I'm currently using the official Fedora core 1 series kernels, patched 
> that way, and it works like a charm.
> 
> Please consider to use the 2.4.20 ieee1394 snapshot in future 2.4.x 
> releases.
> 
> Best Regards,
> Kai
> 
> 
> PS: Please CC me on replies.
> 


