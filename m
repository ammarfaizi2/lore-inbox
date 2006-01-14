Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWANNbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWANNbL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 08:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWANNbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 08:31:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60604 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932248AbWANNbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 08:31:09 -0500
Subject: Re: [patch 00/62] sem2mutex: -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
In-Reply-To: <200601141416.20055.ioe-lkml@rameria.de>
References: <20060113124402.GA7351@elte.hu>
	 <200601131925.34971.ioe-lkml@rameria.de> <20060113195658.GA3780@elte.hu>
	 <200601141416.20055.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 14:31:06 +0100
Message-Id: <1137245466.3014.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 14:16 +0100, Ingo Oeser wrote:
> On Friday 13 January 2006 20:56, Ingo Molnar wrote:
> > * Ingo Oeser <ioe-lkml@rameria.de> wrote:
> > > On Friday 13 January 2006 14:44, Ingo Molnar wrote:
> > > Could we get for each of these and a mutex:
> > > 
> > >  - description 
> > >  - common use case
> > >  - small argument why this and nothing else should be used there
> > 
> > like ... Documentation/mutex-design.txt?
> 
> Much simpler. 
> 
> Take your favorite conversion 

ok the most simple case is really simple.

ALL uses of it have a down() ..... ip() scenario, where all down's are
matched with up's in the same function, no trylocks in sight.

That case is the simple (and most common) case. Since it uses down()
only, it can't be irq context. (trylock could be a sign of irq context
use), and all up()'s are 1) not in irq context either because they're in
the same function as the down() which isn;t and 2) perfectly matched to
the down(), eg each down gets one up ---> perfect semaphore.


The other case on the other side of the spectrum is a down in one
function and an up in an irq function. Which is a pretty good sign of a
completion.... (same is true for a specific scenario where kernel thread
creation is involved and the up() is done in the just created thread).



