Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUJ2Uwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUJ2Uwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbUJ2UvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:51:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:7592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263550AbUJ2Ugc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:36:32 -0400
Date: Fri, 29 Oct 2004 13:36:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, bunk@stusta.de, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-ID: <20041029133631.Q2357@build.pdx.osdl.net>
References: <20041029014930.21ed5b9a.akpm@osdl.org> <20041029114511.GJ6677@stusta.de> <20041029103546.G14339@build.pdx.osdl.net> <20041029132016.272c30b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041029132016.272c30b2.akpm@osdl.org>; from akpm@osdl.org on Fri, Oct 29, 2004 at 01:20:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> > I don't think this is needed.  The fix in Linus's tree should be
> > sufficient, which was simply:
> > 
> > -subsys_initcall(key_init);
> > +security_initcall(key_init);
> 
> Problem is with CONFIG_SECURITY=n, CONFIG_KEYS=y.  security_init() is a
> no-op and we go oops during the first usermodehelper call under
> driver_init().

Hmm, right.  Is it worth changing that?  Or do you prefer the explicit
approach you have?  init ordering is still messy, no matter how we slice
it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
