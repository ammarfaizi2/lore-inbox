Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTLDDc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 22:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTLDDc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 22:32:56 -0500
Received: from aples1.dom1.jhuapl.edu ([128.244.26.85]:13579 "EHLO
	aples1.jhuapl.edu") by vger.kernel.org with ESMTP id S262050AbTLDDcx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 22:32:53 -0500
Message-ID: <E37E01957949D611A4C30008C7E691E2F38C25@aples3.dom1.jhuapl.edu>
From: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
To: "'Greg KH '" <greg@kroah.com>,
       "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "''linux-kernel@vger.kernel.org' '" <linux-kernel@vger.kernel.org>
Subject: RE: Visor USB hang
Date: Wed, 3 Dec 2003 22:31:25 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Dec 03, 2003 at 05:36:01PM -0500, Collins, Bernard F. (Skip)
wrote:

>>> Can you show the log with that enabled?

>> If you mean debug=1 enabled, the log excerpt I posted was generated with
>> both the usbserial and visor modules modprobed with debug=1. Perhaps I am
>> mistaken in assuming that my approach actually enables debugging. I
>> modprobed both modules and hit the hotsync button. I am assuming that
>> hotplug does not override the manually loaded module parameters. 

> but then no user program tried to talk to the device.  I don't see any
> accesses to the device in your logs.  Any oops messages?

No oops. The log just stops right after ttyUSB0 and tyUSB1 are created. The
precise sequence upon pressing the sync button seems to be: (1) The Visor
enables and hub.c detects two new USB ports. (2) Modules visor and usbserial
do their thing to bind them to /dev devices. (3) A usb-uhci interrupt is
generated one second later. (4) The system hangs before any other access to
the ports occurs. The next log entry comes about 1.5 minutes later after a
reboot.

I am reposting the log excerpt below. 

It seems to me that it is not user programs accessing the modules which
triggers the hang. It is the creation of two new USB ports. If there is some
way to increase the debug verbosity, I would be willing to try it, even if
that means editing the module sources.

>>> What happens if you use the uhci.o module instead of usb-uhci.o?

>> That is not terribly convenient to test right now. Can you suggest a
simple
>> way to unload usb-uhci and load uhci without disabling my usb keyboard
and
>> mouse?

>	rmmod usb-uhci && modprobe uhci

I will try that.

Here are the relevant log file lines again:

Dec  3 15:19:20 xtr45wac kernel: usb.c: registered new driver serial
Dec  3 15:19:20 xtr45wac kernel: usbserial.c: USB Serial support registered
for Generic
Dec  3 15:19:20 xtr45wac kernel: usbserial.c: USB Serial Driver core v1.4
Dec  3 15:19:27 xtr45wac kernel: usbserial.c: USB Serial support registered
for Handspring Visor / Treo / Palm 4.0 / Clié4.x

Dec  3 15:19:28 xtr45wac kernel: usbserial.c: USB Serial support registered
for Sony Clié3.5
Dec  3 15:19:28 xtr45wac kernel: visor.c: USB HandSpring Visor, Palm m50x,
Treo, Sony Cliédriver v1.7
Dec  3 15:20:35 xtr45wac kernel: hub.c: new USB device 00:1d.1-2, assigned
address 3
Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter detected
Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: Number of ports: 2
Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: port 1, is for Generic use and is bound to ttyUSB0

Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: port 2, is for HotSync use and is bound to ttyUSB1

Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter now attached to ttyUSB0 (or usb/tts/0 for devfs)

Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter now attached to ttyUSB1 (or usb/tts/1 for devfs)

Dec  3 15:20:36 xtr45wac kernel: usb-uhci.c: interrupt, status 2, frame#
1499
Dec  3 15:21:58 xtr45wac syslogd 1.4.1: restart.
 
