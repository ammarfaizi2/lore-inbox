Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbTAOOMf>; Wed, 15 Jan 2003 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbTAOOMf>; Wed, 15 Jan 2003 09:12:35 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:5771 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266443AbTAOOM3>;
	Wed, 15 Jan 2003 09:12:29 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 15 Jan 2003 15:21:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Proposed module init race fix. 
Cc: linux-kernel@vger.kernel.org, adam@yggdrasil.com
X-mailer: Pegasus Mail v3.50
Message-ID: <D4E37953801@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 03 at 20:06, Rusty Russell wrote:
> In message <200301150846.AAA01104@adam.yggdrasil.com> you write:
> > On 2003-01-15, Rusty Russell wrote:
> > >It's possible to start using a module, and then have it fail
> > >initialization.  In 2.4, this resulted in random behaviour.  One
> > >solution to this is to make all interfaces two-stage: reserve
> > >everything you need (which might fail), the activate them.  This
> > >means changing about 1600 modules, and deprecating every interface
> > >they use.
> > 
> >   Could you explain this "random behavior" of 2.4 a bit more?
> > As far as I know, if a module's init function fails, it must
> > unregister everything that it has registered up to that point.
> 
> And if someone's using it, the module gets unloaded underneath them.

No. Unregister will go to sleep until it is safe to unregister
driver. See unregister_netdevice for perfect example, but I'm sure
that there are other unregister functions which make sure that after
unregister it is OK to destroy everything.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
