Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTFDRoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTFDRoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:44:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45575 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263568AbTFDRob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:44:31 -0400
Date: Wed, 4 Jun 2003 10:57:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <1054745247.9233.119.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306041050250.14593-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Jun 2003, Alan Cox wrote:
>
> On Mer, 2003-06-04 at 15:35, Linus Torvalds wrote:
> > In general, we shouldn't do this, unless somebody can show an application 
> > where it really matters. Taking internal kernel locking into account for 
> > "blockingness" easily gets quite complicated, and there is seldom any real 
> > point to it.
> 
> Hanging shutdown is the obvious one. With 2.0/2.2 we had a similar
> problem and fixed it.

As I tried to point out, the current patch on the table doesn't actually
"fix" anything, in that it can break things even _worse_ than the current
situation.

A much better fix might well be to actually not allow over-long tty writes
at all, and thus avoid the "block out" thing at the source of the problem,
instead of trying to make programs who play nice be the ones that suffer.

If somebody does a 1MB write to a tty, do we actually have any reason to 
try to make it so damn atomic and not return early?

		Linus

