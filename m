Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbSLRS6r>; Wed, 18 Dec 2002 13:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbSLRS6r>; Wed, 18 Dec 2002 13:58:47 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:33029 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S267338AbSLRS6p>; Wed, 18 Dec 2002 13:58:45 -0500
Message-ID: <3E00C738.1070506@mailsammler.de>
Date: Wed, 18 Dec 2002 20:06:32 +0100
From: Torben Frey <kernel@mailsammler.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Horrible drive performance under concurrent i/o jobs (dlh problem?)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list readers (and hopefully writers),

after getting crazy with our main server in the company for over a week 
now, this list is possibly my last help - I am no kernel programmer but 
suscpect it to be a kernel problem. Reading through the list did not 
help me (although I already thought so, see below).

We are running a 3ware Escalade 7850 Raid controller with 7 IBM Deskstar 
GXP 180 disks in Raid 5 mode, so it builds a 1.11TB disk.
There's one partition on it, /dev/sda1, formatted with Reiserfs format 
3.6. The Board is an MSI 6501 (K7D Master) with 1GB RAM but only one 
processor.

We were running the Raid smoothly while there was not much I/O - but 
when we tried to produce large amounts of data last week, read and write 
performance went down to inacceptable low rates. The load of the machine 
went high up to 8,9,10... and every disk access stopped processes from 
responding for a few seconds (nedit, ls). An "rm" of many small files 
made the machine not react to "reboot" anymore, I had to reset it.

So copied everything away to a software raid and tried all the disk 
tuning stuff (min-, max-readahead, bdflush, elvtune). Nothing helped. 
Last Sunday I then found a hint about a bug introduced in kernel 
2.4.19-pre6 which could be fixed using a "dlh", disk latency hack - or 
going back to 2.4.18. Last is what I did ( from 2.4.20 )

It seemed to help in a way that I could copy about 350GB back to the 
RAID in about 3-4 hrs overnight. So I THOUGHT everything would be fine. 
Since Tuesday morning my collegues are trying to produce large amounts 
of data again - and every concurrent I/O operation blocks all the 
others. We cannot work with that.

When I am working all alone on the disk creating a 1 GB file by
time dd if=/dev/zero of=testfile bs=1G count=1
results in real times from 14 seconds when I am very lucky up to 4 
minutes usually.
Watching vmstat 1 shows me that "bo" drops quickly down from rates in 
the 10 or 20 thousands to low rates of about 2 or 3 thousands when the 
runs take so long.

Can anyone of you please tell me how can I find out if this is a kernel 
problem or a hardware 3ware-device problem? Is there a way to see the 
difference? Or could it come from running an SMP kernel although I have 
only one CPU in my board?

I would be very happy about every answer, really!

Torben


