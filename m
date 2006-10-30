Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWJ3P2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWJ3P2p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030532AbWJ3P2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:28:45 -0500
Received: from smtp19.orange.fr ([80.12.242.18]:29704 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1030529AbWJ3P2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:28:44 -0500
X-ME-UUID: 20061030152842738.B44AF1C00050@mwinf1918.orange.fr
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Xavier Bestel <xavier.bestel@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, matthew@wil.cx, pavel@ucw.cz,
       shemminger@osdl.org
In-Reply-To: <1162220757.2948.29.camel@laptopd505.fenrus.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
	 <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
	 <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
	 <1162219080.2948.21.camel@laptopd505.fenrus.org>
	 <1162220452.30605.47.camel@frg-rhel40-em64t-03>
	 <1162220757.2948.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 16:28:35 +0100
Message-Id: <1162222115.30605.52.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 16:05 +0100, Arjan van de Ven wrote:
> On Mon, 2006-10-30 at 16:00 +0100, Xavier Bestel wrote:
> > On Mon, 2006-10-30 at 15:38 +0100, Arjan van de Ven wrote:
> > 
> > > how much of this complexity goes away if you consider the
> > > scanning/probing as a series of "work elements", and you end up with a
> > > queue of work elements that threads can pull work off one at a time (so
> > > that if one element blocks the others just continue to flow). If you
> > > then find, say, a new PCI bus you just put another work element to
> > > process it at the end of the queue, or you process it synchronously. Etc
> > > etc.
> > > 
> > > All you need to scale then is the number of worker threads on the
> > > system, which should be relatively easy to size....
> > > (check every X miliseconds if there are more than X outstanding work
> > > elements, if there are, spawn one new worker thread if the total number
> > > of worker threads is less than the system wide max. Worker threads die
> > > if they have nothing to do for more than Y miliseconds)
> > 
> > Instead of checking every X ms, just check at each job insertion.
> 
> that would lead to a too eager amount of threads if processing the jobs
> is really really quick ...

Don't you have a "no more than X threads at once" limit ? You just
*check* at job insertion, not unconditionnaly fork.

	Xav

