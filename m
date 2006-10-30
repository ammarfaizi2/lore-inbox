Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWJ3PG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWJ3PG1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWJ3PG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:06:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49825 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030389AbWJ3PG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:06:26 -0500
Subject: Re: [patch] drivers: wait for threaded probes between initcall
	levels
From: Arjan van de Ven <arjan@infradead.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, matthew@wil.cx, pavel@ucw.cz,
       shemminger@osdl.org
In-Reply-To: <1162220452.30605.47.camel@frg-rhel40-em64t-03>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
	 <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
	 <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com>
	 <1162219080.2948.21.camel@laptopd505.fenrus.org>
	 <1162220452.30605.47.camel@frg-rhel40-em64t-03>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 16:05:57 +0100
Message-Id: <1162220757.2948.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-30 at 16:00 +0100, Xavier Bestel wrote:
> On Mon, 2006-10-30 at 15:38 +0100, Arjan van de Ven wrote:
> 
> > how much of this complexity goes away if you consider the
> > scanning/probing as a series of "work elements", and you end up with a
> > queue of work elements that threads can pull work off one at a time (so
> > that if one element blocks the others just continue to flow). If you
> > then find, say, a new PCI bus you just put another work element to
> > process it at the end of the queue, or you process it synchronously. Etc
> > etc.
> > 
> > All you need to scale then is the number of worker threads on the
> > system, which should be relatively easy to size....
> > (check every X miliseconds if there are more than X outstanding work
> > elements, if there are, spawn one new worker thread if the total number
> > of worker threads is less than the system wide max. Worker threads die
> > if they have nothing to do for more than Y miliseconds)
> 
> Instead of checking every X ms, just check at each job insertion.

that would lead to a too eager amount of threads if processing the jobs
is really really quick ...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

