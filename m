Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWFNAHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWFNAHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 20:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWFNAHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 20:07:50 -0400
Received: from hera.kernel.org ([140.211.167.34]:15001 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932370AbWFNAHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 20:07:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Tue, 13 Jun 2006 17:07:40 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6nk0c$8el$1@terminus.zytor.com>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <448F2A49.5020809@google.com> <20060613154031.A6276@openss7.org> <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150243660 8662 127.0.0.1 (14 Jun 2006 00:07:40 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 14 Jun 2006 00:07:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0606131655580.4856@turbotaz.ourhouse>
By author:    Chase Venters <chase.venters@clientec.com>
In newsgroup: linux.dev.kernel
> >
> > Why not?  Not all non-GPL modules are proprietary.  Do we lose
> > something by making a nice stable api available to non-derived
> > modules?
> 
> Look out for that word (stable). Judging from history (and sanity), 
> arguing /in favor of/ any kind of stable module API is asking for it.
> 
> At least some of us feel like stable module APIs should be explicitly 
> discouraged, because we don't want to offer comfort for code 
> that refuses to live in the tree (since getting said code into the tree is 
> often a goal).
> 

The much bigger problem is that there is a substantial cost to
maintaining a stable API.  The VFS in Linux, for example, was
relatively stable from long before the 1.0 days until the 2.0 series.
However, in 2.1 there was a radical change -- the dcache -- which
broke every filesystem driver in fundamental ways.  This was followed
by quite a bit of instability as all the various filesystems adapted,
and sometimes fed back requirements to the original code.

This type of iterative programming is by definition forbidden if the
API is to be stable, and is substantially harder if it has to be done
in a coordinated fashion.  It took long enough as it is.

Stable *ABIs* are even worse, and are hard even for userspace to deal
with, and generally involve adding costly conversion layers.

So it is all a matter about what you expect from a "stable" API.

	-hpa
