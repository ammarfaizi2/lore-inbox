Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTLHGEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 01:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbTLHGEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 01:04:36 -0500
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:33153
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S265341AbTLHGEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 01:04:35 -0500
Message-Id: <200312080604.hB864YY9009359@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 USB/HID problems.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Dec 2003 23:04:34 -0700
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am posting this here since I dont seem to be able to post to
either of the USB lists.

In working with the code apcupsd, I have found two problems that appeare
in the 2.6.0-testX kernels that did not appear in the 2.4.x series of kernels.

    (1) When doing a read to get hiddev_event structures, 2.4 only
	gave the 'real' events from the device that one expected.
	Under 2.6.0-testx there are several ZERO event structures/sec
	where the entire structure is ZERO, both hid and value.

	For the current code there may be a 'real' event every few
	seconds, and 5-10 of these zero events/sec.  I have no
	idea where they are coming from.

    (2) In one thread the code does a select, followed by a read if
	data is available.  If one just 'falls thru' to the read with
	the few lines of code it takes to do the checking, one gets
	up to 45000 messages/minute (750/sec) reading:

	    kernel: drivers/usb/input/hid-core.c: control queue full

	If one puts a 1/10sec sleep between these two commands, the
	error messages go away. 

Anyone know anything about either of these errors?
Or how to report them to the USB people if you cant post to the USB lists?
 
-- 
                                        Reg.Clemens
                                        reg@dwf.com


