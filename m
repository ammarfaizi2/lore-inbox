Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263545AbUJ2Udy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbUJ2Udy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUJ2UdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:33:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:9372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263526AbUJ2UWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:22:42 -0400
Date: Fri, 29 Oct 2004 13:20:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: bunk@stusta.de, reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-Id: <20041029132016.272c30b2.akpm@osdl.org>
In-Reply-To: <20041029103546.G14339@build.pdx.osdl.net>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	<20041029114511.GJ6677@stusta.de>
	<20041029103546.G14339@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Adrian Bunk (bunk@stusta.de) wrote:
> > On Fri, Oct 29, 2004 at 01:49:30AM -0700, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.10-rc1-mm1:
> > >...
> > > +key_init-ordering-fix.patch
> 
> I don't think this is needed.  The fix in Linus's tree should be
> sufficient, which was simply:
> 
> -subsys_initcall(key_init);
> +security_initcall(key_init);

Problem is with CONFIG_SECURITY=n, CONFIG_KEYS=y.  security_init() is a
no-op and we go oops during the first usermodehelper call under
driver_init().

