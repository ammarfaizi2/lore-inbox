Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbRGXE36>; Tue, 24 Jul 2001 00:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRGXE3t>; Tue, 24 Jul 2001 00:29:49 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:47377 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S266907AbRGXE3l>;
	Tue, 24 Jul 2001 00:29:41 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107240429.f6O4Tdt274181@saturn.cs.uml.edu>
Subject: Re: [PATCH] 64 bit scsi read/write
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Tue, 24 Jul 2001 00:29:39 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), tuxx@aon.at (Alexander Griesser),
        phillips@bonn-fries.net (Daniel Phillips), cw@f00f.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <01072316412405.00315@starship> from "Daniel Phillips" at Jul 23, 2001 04:41:24 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips writes:
> On Sunday 22 July 2001 05:52, Albert D. Cahalan wrote:
>> [...]
>>> On Sun, Jul 15, 2001 at 09:08:41PM -0400, you wrote:

>>>> In a tree-structured filesystem, checksums on everything would
>>>> only cost you space similar to the number of pointers you have.
>>>> Whenever a non-leaf node points to a child, it can hold a checksum
>>>> for that child as well.  This gives a very reliable way to spot
>>>> filesystem errors, including corrupt data blocks.
...
>> To have a child is to have a checksum+pointer pair.
...
> I agree that your suggestion will work and that doubling the size
> of the metadata isn't an enormous cost, especially if you'd already
> compressed it using extents.  On the other hand, sometimes I just
> feel like trusting the hardware a little.  Both atomic-commit and
> journalling strategies take care of normal failure modes, and the
> disk hardware is supposed to flag other failures by ecc'ing each
> sector on disk.

Maybe you should discuss power-loss behavior with Theodore T'so.
For whatever reason, it seems that many drives and/or controllers
like to scribble on random unrelated sectors as power is lost.

For the atomic-commit case, an additional defense against this
sort of problem might be to keep a few extra trees on disk,
using a generation counter to pick the latest one. This does
bring us back to scanning the whole filesystem at boot though,
in order to disregard snapshots that have been damaged.


