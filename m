Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbSKMCGa>; Tue, 12 Nov 2002 21:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbSKMCGa>; Tue, 12 Nov 2002 21:06:30 -0500
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:20923 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S267101AbSKMCG3>; Tue, 12 Nov 2002 21:06:29 -0500
Date: Tue, 12 Nov 2002 18:13:07 -0800
From: Brad Heilbrun <bheilbrun@paypal.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [2.5-bk] Module loader compile bug
Message-ID: <20021113021307.GA8238@paypal.com>
Reply-To: bheilbrun@paypal.com
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20021112050319.GA3651@paypal.com> <20021112172423.818182C2A0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112172423.818182C2A0@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 04:23:26AM +1100, Rusty Russell wrote:
> In message <20021112050319.GA3651@paypal.com> you write:
> > I realize you're still working on this, but current bk is broken if
> > you turn off module unload support. In include/linux/module.h we get:
> > 
> > 	#else /*!CONFIG_MODULE_UNLOAD*/
> > <snip>
> > 	#define symbol_put_addr(p) do { } while(0)
> > 	
> > 	#endif /* CONFIG_MODULE_UNLOAD */
> > 	
> > Which upsets this line in kernel/module.c 
> > 
> > 	  void symbol_put_addr(void *addr)
> > 
> > After the preprocessor gets a hold of it all, gcc doesn't know what to
> > make of "void do { } while(0)".
> 
> Yep, symbol_put_addr() in module.c should be moved under __symbol_put.
> 
> Patch is fairly trivial, does this work for you?

Yes, thanks.

-- 
Brad Heilbrun
