Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992804AbWKAUYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992804AbWKAUYm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992803AbWKAUYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:24:42 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:4840 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S2992801AbWKAUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:24:41 -0500
Date: Wed, 1 Nov 2006 21:24:00 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holden Karau <holden@pigscanfly.ca>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, Holden Karau <holdenk@xandros.com>,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised again
Message-ID: <20061101202400.GA6888@wohnheim.fh-wedel.de>
References: <4548C8AE.2090603@pigscanfly.ca> <20061101164715.GC16154@wohnheim.fh-wedel.de> <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f46018bb0611011002h1b3b6e5fjdc6cc032a7503dbd@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 November 2006 13:02:12 -0500, Holden Karau wrote:
> On 11/1/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> >Result would be something like:
> >        c_bh = kmalloc(...
> >        err = -ENOMEM;
> >        if (!c_bh)
> >                goto error;
> That wouldn't work so well since we always return err,

I don't quite follow.  If the branch is taken, err is -ENOMEM.  If the
branch is not taken, err is set to 0 with the next instruction.

Both methods definitely work.  Whether one is preferrable over the
other is imo 90% taste and maybe 10% better code on some architecture.
So just pick what you prefer.

Jörn

-- 
Unless something dramatically changes, by 2015 we'll be largely
wondering what all the fuss surrounding Linux was really about.
-- Rob Enderle
