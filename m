Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRGPBI6>; Sun, 15 Jul 2001 21:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264204AbRGPBIr>; Sun, 15 Jul 2001 21:08:47 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:2313 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262634AbRGPBIp>;
	Sun, 15 Jul 2001 21:08:45 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107160108.f6G18fJ299454@saturn.cs.uml.edu>
Subject: Re: [PATCH] 64 bit scsi read/write
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Sun, 15 Jul 2001 21:08:41 -0400 (EDT)
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
In-Reply-To: <01071515442400.05609@starship> from "Daniel Phillips" at Jul 15, 2001 03:44:14 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Sunday 15 July 2001 05:36, Chris Wedgwood wrote:
>> On Sat, Jul 14, 2001 at 10:11:30PM +0200, Daniel Phillips wrote:

>>> Atomic commit.  The superblock, which references the updated
>>> version of the filesystem, carries a sequence number and a
>>> checksum.  It is written to one of two alternating locations.  On
>>> restart, both locations are read and the highest numbered
>>> superblock with a correct checksum is chosen as the new
>>> filesystem root.
>>
>> Yes... and which ever part of the superblock contains the sequence
>> number must be written atomically.
>
> The only requirement here is that the checksum be correct.  And sure,
> that's not a hard guarantee because, on average, you will get a good
> checksum for bad data once every 4 billion power events that mess up
> the final superblock transfer.  Let me see, if that happens once a year,

In a tree-structured filesystem, checksums on everything would only
cost you space similar to the number of pointers you have. Whenever
a non-leaf node points to a child, it can hold a checksum for that
child as well.

This gives a very reliable way to spot filesystem errors, including
corrupt data blocks.

