Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbUKLGfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbUKLGfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUKLGfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:35:15 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:11422 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262457AbUKLGfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/7] New set of input patches
Date: Fri, 12 Nov 2004 01:27:01 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120127.01473.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

Here is the new set of input patches. Please do

	bk pull bk://dtor.bkbits.net/input
	
It has the tonight's pull from Linus's tree plus the following patches:

01-i8042-panicblink-cleanup.patch
	Move panicbkink parameter definition together with the rest of i8042
        module parameters, add description and entry in kernel-parameters.txt

02-serio-start-stop.patch
        Add serio start() and stop() methods to serio structure that are
        called when serio port is about to be fully registered and when
        serio port is about to be unregistered. These methods are useful
        for drivers that share interrupt among several serio ports. In this
        case interrupt can not be enabled/disabled in open/close methods
        and it is very hard to determine if interrupt shoudl be ignored or
        passed on.

03-i8042-use-start-stop.patch
        Make use of new serio start/stop methods to safely activate and
        deactivate ports. Also unify as much as possible port handling
        between KBD, AUX and MUX ports. Rename i8042_values into i8042_port.

04-serio-suppress-dup-events.patch
        Do not submit serio event into event queue if there is already one
        of the same type for the same port in front of it. Also look for
        duplicat events once event is processed. This should help with
        disconnected ports generating alot of data and consuming memory for
        events when kseriod gets behind and prevents constant rescans.
        This also allows to remove special check for 0xaa in reconnect path
        of interrupt handler known to cause problems with Toshibas keyboards.

05-evdev-buffer-size.patch
	Return -EINVAL from evdev_read when passed buffer is too small.
        Based on patch by James Lamanna.

06-ps2pp-mouse-name.patch
	Set mouse name to "Mouse" instead of leaving it NULL when using
        PS2++ protocol and don't have any other information (Wheel, Touchpad)
        about the mouse.

07-synaptics-toshiba-rate.patch
	Toshiba Satellite KBCs have trouble handling data stream coming from
        Synaptics at full rate (80 pps, 480 byte/sec) which causes keyboards
        to pause or even get stuck. Use DMI to detect Satellites and limit
        rate to 40 pps which cures keyboard.  

Thanks!

-- 
Dmitry
