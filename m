Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUBPPcc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265681AbUBPPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:32:32 -0500
Received: from mail.shareable.org ([81.29.64.88]:13188 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265665AbUBPPca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:32:30 -0500
Date: Mon, 16 Feb 2004 15:32:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Valdis.Kletnieks@vt.edu
Cc: Eduard Bloch <edi@gmx.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216153224.GE16658@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de> <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402161518.i1GFIpn2008826@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> >  - in libc, implement a recoding function to convert file names from
> >    LC_CTYPE to the underlying UTF-8 encoding
> 
> Hmm.. could be fun if somebody is calling 'open', and the UTF-8 encoding
> requires the insertion of extra characters to encode it - what do you do then?

> That looks like a security hole just waiting to happen.  Probably
> has lots of lurking corner cases too - what if you creat() a file,
> then do a readdir() and strcmp() each entry looking for your file
> (while comparing a filename smashed to UTF-8 to the original
> unsmashed string)?

Actually, following Eduard's proposal, that would work fine.  The file
name would be passed to libc in the current encoding, created in
UTF-8, libc's readdir() would convert it back (which is always
possible without mangling), and strcmp() would be fine.

The real problem comes when you readdir() a directory which contains
non-UTF-8 names.  Even if you changes your local filesystem, when you
go travelling an remotely-mounted filesystem elsewhere may have them.
What does Eduard's libc do then?  Ignore the names?  Mangle them?

Not to mention the extremely unpleasant performance implications.

-- Jamie
