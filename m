Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTKUQTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 11:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKUQTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 11:19:08 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:25868 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263702AbTKUQTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 11:19:03 -0500
Message-ID: <3FBE39E9.3010402@techsource.com>
Date: Fri, 21 Nov 2003 11:14:33 -0500
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Sanity checks and interrupts
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sure there's a FAQ about this somewhere, although I have done some 
googling and not found much helpful info.

Anyhow, I wish I could give you more information on my computer, but I'm 
at work, and the computer is at home.  In short, it's running RH9 with 
the latest up2date kernel (2.4.20-??).  The motherboard is an Abit KD7 
which is a KT400 MB.

How, everthing seems to work fine, but in my (very slow) research for 
system sanity checking, I've noticed people talking about interrupts. 
Well, so I dumped /proc/interrupts and looked at it.

To begin with, I notice that there are only "XT-PIC" interrupts.  Why is 
that?  From what I've read, others have "AT-PIC" and "APIC" interrupts 
as well.  Being a modern MB, I would expect to see something else.  Does 
that mean there's a problem?

Secondly, I noticed that both the network card (well, I have two, one 
built in, the other PCI, and I don't remember which) and my 3ware RAID 
controller (7000-2 or something) are sharing the same interrupt (11, I 
think), and in fact, there are two or three other devices on that same 
interrupt, which seems unbalanced to me.  Is THAT a problem?  It is, 
after all, only a single processor box, but could there be any kind of 
performance issue because of this?  How about stability?

I'm typing this email on a RH7.2 box running 2.4.18-27.7.x, and I 
checked /proc/interrupts here as well.  This is what I get:

            CPU0
   0:  663851803          XT-PIC  timer
   1:     208891          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  usb-uhci
  10:          0          XT-PIC  Intel ICH2
  11:  103158523          XT-PIC  usb-uhci, eth0, nvidia
  12:    4313520          XT-PIC  PS/2 Mouse
  14:    1245414          XT-PIC  ide0
  15:    8417399          XT-PIC  ide1
NMI:          0
ERR:          0


What decides that three devices should be on 11 but only one on 10 or 
12?  Why not two on each?  Why isn't one on 13?  I know that not all 
devices can have dynamically assigned interrupts.

And why is nothing hooked up to interrupts 3 thru 7?  I'm sure there's 
some legacy issue to do with this, although if they refer to things 
which have been deprecated, I'm surprised modern MB's don't reassign them.


And another thing... wrt PCI devices, I know that each slot is assigned 
one of four interrupt lines in rotation.  My MB has 6 slots, although 
one of them is the "you can't use this" slot for AGP.  (BTW, more than 4 
slots per bus is a PCI spec violation.)  If my NIC is in the last slot 
and the 3ware is in the first, maybe they share interrupt signal lines. 
  Perhaps moving one of them would change things.  But would that make 
one iota of difference?


Thanks!

