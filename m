Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291555AbSBMK6d>; Wed, 13 Feb 2002 05:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291562AbSBMK6U>; Wed, 13 Feb 2002 05:58:20 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:10503 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S291555AbSBMK5D>; Wed, 13 Feb 2002 05:57:03 -0500
Date: Wed, 13 Feb 2002 11:56:25 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
        Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213105625.GI32687@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3C6A418A.8040105@evision-ventures.com> <Pine.LNX.4.10.10202130228180.1479-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202130228180.1479-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, after looking at yours code close engough I have one advice for 
> > you as well: LEARN C.
> 
> I specialize in storage, and C is self taught.

Okay, few things to keep in mind:

*) cut-copy-paste is bad. If you fix error in one copy, it is _very_
easy not to fix it in other copies.

*) void *'s and casts are bad. They hide real errors. If you have 

struct foo {} bar;

and want 

bar * baz;

later;

You can write it as struct foo * baz. That will make type checks
actually work and save you lot of casts. 

*) hungarian notation is considered evil in kernel.

struct bla_s {} bla_t;

*is* evil -- why have two types when one is enough? In kernel land,
right way is to do 

struct bla {};

and then use "struct bla" everywhere you'd use bla_t. It might be
slightly longer, but it helps you with casts (above) and everyone can
see what is going on.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
