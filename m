Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVC2Kwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVC2Kwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVC2KwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:52:18 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:35547 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262332AbVC2Kvp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:51:45 -0500
Date: Tue, 29 Mar 2005 12:46:22 +0200 (CEST)
To: akpm@osdl.org
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use)
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <xyDqcv4K.1112093182.7253990.khali@localhost>
In-Reply-To: <20050328222348.4c05e85c.akpm@osdl.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Adrian Bunk" <bunk@stusta.de>, "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, all,

> >  Think about it. If the pointer could be NULL, then it's unlikely that
> >  the bug would have gone unnoticed so far (unless the code is very
> >  recent). Coverity found 3 such bugs in one i2c driver [1], and the
> >  correct solution was to NOT check for NULL because it just couldn't
> >  happen.
>
> No, there is a third case: the pointer can be NULL, but the compiler
> happened to move the dereference down to after the check.

Wow. Great point. I completely missed that possibility. In fact I didn't
know that the compiler could possibly alter the order of the
instructions. For one thing, I thought it was simply not allowed to. For
another, I didn't know that it had been made so aware that it could
actually figure out how to do this kind of things. What a mess. Let's
just hope that the gcc folks know their business :)

I'll try to remember this next time I debug something. Do not assume
that instructions are run in the order seen in the source. Irk.

> If the optimiser is later changed, or if someone tries to compile the code
> with -O0, it will oops.

Interesting. Then wouldn't it be worth attempting such compilations at
times, and see if we get additional oops? Doesn't gcc have a flag to
specifically forbid this family of optimizations?

Thanks,
--
Jean Delvare
