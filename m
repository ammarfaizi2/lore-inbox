Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVKVS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVKVS4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbVKVS4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:56:42 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:60052 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S965109AbVKVS4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:56:40 -0500
Date: Tue, 22 Nov 2005 13:56:39 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
cc: linux-usb-devel@lists.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: /dev/sr0 not ready, but working
In-Reply-To: <200511221143.00970.gustavo@compunauta.com>
Message-ID: <Pine.LNX.4.44L0.0511221349360.21136-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Gustavo Guillermo Pérez wrote:

> Yes, I do the same operations as iee1394 and USB, and here we go:
> 1) ieee1394 Dirty DVD+RW ad UdfFileSystem without pktcdvd cause +rw
> No Real problems, the errors on logical sectors was and old bad mount, but the 
> second one writing 5 o 6 MB of a lot of small files does not produce the 
> error.
> 2) ieee1394 Normal growisofs -Z /dev/sr0 -J -r /folder
> No errors on the media, writing as iso not packet.
> The error appears while writing the DVD+RW 96 times, not the same udf disk.
> 3) Reading from The writed disc
> No error, normal operation.
> 4)Changing to USB Interface and ShutDown the iee1394, and do the udf Stuff.
> Normal operation no errors on the DVD-RW media.
> 5) USB Writing Normal growisofs -Z /dev/sr0 -J -r /folder
> No errors on the media, writing as iso not packet.
> The error appears while writing the DVD-RW 57 times, not the same udf disk, 
> less data less errors.
> 6) Reading data from USB Interface.
> No errors normal operation.
> 7) lspci, lsusb
> The mouse is not relevant, I was plugged today.
> 
> Working with +RW -RW -R and +R, allways writing not udf packets the error 
> appears. As IDE interface the drive does not produce any device not ready 
> error.

I know practically nothing about how your device works, so this is just a
guess.  It seems likely that the IEEE1394-USB/ATA interface controller
translates the commands it receives over the external bus into a sequence
of ATA or ATAPI commands that is somewhat different from the sequence of
commands Linux would use if the drive were directly attached to an IDE
controller.  As a result, perhaps the drive sends those "not ready"  
replies when you use it over an external bus but not when you use attach
it over ATA.

Or maybe not...  Maybe the drive _does_ send those "not ready" messages 
and the IDE driver ignores them instead of printing them in the system 
log.  Or perhaps those messages are sent by the bus interface controller 
and not by the drive itself.  I just don't know.

Alan Stern

