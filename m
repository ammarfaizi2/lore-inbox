Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261547AbRFWRba>; Sat, 23 Jun 2001 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261577AbRFWRbU>; Sat, 23 Jun 2001 13:31:20 -0400
Received: from mta00.talk21.com ([62.172.192.40]:29905 "EHLO
	t21mta00-app.talk21.com") by vger.kernel.org with ESMTP
	id <S261547AbRFWRbD>; Sat, 23 Jun 2001 13:31:03 -0400
Message-ID: <3B3544E1.9080801@talk21.com>
Date: Sat, 23 Jun 2001 18:39:45 -0700
From: Edward Tandi <etandi@talk21.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; m18) Gecko/20001108 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HPT370 driver problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People,

I have an IWill IDE Raid card with the Highpoint HPT370 Chip. I am 
running this on a Dual Processor board (800MHz PIIIs) with a Mandrake 
8.0 Disrtibution (2.4.3 Kernel). 200MB of RAM and all slots filled with 
lots of cards. I was glad to see that Linux auto-detected the IDE/Raid card.

The initial hardware configuration had two 40G IBM drives (7200RPM 
UDMA100) each attached as the IDE Master (using cable select) of the 
primary and secondary IDE interfaces as this is the optimum for two 
drives. I then used the md/meta tools to stripe the two.

Then I started to migrate data. This all went well untill I decided to 
check stuff with diff. Well, diff found many files to be different. I 
tried all the hdparm settings to no avail. I tried reiserfs to no avail. 
I tried swithching to LVM to no avail. I pulled out a processor, still 
the same result (I then broke the slot1 socket trying to put it back in 
-ooh my wallet hurts!). So I then focussed on looking at the type of 
corruption. It's approximately 2 bytes in 300 megs -so it's probably a 
dreaded off-by-one.

The real problem with this one is that it was hard to re-produce. But I 
then decided to isolate the drives and found that operations on 
individual drives were OK, but if you tried to use the two together, 
pa-tang!

Now here's the interesting bit; I connected the two drives onto the same 
cable (and therefore interface). It worked without fault. No 
corruptions. So I guess the problem is at the driver level when 
inter-working across the primary and secondary IDE interfaces.

Has anyone else seen this. Any patches/workarounds? -cos I want to add 
another two drives. TIA,

Ed-T.

