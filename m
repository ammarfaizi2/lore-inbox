Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263627AbUJ2Xy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbUJ2Xy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbUJ2Xy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:54:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:60627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263632AbUJ2Xxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:53:47 -0400
Date: Fri, 29 Oct 2004 16:53:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, bunk@stusta.de, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-ID: <20041029165340.V2357@build.pdx.osdl.net>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041029114511.GJ6677@stusta.de> <20041029103546.G14339@build.pdx.osdl.net> <20041029132016.272c30b2.akpm@osdl.org> <20041029133631.Q2357@build.pdx.osdl.net> <20041029165208.33034850.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041029165208.33034850.akpm@osdl.org>; from akpm@osdl.org on Fri, Oct 29, 2004 at 04:52:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > * Andrew Morton (akpm@osdl.org) wrote:
> > > Chris Wright <chrisw@osdl.org> wrote:
> > > > I don't think this is needed.  The fix in Linus's tree should be
> > > > sufficient, which was simply:
> > > > 
> > > > -subsys_initcall(key_init);
> > > > +security_initcall(key_init);
> > > 
> > > Problem is with CONFIG_SECURITY=n, CONFIG_KEYS=y.  security_init() is a
> > > no-op and we go oops during the first usermodehelper call under
> > > driver_init().
> > 
> > Hmm, right.  Is it worth changing that?  Or do you prefer the explicit
> > approach you have?  init ordering is still messy, no matter how we slice
> > it.
> > 
> 
> The only fixes I can see are to do the explicit ordering as I've done, or
> to make CONFIG_KEYS depend on CONFIG_SECURITY or to create a new
> `exec_initcall' level whose mandate is "stuff which has to be done for a
> successful exec".

Or make sure security_init() still does security_initcalls when
CONFIG_SECURITY=n.

> The patch works.  I'm inclined to leave it as-is...

I was thinking of something similar to your exec_initcall idea.  Right
now, the early exec stuff is a no-op until do_initcalls(), which is pretty
late, because there's not any binfmt handlers registered.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
