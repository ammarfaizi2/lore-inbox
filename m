Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTANEG2>; Mon, 13 Jan 2003 23:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTANEG2>; Mon, 13 Jan 2003 23:06:28 -0500
Received: from havoc.daloft.com ([64.213.145.173]:53732 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267267AbTANEG1>;
	Mon, 13 Jan 2003 23:06:27 -0500
Date: Mon, 13 Jan 2003 23:15:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [TRIVIAL] kstrdup
Message-ID: <20030114041514.GA4844@gtf.org>
References: <20030114025452.656612C385@lists.samba.org> <200301140328.h0E3SFqZ004587@turing-police.cc.vt.edu> <20030114033803.GG404@gtf.org> <200301140353.h0E3rWqZ004900@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301140353.h0E3rWqZ004900@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:53:32PM -0500, Valdis.Kletnieks@vt.edu wrote:
> That's cool, long as everybody agrees on that - I've already filled my career
> quota of chasing down bugs due to non-threadsafe use of str*() functions. ;)

Don't worry, it's pretty much a rule in Linux, IMO.  Synchronization
belongs _above_ simple data type primitives like strings or lists.

That's why answering your email was quick and easy ;-)
The Linux answer is "don't do that" :)


> All the same, I'd probably feel better if it used strncpy() instead - there'd
> still be the possibility of copying now-stale data, but at least you'd not be
> able to walk off the end of the *new* array's allocated space....

_Not_ doing things like this is a reason why Linux is so fast in certain
areas :)  Linus preaches over and over, "do what you need to do, and no
more."

But having said that -- see my mail to Rusty about storing the strlen()
result and then calling memcpy().  It [purposefully] does not address
the fact that the string may become stale data, because it's the job of
a higher level to ensure that.  But it does make explicit a compiler
temporary, and allows us to use the presumeably-faster memcpy().

Not that kstrdup() matters a whole lot, but anyway...

	Jeff



