Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263561AbUJ2Xtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUJ2Xtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUJ2Xtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:49:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263561AbUJ2Xs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:48:28 -0400
Date: Fri, 29 Oct 2004 16:52:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: chrisw@osdl.org, bunk@stusta.de, reiser@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-Id: <20041029165208.33034850.akpm@osdl.org>
In-Reply-To: <20041029133631.Q2357@build.pdx.osdl.net>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	<20041029114511.GJ6677@stusta.de>
	<20041029103546.G14339@build.pdx.osdl.net>
	<20041029132016.272c30b2.akpm@osdl.org>
	<20041029133631.Q2357@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris Wright <chrisw@osdl.org> wrote:
> > > I don't think this is needed.  The fix in Linus's tree should be
> > > sufficient, which was simply:
> > > 
> > > -subsys_initcall(key_init);
> > > +security_initcall(key_init);
> > 
> > Problem is with CONFIG_SECURITY=n, CONFIG_KEYS=y.  security_init() is a
> > no-op and we go oops during the first usermodehelper call under
> > driver_init().
> 
> Hmm, right.  Is it worth changing that?  Or do you prefer the explicit
> approach you have?  init ordering is still messy, no matter how we slice
> it.
> 

The only fixes I can see are to do the explicit ordering as I've done, or
to make CONFIG_KEYS depend on CONFIG_SECURITY or to create a new
`exec_initcall' level whose mandate is "stuff which has to be done for a
successful exec".

The patch works.  I'm inclined to leave it as-is...
