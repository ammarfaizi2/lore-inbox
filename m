Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWEAJGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWEAJGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEAJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:06:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15294 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751150AbWEAJGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:06:37 -0400
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060501085939.GV3570@stusta.de>
References: <20060501071134.GH3570@stusta.de>
	 <20060501001803.48ac34df.akpm@osdl.org> <20060501073514.GQ3570@stusta.de>
	 <1146469146.20760.31.camel@laptopd505.fenrus.org>
	 <20060501004925.36e4dd21.akpm@osdl.org>  <20060501085939.GV3570@stusta.de>
Content-Type: text/plain
Date: Mon, 01 May 2006 11:06:34 +0200
Message-Id: <1146474394.20760.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 10:59 +0200, Adrian Bunk wrote:
> On Mon, May 01, 2006 at 12:49:25AM -0700, Andrew Morton wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > >
> > > > If removing exports requires a process, adding exports requires a 
> > >  > similar process.
> > > 
> > >  alternatively we should bite the bullet, and just stick those 900 on the
> > >  "we'll kill all these in 3 months" list, have a thing to disable them
> > >  now via a config option (so that people actually notice rather than just
> > >  having them in the depreciation file) and fix the 5 or 10 or so that
> > >  actually will be used soon in those 3 months.
> > > 
> > 
> > I'd instead suggest that we implement a new EXPORT_SYMBOL_UNEXPORT_SCHEDULED
> > (?) and use that.  Suitable compile-time and modprobe-time warnings would
> > be needed.  Put the unexport date in a comment at the
> > EXPORT_SYMBOL_UNEXPORT_SCHEDULED site or even in the modprobe-time warning
> > message, if that's convenient:
> > 
> > EXPORT_SYMBOL_UNEXPORT_SCHEDULED(foo, "Dec 2006");
> 
> __deprecated_for_modules already does everything required for compile 
> time warnings.

it's wrong level though; it works on the prototype not on the export
itself

> So the work would expand to:
> - writing 200 feature-removal-schedule.txt entries
> - marking 200 functions and variables as __deprecated_for_modules

not really; all one needs is 1 entry in f-r-s covering all 900 exports
and 2 actions: 1) mark those 900 as unused now, and 2) remove those 900
lines a few months from now


