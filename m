Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261655AbTCHAxg>; Fri, 7 Mar 2003 19:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCHAwf>; Fri, 7 Mar 2003 19:52:35 -0500
Received: from hera.cwi.nl ([192.16.191.8]:16326 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261655AbTCHAq1>;
	Fri, 7 Mar 2003 19:46:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Mar 2003 01:57:00 +0100 (MET)
Message-Id: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, greg@kroah.com
Subject: Re: [PATCH] register_blkdev
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> social issues, that probably need to be answered first

Why worry? Why first?

Here are patches that go in the right direction, as
everybody agrees, I think.
So far Linus has taken my recent dev_t related patches
(even though the last two did not appear under my name).

I don't think anybody is willing to commit himself blindly
to unseen patches.

> a lot of drivers have static arrays where they just "know" that
> there can't be more than 256 minors under their control.

That does not matter so much.

There is the matter of correctness and the matter of power.
I worry most about correctness.

So my first job is to make sure that no bad minor is ever used
as array index. Fortunately registration is not by major but
by dev_t interval, so things tend to be correct automatically.

That is the audit-for-correctness part. Then there is the
power part. If a driver wants to handle many minors, it
can register a large range, or several ranges, possibly
dynamically. These changes are done on a driver-by-driver basis,
and need not be done before the type of dev_t is switched.

Andries
