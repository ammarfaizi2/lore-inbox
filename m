Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUFUQCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUFUQCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUFUQCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:02:37 -0400
Received: from main.gmane.org ([80.91.224.249]:22431 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266293AbUFUQC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:02:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian S. Stephan" <stephanb@msoe.edu>
Subject: Re: 2.6.7-ck1
Date: Mon, 21 Jun 2004 11:02:21 -0500
Message-ID: <cb70qe$35t$1@sea.gmane.org>
References: <200406162122.51430.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mke7-188.nconnect.net
User-Agent: KNode/0.7.90
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> Patchset update. The focus of this patchset is on system responsiveness
> with emphasis on desktops, but the scope of scheduler changes now makes
> this patch suitable to servers as well.
> 
> http://kernel.kolivas.org

Dear Con,
I've been having odd problems with a USB device using your patchset (or
specifically, staircase). I applied the staircase7.1 patch as well. On
boot, an already plugged in device is not identified:

usb 2-2: new low speed USB device using address 3
usbhid: probe of 2-2:1.0 failed with error -5

Furthermore, a USB mouse is also on the bus, but it is identified fine.
Reinserting the other device still doesn't work:

usb 2-2: new low speed USB device using address 3
usbhid: probe of 2-2:1.0 failed with error -5
Adding 377516k swap on /dev/sda2.  Priority:-1 extents:1
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
usb 2-2: USB disconnect, address 3
usb 2-2: new low speed USB device using address 4
usbhid: probe of 2-2:1.0 failed with error -5

Everything works fine in 2.6.7:

usb 2-2: new low speed USB device using address 3
drivers/usb/input/hid-core.c: ctrl urb status -32 received
input: USB HID v1.00 Joystick [6666:0667] on usb-0000:00:10.0-2

At first I thought this was just a strict staircase problem, but I then
enabled usbfs and the joystick is attached fine with -ck1, so maybe it's
just a subtle timing issue?

Thought I would make the report and see if it uncovered anything, -ck runs
great. :)

Brian

