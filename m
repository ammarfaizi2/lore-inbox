Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUBPPiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbUBPPiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:38:23 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:29568 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265708AbUBPPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:36:16 -0500
Date: Mon, 16 Feb 2004 15:46:21 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402161546.i1GFkLqx000741@81-2-122-30.bradfords.org.uk>
To: Valdis.Kletnieks@vt.edu, Eduard Bloch <edi@gmx.de>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
References: <20040209115852.GB877@schottelius.org>
 <200402121655.39709.robin.rosenberg.lists@dewire.com>
 <20040213003839.GB24981@mail.shareable.org>
 <200402130216.53434.robin.rosenberg.lists@dewire.com>
 <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
 <20040213032305.GH25499@mail.shareable.org>
 <20040214150934.GA5023@zombie.inka.de>
 <20040215010150.GA3611@mail.shareable.org>
 <20040216140338.GA2927@zombie.inka.de>
 <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  - convert all files from the previous charset to UTF-8 overnight
> >    if the previous charset was unknown, first make sure that you can
> >    guess it for all users and contact users that have files with
> >    suspicous filenames (eg. not convertable from Latin1). Or look troug=
> h
> >    their shell/X config files (*)
> 
> Hazardous.
> 
> >  - in libc, implement a recoding function to convert file names from
> >    LC_CTYPE to the underlying UTF-8 encoding
> 
> Hmm.. could be fun if somebody is calling 'open', and the UTF-8 encoding
> requires the insertion of extra characters to encode it - what do you do =
> then?
> That looks like a security hole just waiting to happen.  Probably has lot=
> s of
> lurking corner cases too - what if you creat() a file, then do a readdir(=
> ) and
> strcmp() each entry looking for your file (while comparing a filename sma=
> shed
> to UTF-8 to the original unsmashed string)?

The current situation is that so many applications simply treat
filenames as arbitrary sequences of bytes.  With many encodings, this
simply happens to work, and an encoding mis-match will result in some
incorrect characters being displayed for byte values > 127.  However,
some encodings, such as UTF-8, are simply _not_ compatible with the
'you can also treat it like an arbitrary byte string model', and there
is a very real potential for security holes in bad implementations if
we go down the "it's an arbitrary byte string, but you _should_ store
UTF-8 there" route.

Maybe we should forget filename encoding altogether, and start
thinking of filenames as arbitrary sequences of _32-bit words_.
Existing applications can store their arbitrary byte sequences in the
low byte, and new calls can be added to provide Unicode-aware
userspace applications with access to the 32-bit space, which _must_
be used for UCS-4.

John.
