Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRIYTKj>; Tue, 25 Sep 2001 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272672AbRIYTKd>; Tue, 25 Sep 2001 15:10:33 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:35458 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S272620AbRIYTKY>;
	Tue, 25 Sep 2001 15:10:24 -0400
X-WebMail-UserID: newton
Date: Tue, 25 Sep 2001 16:20:17 -0300
From: Chris Newton <newton@unb.ca>
To: linux-kernel@vger.kernel.org
X-EXP32-SerialNo: 00003025, 00003442
Subject: excessive interrupts on network cards
Message-ID: <3BB0E01D@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I 'think' the number of interrupts being generated for the network traffic I 
monitor, is excessive.  Having talked quikly with Donald Becker, he indicated 
that I should be seeing a little less than the number of RX/TX packets/s on a 
wire, in terms of interrupts/s.  That, however, is not what I am seeing.  I am 
seeing 3 times as many interrupts/s as I am seeing packets/s.

  I have used three network devices to look at the stream I am monitoring, and 
it is usually aorund 5K packet/s IN, and 5K out, fed full duplex into a single 
3Com 3c982 (2.4.10 kernel reports that anyways).  However, watching:

 'procinfo -D', reports on the order of 30,000 interrupts per second.

  This page:

  http://www.scyld.com/network/3c509.html

  has a snipet:

  "some other device or device driver hogging the bus or disabling interrupts. 
Check /proc/interrupts for excessive interrupt counts. The timer tick 
interrupt should always be incrementing faster than the others. "

  Well, looking at this machine, since it booted 57 minutes ago:


[root@phantom /proc]# more interrupts
           CPU0       CPU1
  0:     172754     171041    IO-APIC-edge  timer
  1:          0          3    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 14:          2          2    IO-APIC-edge  ide0
 16:      87361      87539   IO-APIC-level  eth2
 20:    6798697    6799977   IO-APIC-level  eth0
 21:          0          0   IO-APIC-level  eth1
 30:      11837      11806   IO-APIC-level  aic7xxx
 31:     199418     199209   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:     343669     343708
ERR:          0
MIS:          0


  In 57 minutes, that ethernet card has generated: 14,000,459 interrupts.

  Isn't this excessive?

  I also have a different brand card on board...  an intel ether express pro.  
So... I swapped the cables so that the intel card would see that network 
stream.    Well, it caused even more interrupts per second. (more like 40K).


  I have tried kernel 2.4.9, 2.4.2 (redhat 7.1 version), and just now, 2.4.10, 
all SMP builds, on a dual 1 GHz PIII, with 1 GB of SDRAM, Adaptec 7899 
Ultra160 controller, two 3c982 netcards and one onboard intel etherexpress pro 
100 cards.

  Guess my question is, first of.. is this normal? 

