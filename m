Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWAWRGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWAWRGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWAWRGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:06:39 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46538 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964824AbWAWRGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:06:38 -0500
Subject: Re: [PATCH] slab: Adds two missing kmalloc() checks.
From: Arjan van de Ven <arjan@infradead.org>
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060123150128.eb12603f.lcapitulino@mandriva.com.br>
References: <20060123133121.70f2cbcb.lcapitulino@mandriva.com.br>
	 <1138034316.10527.2.camel@localhost>
	 <1138034695.2977.48.camel@laptopd505.fenrus.org>
	 <1138035122.10527.10.camel@localhost>
	 <20060123150128.eb12603f.lcapitulino@mandriva.com.br>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 18:06:30 +0100
Message-Id: <1138035991.2977.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 15:01 -0200, Luiz Fernando Capitulino wrote:
>  Hi Pekka, Arjan,
> 
> On Mon, 23 Jan 2006 18:52:02 +0200
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> | On Mon, 2006-01-23 at 18:38 +0200, Pekka Enberg wrote:
> | > > Looks good to me. Arjan, you had some objections last time around. Are
> | > > you okay with the change?
> | 
> | On Mon, 2006-01-23 at 17:44 +0100, Arjan van de Ven wrote:
> | > I still fail to see the point. Has anyone EVER seen these trigger????
> | 
> | Yeah, we probably won't. They seem useful for people who hunt unchecked
> | kmalloc() calls, though.
> 
>  It really looks useful to me. You don't check for fail because someone has
> seen the fail happen. You check for fail in order to have a robust program.

Generally you are right. You check for fail because you can recover the
failure. In this case the code happens during real early boot, and if it
fails you CANNOT BOOT. And you have so little memory, that it's highly
unlikely that you even got this far. -> You only make the kernel bigger
without any win at all.

Don't get me wrong. Most of the null pointer checks are useful. Just the
ones where you can't recover ANYWAY are not. A BUG_ON() is not better
than just hitting a GPF due to a null pointer, in either case you don't
boot, and probably so early you don't get to see the message either, and
when you do see it.. you get no additional information.



