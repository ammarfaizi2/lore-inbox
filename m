Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTFVXNA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTFVXM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:12:59 -0400
Received: from lucidpixels.com ([66.45.37.187]:9856 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263665AbTFVXM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:12:58 -0400
Date: Sun, 22 Jun 2003 19:27:03 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A Interrupt IRQ 7
In-Reply-To: <1056322074.2075.40.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0306221924400.361@p500>
References: <20030622222014.7827.qmail@lucidpixels.com>
 <1056322074.2075.40.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, I am not sure how the IO-APIC & IRQ routing work, however, with the
ATA/100 TX1 (first generation promise controller, the interrupts are
shared differently.

Whether this makes a difference or has anything to do with the spurious
interrupts/messages, I am not sure.

Before:

# cat /proc/interrupts
CPU0
0: 6486628 XT-PIC timer
1: 6 XT-PIC keyboard
2: 0 XT-PIC cascade
4: 647546 XT-PIC serial
5: 0 XT-PIC Crystal audio controller
8: 1 XT-PIC rtc
9: 3548883 XT-PIC eth2, eth3
11: 2601852 XT-PIC ide2, ide3, eth0, eth1
12: 38 XT-PIC PS/2 Mouse
14: 121950 XT-PIC ide0
15: 25 XT-PIC ide1
NMI: 0
LOC: 6486487
ERR: 11
MIS: 0

After:

           CPU0
  0:      22081          XT-PIC  timer
  1:          6          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       2061          XT-PIC  serial
  5:          0          XT-PIC  Crystal audio controller
  8:          1          XT-PIC  rtc
  9:       4233          XT-PIC  eth2, eth3
 10:         37          XT-PIC  ide2, ide3
 11:       2071          XT-PIC  eth0, eth1
 12:         38          XT-PIC  PS/2 Mouse
 14:       6037          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0
LOC:      22032
ERR:          0
MIS:          0

Now to see if I get any more of these spurious interrupts...

On Sun, 22 Jun 2003, Alan Cox wrote:

> IRQ7 is raised if an interrupt appears and then vanishes again before it
> can be serviced. For 2.4.20/21 at least it can occur from the IDE layer
> and maybe others
>
>
