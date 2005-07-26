Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVGZWQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVGZWQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVGZWQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:16:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29851 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262180AbVGZWQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:16:43 -0400
Date: Wed, 27 Jul 2005 00:14:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050726221446.GA24196@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <42DA7B12.7030307@domdv.de> <20050725201036.2205cac3.akpm@osdl.org> <20050726220428.GA7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726220428.GA7425@waste.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > the attached patches are acked by Pavel and signed off by me
> > 
> > OK, well I queued this up, without a changelog.  Because you didn't send
> > one.  Please do so.  As it adds a new feature, quite a bit of info is
> > relevant.
> 
> I don't like this patch. It reinvents a fair amount of dm_crypt and
> cryptoloop but badly. 
> 
> Further, the model of security it's using is silly. In case anyone
> hasn't noticed, it stores the password on disk in the clear. This is
> so it can erase it after resume and thereby make recovery of the
> suspend image hard.
> 
> But laptops get stolen while they're suspended, not while they're up
> and running. And if your box is up and running and an attacker gains
> access, the contents of your suspend partition are the least of your
> worries. It makes no sense to expend any effort defending against this
> case, especially as it's liable to become a barrier to doing this
> right, namely with real dm_crypt encrypted swap.

Well, "how long are my keys going to stay in swap after
swsusp"... that's pretty scary.

To prevent "stolen while suspended" case... you'd either need to enter
password both during suspend and during resume, or you'd need
asymetric crypto... Rather heavy.

> At the very least, this should be renamed SWSUSP_QUICK_WIPE and any
> mention of encryption should be taken out of the description so users
> don't mistakenly think it provides any sort of useful protection.

SWSUSP_WIPE seems like a better name, right.

							Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
