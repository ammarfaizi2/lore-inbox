Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUBPTvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUBPTvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:51:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:13280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265853AbUBPTvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:51:10 -0500
Date: Mon, 16 Feb 2004 11:48:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Bradford <john@grabjohn.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Marc Lehmann <pcg@schmorp.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
In-Reply-To: <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.58.0402161141140.30742@home.osdl.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
 <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com>
 <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, John Bradford wrote:
> 
> The real problem is with mis-configured userspaces, where buggy UTF-8
> decoders are trying to make sense of data in legacy encodings
> containing essentially random bytes > 127, which are not part of valid
> UTF-8 sequences.
> 
> None of this is a real problem, if everything is set up correctly and
> bug free.  Unfortunately the Just Works thing falls apart in the,
> (frequent), instances that it's not :-(.

The way to handle that is to aim to never _ever_ decode utf-8 unless you 
really have to. Always leave the string in utf-8 "raw bytestring" mode as 
long as possible, and convert to charater sets only when actually 
printing.

If you do that, then at worst you'll show the user a strange name (extra
points for marking it as being errenous), but everything still works. You
can still lookup/delete/whatever the file (internally the program still
works on the raw byte sequence and isn't confused). Basically accept the
fact that UTF-8 strings can contain "garbage", and don't try to fix it up.

And no, I'm not claiming that it's wonderfully clean and that we should
all love it. But it's _practical_, and the ugliness is certainly a lot
less than in the alternatives.

And it largely works today.

		Linus
