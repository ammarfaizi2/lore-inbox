Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267315AbUBSVhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267573AbUBSVf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:35:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267386AbUBSVeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:34:03 -0500
Date: Thu, 19 Feb 2004 13:38:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Tridge <tridge@samba.org>, Jamie Lokier <jamie@shareable.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-Reply-To: <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402191334410.1439@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402181511420.18038@home.osdl.org>
 <20040219081027.GB4113@mail.shareable.org> <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
 <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
 <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
 <20040219204515.GG31035@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402191255540.1439@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004, Linus Torvalds wrote:
> 
> No no. Look at how this works:
>  - only one dentry actually exists.

That was really badly phrased. There can be _millions_ of these things,
but they are all "unique" - they have zero impact on each other, and have
no linkages. They never shadow any existing dentries (ie when we create
these, we'd obviously never create a tentative dentry with the same name
as an existing _valid_ dentry), and they are never visible to the 
filesystem. 

So it's not that "only one dentry" exists, but that that this tentative
dentry only exists as a unique marker of "a dentry of this name _may_
exist".

		Linus
