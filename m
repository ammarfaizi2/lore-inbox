Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSCYMcq>; Mon, 25 Mar 2002 07:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312415AbSCYMc2>; Mon, 25 Mar 2002 07:32:28 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:29197 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S312414AbSCYMcR>;
	Mon, 25 Mar 2002 07:32:17 -0500
Date: Mon, 25 Mar 2002 12:21:29 +0000
From: Chris Wilson <jakdaw@lists.jakdaw.org>
To: linux-kernel@vger.kernel.org
Subject: Ethernet interrupts getting processed as timer interrupts
Message-Id: <20020325122129.27f43448.jakdaw@lists.jakdaw.org>
Organization: Hah!
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Mon__25_Mar_2002_12:21:29_+0000_08409178"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__25_Mar_2002_12:21:29_+0000_08409178
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



I have a server at work that seems to have a rather serious problem with
IRQ routing. I noticed that it's clock was drifting rather heavily a while
back - then I spotted that if I flood pinged it it's clock would go mad
(drift a few days forward in a matter of seconds). At the time it had an
old rather heavily loaded (ipsec and god knows what all turned on) kernel
- so I rebuilt it a nice clean 2.4.16 install and restarted it.

A few weeks later the problem is now back! The system has 3 ethernet cards
- but ONLY packets to eth0 seem to trigger the problem.

eth0: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:20:6F:89, IRQ 11.
   Board assembly 733470-004, Physical connectors present: RJ45
   Primary interface chip i82555 PHY #1.
   General self-test: passed.
   Serial sub-system self-test: passed.
   Internal registers self-test: passed.
   ROM checksum self-test: passed (0x04f4518b).

# cat /proc/interrupts 
           CPU0       CPU1       
  0:  406778504  421411683    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 16:   67601276   67572131   IO-APIC-level  eth2
 17:  110005783  110266175   IO-APIC-level  eth0
 18:    1549893    1553272   IO-APIC-level  megaraid
 19:  186036215  186229458   IO-APIC-level  eth1
NMI:          0          0 
LOC:  826656995  826656993 
ERR:          0
MIS:          0

If a flood ping the system (from a machine on eth0's subnet) I can do:

# date; date; date; date; date; date
Mon Mar 25 11:35:26 GMT 2002
Mon Mar 25 11:35:28 GMT 2002
Mon Mar 25 11:35:29 GMT 2002
Mon Mar 25 11:35:31 GMT 2002
Mon Mar 25 11:35:33 GMT 2002
Mon Mar 25 11:35:34 GMT 2002

I also see the timer interrupt count (from /proc/interrupts) incrementing
for each eth0 interrupt.

I've attached my .config file - the machine also runs a few CIPE tunnels,
so has it's kernel module loaded.

Anyone have any suggestions as to what might be causing this or how to fix
it? If there's any more info req then please email me.


Cheers,

Chris

-- 
Chris Wilson
jakdaw@lists.jakdaw.org

--Multipart_Mon__25_Mar_2002_12:21:29_+0000_08409178
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Disposition: attachment;
 filename=".config.gz"
Content-Transfer-Encoding: base64

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
DUoAAA==

--Multipart_Mon__25_Mar_2002_12:21:29_+0000_08409178--
