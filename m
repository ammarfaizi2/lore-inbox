Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUBPUWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbUBPUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:22:36 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:20957 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265777AbUBPUVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:21:44 -0500
Date: Mon, 16 Feb 2004 21:21:42 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Marc Lehmann <pcg@schmorp.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040216202142.GA5834@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
	Marc Lehmann <pcg@schmorp.de>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161141140.30742@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 11:48:35AM -0800, Linus Torvalds wrote:

> The way to handle that is to aim to never _ever_ decode utf-8 unless you 
> really have to. Always leave the string in utf-8 "raw bytestring" mode as 
> long as possible, and convert to charater sets only when actually 
> printing.

Additional good news is that following octets in a utf-8 character sequence
always have the highest order bit set, precluding / or \x0 from appearing,
confusing the kernel.

The remaining zit is that all these represent '..':
2E 2E
C0 AE C0 AE
E0 80 AE E0 80 AE 
F0 80 80 AE F0 80 80 AE 
F8 80 80 80 AE F8 80 80 80 AE 
FC 80 80 80 80 AE FC 80 80 80 80 AE

This in itself is not a problem, the kernel will only recognize 2E 2E as the
real .., but it does show that 'document.doc' might be encoded in a myriad
ways.

So some guidance about using only the simplest possible encoding might be
sensible, if we don't want the kernel to know about utf-8.

> And it largely works today.

Indeed.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
