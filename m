Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWEAIA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWEAIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWEAIA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:00:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4321 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751323AbWEAIA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:00:27 -0400
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060501004925.36e4dd21.akpm@osdl.org>
References: <20060501071134.GH3570@stusta.de>
	 <20060501001803.48ac34df.akpm@osdl.org> <20060501073514.GQ3570@stusta.de>
	 <1146469146.20760.31.camel@laptopd505.fenrus.org>
	 <20060501004925.36e4dd21.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 01 May 2006 10:00:21 +0200
Message-Id: <1146470421.20760.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 00:49 -0700, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > If removing exports requires a process, adding exports requires a 
> >  > similar process.
> > 
> >  alternatively we should bite the bullet, and just stick those 900 on the
> >  "we'll kill all these in 3 months" list, have a thing to disable them
> >  now via a config option (so that people actually notice rather than just
> >  having them in the depreciation file) and fix the 5 or 10 or so that
> >  actually will be used soon in those 3 months.
> > 
> 
> I'd instead suggest that we implement a new EXPORT_SYMBOL_UNEXPORT_SCHEDULED

EXPORT_UNUSED_SYMBOL() ? (with comment of date)

(well you didn't apply the patch for that I sent you so I suppose you
hate it ;)


> (?) and use that.  Suitable compile-time and modprobe-time warnings would

compiletime warning is hard, because it would require changing
prototype, which is a lot more churn, and I'll bet a lot of exports
don't even have a prototype at all. modprobe time is easy. (middle
ground would be depmod time; that's almost compile time I suppose but a
lot easier, but might need modutils help)

> be needed.  Put the unexport date in a comment at the
> EXPORT_SYMBOL_UNEXPORT_SCHEDULED site or even in the modprobe-time warning
> message, if that's convenient:
> 
> EXPORT_SYMBOL_UNEXPORT_SCHEDULED(foo, "Dec 2006");

comment is easy, putting a date in is really sucky since it grows the size of exports even more..
(which means people pay even more export tax than they do today)


