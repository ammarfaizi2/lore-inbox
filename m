Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWFYRnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWFYRnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFYRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:43:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12247 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932431AbWFYRnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:43:19 -0400
Subject: Re: [PATCH] i386: Fix softirq accounting with 4K stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, danial_thom@yahoo.com,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1151257451.7858.45.camel@Homer.TheSimpsons.net>
References: <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
	 <1151142716.7797.10.camel@Homer.TheSimpsons.net>
	 <1151149317.7646.14.camel@Homer.TheSimpsons.net>
	 <20060624154037.GA2946@atjola.homenet>
	 <1151166193.8516.8.camel@Homer.TheSimpsons.net>
	 <20060624192523.GA3231@atjola.homenet>
	 <1151211993.8519.6.camel@Homer.TheSimpsons.net>
	 <20060625111238.GB8223@atjola.homenet>
	 <20060625142440.GD8223@atjola.homenet>
	 <1151257451.7858.45.camel@Homer.TheSimpsons.net>
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Jun 2006 19:43:17 +0200
Message-Id: <1151257397.4940.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 19:44 +0200, Mike Galbraith wrote:
> On Sun, 2006-06-25 at 16:24 +0200, Björn Steinbrink wrote:
> 
> > Still no idea why your "fix" works, but the following patch also fixes
> > the problem and is at least a little more like the RightThing.
> 
> Yeah.  I don't know about you, but I fully intend to blatantly ignore
> that 'why' ;-)

the why is relatively easy ;)

since the "is a softirq executing" bit is on the stack, and each context
(user, soft and hard irq) has their own stack, it's not automatic that
the hardirq stack gets the softirq-executing flag... which your patch
fixes.

NMI's and apic irqs generally don't go via the normal irq path and thus
don't do a stack switch... so they don't lose the bit (for accounting
purposes)


