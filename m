Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCaMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCaMMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVCaMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:12:49 -0500
Received: from general.keba.co.at ([193.154.24.243]:42429 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261157AbVCaMMq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:12:46 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.11, USB: High latency?
Date: Thu, 31 Mar 2005 14:12:38 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231D1@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.11, USB: High latency?
Thread-Index: AcU1fBU2T0AYox1PRwqOXOwJeq//cAAbiKAA
From: "kus Kusche Klaus" <kus@keba.com>
To: "David Brownell" <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I couldn't find that previous email in the MARC archives.
> 
> Regardless, you'd have to provide a small bit of information about
> your hardware configuration.  What device speed:  full or high?
> What controller:  EHCI, OHCI, UHCI, something else?  Which driver
> for the stick:  usb-storage, or ub?  What else was using memory
> and PCI bandwidth at the time?  SMP?

The error occurred on an intel Pentium 3 (500 MHz) embedded system with
440BX chipset and 192 MB RAM. USB is handled by the 440BX (intel 82371
PIIX4). The UHCI driver shares interrupt 7 with an intel 82559ER 100
Mbit ethernet controller (which is driven by the e100 driver and active:
As there is no local keyboard, I access the system by ssh). 

The system "disk" is a 128 MB CF card directly connected to the 440BX
primary IDE port and running in PIO mode 2 at about 2 MB/sec peak (but
it is idle most of the time). There is a SM712 VGA chip running in text
mode, a 1000 HZ std PC timer, and no other "interesting" device (nothing
else on the PCI bus or causing any interrupts).

The error was reproduced with statically linked (no modules)
vanilla-2.6.11, 2.6.11-gentoo-r3, and
realtime-preempt-2.6.12-rc1-V0.7.41-11 kernels, all built with gcc
3.4.3. No SMP. USB-storage for the sticks.

I tried with two different sticks (an old 64 MB USB 1.x and a 1 GB USB
2.x), both show the same problem on all USB interfaces on the target.
The same dd command works fine on both sticks on my office PC. 

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com
