Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTE2NKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbTE2NKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:10:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53416
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262222AbTE2NKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:10:48 -0400
Date: Thu, 29 May 2003 15:24:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       m.c.p@wolk-project.de, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529132431.GK1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <200305290000.12116.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305290000.12116.kernel@kolivas.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 12:00:11AM +1000, Con Kolivas wrote:
> On Wed, 28 May 2003 20:23, Andrew Morton wrote:
> > Could you please work out which change caused it?  Go back to stock 2.4 and
> > then apply this:
> >
> [snip] 1
> 
> > then this:
> [snip] 2
> 
> > Then this (totally unlikely, don't bother):
> [snip] 3
> 
> Ok patch combination final score for me is as follows in the presence of a 
> large continuous write:
> 1 No change
> 2 No change
> 3 improvement++; minor hangs with reads
> 1+2 improvement+++; minor pauses with switching applications
> 1+2+3 improvement++++; no pauses

then please try 1+2 alone too (i.e. w/o 3), because it's not obvious to me
that you're really the race in 3 in a single write (I spotted and just
fixed such a race in my tree some months ago, but thought it was a
theoretical one only, I mean on x86).

The improvement++ might be just an emotional feeling if you didn't
generate numbers to measure it (I know on myself it can happen when you
try a new patch, that everything seems faster until you really measure
it ;).

> Applications may start up slowly that's fine. The mouse cursor keeps spinning 
> and responding at all times though with 1+2+3 which it hasn't done in 2.4 for 

the mouse cursor always worked and still works fine for me (and I was
just running with 3 applied, just to get the theretical bit correct).

> a year or so.
> 
> Con


Andrea
