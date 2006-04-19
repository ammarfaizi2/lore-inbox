Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWDSPnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWDSPnE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWDSPnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:43:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15517 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750917AbWDSPnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:43:03 -0400
Subject: RE: searching exported symbols from modules
From: Arjan van de Ven <arjan@infradead.org>
To: Antti Halonen <antti.halonen@secgo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF5154E0@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF5154E0@titanium.secgo.net>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 17:43:00 +0200
Message-Id: <1145461380.3085.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 18:34 +0300, Antti Halonen wrote:
> Thanks for your persistence!
> 
> > but to what purpose?
> > what on earth do you need this for?
> > Again you talk about solutions not about the problem you're trying to
> > solve.
> 
> I have module which has set of algorithms. When I load my module, I will
> initialize my function pointer interface to point to these algorithms.
> And then go ahead and use my pointers trough the application...
> 
> This way I can easily add new algorithm implementations into my product
> and decide on the fly which ones to initialize into use.
>  
> Now. It happens that I have another module which offers algorithms I
> want to be able to use. So when I shoot up my module it should be able
> to initialize
> either the ones the external module offers or use the internal
> algorithms. In order to do this, I need to figure out on the fly if the
> other module is present, where it is, where I can find the function
> addresses...

a better way would be then to have a "core" module which is basically
collecting these algorithms, and then have the algorithm modules, when
they are loaded, register themselves with this core module. (and
unregister at unload). It's sort of inside-out with they way you're
trying to do it, but it'll work out a lot nicer. Obviously the user of
the algorithms can be another module in addition to this core module.
(and even register algorithms itself)
There's many examples in the kernel that work similar to this, for
example the crypto framework.


