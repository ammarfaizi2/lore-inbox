Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRKHV23>; Thu, 8 Nov 2001 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278584AbRKHV2T>; Thu, 8 Nov 2001 16:28:19 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:935 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S278566AbRKHV2J>; Thu, 8 Nov 2001 16:28:09 -0500
Date: Thu, 8 Nov 2001 16:28:02 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <964381385.1005245622@[195.224.237.69]>
Message-ID: <Pine.GSO.4.33.0111081612240.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Alex Bligh - linux-kernel wrote:
>For instance, take the /proc/mounts type example, where

(bad example as /proc/mounts is supposed to be a substiture for /etc/mtab.)

>each row is a sequence of binary values. Someone decides
>to add another column, which assuming it is a DWORD^W__u64,
>does exactly this, inserts a DWORD^W__u64 between the
>end of one record and the start of the next as far a
>poorly written parser is concerned.

Then make it hard ("impossible") to write a poor parser; include a record
size in the data format.  The first __u32 read is the number of bytes per
record.  You then know exactly how much data to read.  Adding more crap on
the end doesn't break anything.

People who think binary data formats are bad and hard to work with should
take a few minutes to look at various implementation using binary data
structures.  For example, RADIUS.

>The brokenness is not due to the distinction between ASCII
>and binary. The brokenness is due the ill-defined nature
>of the format, and poor change control. (so for instance
>the ASCII version could consistently use (say) quoted strings,
>with spaces between fields, and \n between records, just
>as the binary version could have a record length entry at the
>head of each record, and perhaps field length and identifier
>versions by each field - two very similar solutions to the
>problem above).

Correct.  The issue is not which is easier to work with, or endian friendly.
A properly designed structure, which we still don't have, is the key.  It's
just as straight forward to tokenize binary fields as text fields.  Then you
have to do something with the data in the fields.  Binary is far more
efficient in almost all cases.

People should not shit a brick at the suggestion of doing _some_ things
as binary structures.  The parts of /proc that really are intended for humans
(ie. driver "debug" information... /proc/slabinfo, /proc/drivers/rd/..., etc.)
don't make sense in binary.  However, there are loads of things that DO make
sense in binary format -- too many things reference them for further processing
requiring conversion from/to text multiple times.  The number of people
who do:
 % grep -l foo /proc/[0-9]*/cmdline
instead of:
 % ps auxwww | grep foo
are very VERY low.

--Ricky


