Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTEZFsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 01:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTEZFsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 01:48:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264279AbTEZFsF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 01:48:05 -0400
Message-ID: <3ED1ADA0.9080500@pobox.com>
Date: Mon, 26 May 2003 02:01:04 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305252240490.10183-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305252240490.10183-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 26 May 2003, Jeff Garzik wrote:
> 
>>I think with SATA + drivers/ide, you reach a point of diminishing 
>>returns versus amount of time spent on mid-layer coding.
> 
> 
> I think that's a valid approach, and just have a special driver for SATA. 
> That's not the part I worry about. 

You're still at a point of diminishing returns for a native driver too.

ATAPI support would be a pain.  Can't use drivers/ide/* nor ide-scsi.

Userland support is nonexistent, and users would have start using yet 
another set of tools to deal with their disks, instead of the existing 
[scsi] ones.

Device model, power management, hotplugging are all handled or 
in-the-works for scsi, and they are exactly what SATA needs.  I would 
have to recreate all that handling from scratch.

I think you're missing how much code and pain is actually saved by using 
the scsi layer...  like I mentioned in the last message, long-term, 
these issues can (and should) be solved by moving some of this stuff out 
of the scsi layer into the block layer, creating an overall desirable 
flattening effect of all code involved.


> The part I worry about is the SCSI layer itself, and also potential user
> confusion.

I think this can only benefit the scsi layer and continue its trend of 
becoming more lightweight and lib'ified.

WRT user confusion, I agree:  that's why PATA is a config option.  I 
would prefer people think "SATA? use my driver.  PATA? use drivers/ide"

Andre suggested that I might support PCI PATA controllers in my driver 
"officially", but I think user confusion and transition issues rule out 
that, for non-hackers.

	Jeff



