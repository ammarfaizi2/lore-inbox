Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUBVDLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUBVDLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:11:17 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:52608 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261658AbUBVDLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:11:14 -0500
Date: Sat, 21 Feb 2004 19:11:13 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222031113.GB13840@dingdong.cryptoapps.com>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:03:50PM -0800, Linus Torvalds wrote:

> It's quite likely that especially on a fairly idle machine, the
> dentry cache really _should_ be the biggest single memory user.

Only because updatedb/find/du populate it sporadically.  things like
cron jobs run over night and fill the slab which *never* shrinks[1].

> Do you see any actual bad behaviour from this?

The page-cache is restricted to small sizes making the fs rather slow
at times.  Ideally with 1.5GB of RAM I'd like to be able to get 800MB
or so into the page-cache... not 200MB.

Maybe gradual page-cache pressure could shirnk the slab?


  --cw


