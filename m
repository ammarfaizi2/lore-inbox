Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSJFXAQ>; Sun, 6 Oct 2002 19:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbSJFXAQ>; Sun, 6 Oct 2002 19:00:16 -0400
Received: from bitmover.com ([192.132.92.2]:34962 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262250AbSJFXAO>;
	Sun, 6 Oct 2002 19:00:14 -0400
Date: Sun, 6 Oct 2002 16:05:48 -0700
From: Larry McVoy <lm@bitmover.com>
To: Skip Ford <skip.ford@verizon.net>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021006160548.A1564@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Skip Ford <skip.ford@verizon.net>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk> <anoivq$35b$1@penguin.transmeta.com> <200210060743.g967hEWf000528@pool-141-150-241-241.delv.east.verizon.net> <20021006163831.GA16144@conectiva.com.br> <200210061703.g96H3w1I004486@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210061703.g96H3w1I004486@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Sun, Oct 06, 2002 at 01:03:57PM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 01:03:57PM -0400, Skip Ford wrote:
> I was thinking more of just sharing the code.  There are more trees out
> there than just Linus'.  Deciding to apply one of your patches is much
> easier if we have the specific patch, rather than just a 600k patch from
> Linus that happens to include your patch buried inside it.

I think a commit trigger is what you want:

	cd BitKeeper
	test -d triggers || mkdir triggers
	cd triggers
	cat > post-commit-linux-patches <<EOF
	#!/bin/sh

	(
	bk changes -v -r+
	bk export -tpatch -r+
	) | mail linux-patches@vger.kernel.edu
	EOF
	bk new post-commit-linux-patches
	bk commit -y'Mail patches to linux-patches'

I haven't tested this but I think this will work, it will mail the patches as
they are created, not as they move through the trees.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
