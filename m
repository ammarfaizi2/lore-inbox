Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbTLISX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbTLISX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:23:57 -0500
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:18052
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S266039AbTLISWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:22:18 -0500
Message-Id: <200312091821.hB9ILv2n017541@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: arnaud.quette@mgeups.com
cc: Greg KH <greg@kroah.com>, Paul Stewart <stewart@wetlogic.net>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net, opensource@mgeups.com,
       "Charles Lepple" <clepple@ghz.cc>, reg@orion.dwf.com
Subject: Re: USB/HID UPS issue (was Re: USB scanner issue) 
In-Reply-To: Message from arnaud.quette@mgeups.com 
   of "Tue, 02 Dec 2003 14:18:25 +0100." <C1256DF0.0048D122.00@gin123.ftgin.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Dec 2003 11:21:56 -0700
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I havent anything to add to your comments, except to make sure you saw
my comments about USB/HID problems that I have encountered with a UPS.

Since the message was short, I reproduce it here:

---

(previous post to linux-kernel)

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


