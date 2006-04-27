Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWD0JIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWD0JIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWD0JIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:08:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43746 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964994AbWD0JIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:08:18 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20060427085614.GE3570@stusta.de>
References: <1146046118.7016.5.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
	 <1146049414.7016.9.camel@laptopd505.fenrus.org>
	 <20060426110656.GD29108@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>
	 <445061DC.5030008@yahoo.com.au>
	 <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI>
	 <1146120640.2894.1.camel@laptopd505.fenrus.org>
	 <20060427083157.GD3570@stusta.de>
	 <1146127273.2894.21.camel@laptopd505.fenrus.org>
	 <20060427085614.GE3570@stusta.de>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 11:08:05 +0200
Message-Id: <1146128885.2894.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 10:56 +0200, Adrian Bunk wrote:
> On Thu, Apr 27, 2006 at 10:41:12AM +0200, Arjan van de Ven wrote:
> > On Thu, 2006-04-27 at 10:31 +0200, Adrian Bunk wrote:
> > > On Thu, Apr 27, 2006 at 08:50:40AM +0200, Arjan van de Ven wrote:
> > > > On Thu, 2006-04-27 at 09:28 +0300, Pekka J Enberg wrote:
> > > > > On Thu, 27 Apr 2006, Nick Piggin wrote:
> > > > > > Not to dispute your conclusions or method, but I think doing a
> > > > > > defconfig or your personal config might be more representative
> > > > > > of % size increase of text that will actually be executed. And
> > > > > > that is the expensive type of text.
> > > > > 
> > > > > True but I was under the impression that Arjan thought we'd get text 
> > > > > savings with GCC 4.1 by making kfree() inline.
> > > > 
> > > > not savings in text size, I'll settle for the same size.
> > > >...
> > > 
> > > It will always be bigger since there are cases where it's unknown at 
> > > compile time whether it will be NULL when called.
> > 
> > if it's "unknown" you could call into a separate kfree() which does
> > check out of line. (sure that's a dozen bytes bigger but that is
> > noise ;)
> 
> It's noise and _much work.

not if the compiler can do it. The *compiler* knows a lot (4.1 at
least)..

