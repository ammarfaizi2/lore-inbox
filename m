Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTFIPU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTFIPU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:20:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264464AbTFIPU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:20:56 -0400
Date: Mon, 9 Jun 2003 08:34:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kevin Corry <kevcorry@us.ibm.com>
cc: Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] dm: signed/unsigned audit
In-Reply-To: <200306091003.27762.kevcorry@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0306090830360.12683-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jun 2003, Kevin Corry wrote:
>
> On Monday 09 June 2003 09:35, Joe Thornber wrote:
> > signed/unsigned audit.
> 
> > -	int minor, r = -EBUSY;
> > +	unsigned int m, r = -EBUSY;
> 
> Looks like "r" should still be signed.

Yes.

Guys, be _very_ careful if you do audits based on the -Wsigned flag to
gcc, because THE WARNING OUTPUT OF GCC IS OFTEN TOTAL CRAP.

I consider the -Wsigned flag to be more harmful than not, since a
noticeable percentage of the warnings are for code that is perfectly ok,
and rewriting the code to avoid the warning can lead to very subtle bugs
(or just makes the code less readable).

Some of the false warnings could probably be fixed with some fairly
trivial value range analysis, and I'm hopeful that -Wsign can some day 
actually be worthwhile, but for now I really wish people be very very 
careful.

		Linus

