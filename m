Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262754AbTCZEaf>; Tue, 25 Mar 2003 23:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbTCZEaf>; Tue, 25 Mar 2003 23:30:35 -0500
Received: from ns0.usq.edu.au ([139.86.2.5]:58639 "EHLO ns0.usq.edu.au")
	by vger.kernel.org with ESMTP id <S262754AbTCZEae>;
	Tue, 25 Mar 2003 23:30:34 -0500
Message-ID: <3E812F8E.2030200@usq.edu.au>
Date: Wed, 26 Mar 2003 14:41:50 +1000
From: Ron House <house@usq.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hdparm and removable IDE?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I apologise that this question is coming from a user, but I believe the 
readers here are the only ones I can trust for a reliable answer, I have 
searched the Internet for many days during the last month for all 
available information, and due to the nature of the problem, I cannot 
tell whether any solution I write actually works properly.

The scenario: I have a ViPower hot-swap mobile rack for swapping IDE HDs 
on the fly. I am assuming that this device properly disconnects the 
hardware and that I am faced with a software problem. Our technical 
staff tell me that they have 'tested' hot swapping under RedHat 7.3 
(Kernel 2.4.18-3) and it 'works'. In other words, they unmounted, 
swapped, and mounted a new disk and didn't observe data loss. I am sure 
that they are mistaken that this is a reliable process, as I have read a 
great deal about the hdparm program and its -R and -U switches. But 
nothing that I can find explains exactly what is going on when hdparm is 
called; the man page is dreadfully vague.

I would like to write a utility that works as follows:

To unmount:
unmount partitions
Use hdparm -U to unregister
Auto-remove lines in fstab referring to removable device (to avoid 
marnings on bootup check)

To remount:
Use hdparm -R to register the new device
Auto-install lines in fstab relevant to removable device
mount partitions

My question: Given your knowledge of the innards of the kernel, does the 
above seem like a sound way to create a useful IDE hot-swap utility? As 
the simple unmount/remount strategy _seems_ to work, I am not confident 
that just programming this up and trying it will necessarily reveal any 
flaws, which is why I seek your advice.

Here are a few other factoids that may be relevant. This utility comes 
with Windoze drivers to set up hot-swapping. I installed them and they 
worked, but immediately Partition Magic started crashing Windoze 
whenever it was run. This behaviour even continued after uninstallation 
of the hot-swap drivers. Furthermore, at that point Linux started 
producing lines like this in /var/log/messages:

Mar 26 13:35:44 Loris kernel: hdd: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Mar 26 13:35:44 Loris kernel: hdd: dma_intr: error=0x84 { 
DriveStatusError BadCRC }

(the above repeated half dozen or so times, then:)

Mar 26 13:35:44 Loris kernel: ide1: reset: success

After that, things work. I am startled that a Windoze driver has left an 
effect in the system that is felt by Linux. Everything looks OK in the 
bios setup, but I am not an expert and may have missed something.

Again, I apologise for a user posting on a kernel list, but I have done 
a lot of work looking for answers and I do believe this is the only 
place where solid understanding of the underlying problem is to be found.

Many thanks for any insight.

-- 
Ron House     house@usq.edu.au
               http://www.sci.usq.edu.au/staff/house

