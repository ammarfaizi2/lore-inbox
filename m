Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWF3GSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWF3GSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWF3GSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:18:15 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:18307 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751147AbWF3GSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:18:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=meE7z0dnSC5lt73E0ryCt4yfe9kwAWAMOqZ2OAvYjgovxJeu39YJLGg5MoX3owYpODEDRKlRb/6F0dmnZjtH1yPt1dRWlDGIHoxlM3eQ4bKoz4Mp/Jg2JS3pz57d6zNxbj3Iwzib0KpM965LRnMtZ/QLsMFhUoJWZxWyBbl3NBQ=
Message-ID: <a44ae5cd0606292318n5a788a30xa1c28ed4fc973056@mail.gmail.com>
Date: Thu, 29 Jun 2006 23:18:13 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-mm4 -- BUG: illegal lock usage! -- illegal {hardirq-on-W} -> {in-hardirq-W} usage.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To trigger this, I booted with a U.S. Robotics USR2210 Wifi card
plugged into my cardbus slot.  I then ran "pccardctl eject" and then
removed and then reinserted the card.  After looking at the latest
PCMCIA info, it seems that I may need to add some kernel boot options
to work around a BIOS or other problem that causes trouble when
removing a card.

PM: Removing info for pci:0000:02:00.0
PCMCIA: socket c1ebc9e0: *** DANGER *** unable to remove socket power

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&socket->thread_lock){+-..}, at: [<c1181270>] pcmcia_parse_events+0x3e/0x6b
{hardirq-on-W} state was registered at:
  [<c102d1c8>] lock_acquire+0x60/0x80
  [<c120136e>] _spin_lock+0x23/0x32
  [<c1181270>] pcmcia_parse_events+0x3e/0x6b
  [<c1181945>] pcmcia_register_socket+0x29b/0x2fc
  [<c118a8d1>] yenta_probe+0x51b/0x55c
  [<c110d537>] pci_device_probe+0x39/0x5b
  [<c1162598>] driver_probe_device+0x45/0x92
  [<c11626b2>] __driver_attach+0x5c/0x85
  [<c1162022>] bus_for_each_dev+0x36/0x5b
  [<c11624f0>] driver_attach+0x14/0x17
  [<c1161d02>] bus_add_driver+0x6b/0x109
  [<c1162968>] driver_register+0x9d/0xa2
  [<c110d6ab>] __pci_register_driver+0x4f/0x6c
  [<c13760b1>] yenta_socket_init+0xf/0x11
  [<c10002a8>] init+0x88/0x1de
  [<c1001005>] kernel_thread_helper+0x5/0xb
irq event stamp: 11031192
hardirqs last  enabled at (11031191): [<c11408c6>]
acpi_processor_idle+0x1d1/0x35b
hardirqs last disabled at (11031192): [<c1002fcf>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (11031186): [<c101a767>] __do_softirq+0xab/0xb0
softirqs last disabled at (11031171): [<c1004a64>] do_softirq+0x58/0xbd

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102b833>] print_usage_bug+0x1cc/0x1d9
 [<c102bc2b>] mark_lock+0x8a/0x360
 [<c102c922>] __lock_acquire+0x38f/0x970
 [<c102d1c8>] lock_acquire+0x60/0x80
 [<c120136e>] _spin_lock+0x23/0x32
 [<c1181270>] pcmcia_parse_events+0x3e/0x6b
 [<c118a3ac>] yenta_interrupt+0xad/0xb7
 [<c103f227>] handle_IRQ_event+0x20/0x50
 [<c103f2cc>] __do_IRQ+0x75/0xc9
 [<c1004b84>] do_IRQ+0xbb/0xcf
 [<c1002fd9>] common_interrupt+0x25/0x2c
pccard: CardBus card inserted into slot 0
PM: Adding info for pci:0000:02:00.0
