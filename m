Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131502AbRBNOTq>; Wed, 14 Feb 2001 09:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132278AbRBNOTg>; Wed, 14 Feb 2001 09:19:36 -0500
Received: from smtp7.us.dell.com ([143.166.224.233]:30990 "EHLO
	smtp7.us.dell.com") by vger.kernel.org with ESMTP
	id <S132221AbRBNOTZ>; Wed, 14 Feb 2001 09:19:25 -0500
Date: Wed, 14 Feb 2001 08:19:22 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <Andries.Brouwer@cwi.nl>
cc: <Matt_Domsch@exchange.dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <UTC200102132349.AAA97331.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0102140810500.1882-100000@carthage.michaels-house.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001 Andries.Brouwer@cwi.nl wrote:

> But it changes the idea of odd and even.
> A partition can start on an odd sector.
>

That is orthogonal to the issue that I am trying to solve with my patch.
My code is trying to make it possible to access sectors at the _end_ of
the disk that you cannot access any other way. Example:

Disk with 1001 blocks. Hardware 512-byte sector size. The block layer uses
1024-byte soft blocksize. This means that, at the _end_ of the disk there
is a single sector that represents half of a software sector. The block
layer will not normally let you read or write that sector because it is
not a full sector.

Another example: Disk with 7 blocks (very small disk :-). Hardware
blocksize=512, Block layer uses 4096-byte blocksize. Now you have _three_
hardware blocks at the end of the disk that the block layer will not let
you read or write.

My patch allows an alternate method to access these sectors. My patch has
nothing to do with partitioning.

--
Michael Brown
Linux Systems Group
Dell Computer Corp

