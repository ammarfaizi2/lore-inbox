Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbTEZGIY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTEZGIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:08:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264293AbTEZGIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:08:22 -0400
Message-ID: <3ED1B261.8030708@pobox.com>
Date: Mon, 26 May 2003 02:21:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305252236400.10183-100000@home.transmeta.com> <3ED1ABE3.2030007@pobox.com>
In-Reply-To: <3ED1ABE3.2030007@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Linus Torvalds wrote:
>> In other words: I'd really like to see what you can do with a _native_
>> request queue driver, and what the probloems are. And maybe port 
>> _those_ parts of SCSI to it.

> Actually getting down to coding, I see it as a huge amount of work for 
> little gain.  You have to consider all the userspace interfaces, sysfs 
> and device model support that wants coding, -after- you're done with the 
> basic SATA block driver.  Userland proggies already exist for scsi.


Tangenting a bit:

What does the block layer need, that it doesn't have now?

Each major subsystem right now is re-creating driver classes (floppy, 
tape, disk, ...) and that should be moved up and made more general. 
People should use /dev/diskX, /dev/floppyX, /dev/cdromX etc. without 
having to worry about IDE or SCSI or Jeff's SATA or whatever. 
Registration of majors/minors/CIDR/etc.  sysfs.  host 
controller-specific struct request_queue settings.  All these have to be 
recreated each time a new native block driver is created.  If you peer 
closely at some scsi drivers already merged, you see that too chose to 
translate SCSI rather than re-create all the junk necessary for a native 
block driver.  I'm definitely not the first to do what I did.  :)

When such code moves up into the block layer, then we can have a unified 
userland for doing class-specific activities, and then have a few 
bus-specific tools for the ATA- or SCSI-specific needs not met by 
class-general code.

As it stands now, I think a new native block driver creates more user 
confusion and pain than it solves, in addition to saving developer pain, 
if you consider all the device classes and userland tools and such that 
need writing.

	Jeff



