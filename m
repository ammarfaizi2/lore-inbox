Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUATSHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 13:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265622AbUATSHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 13:07:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:31751 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265621AbUATSHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 13:07:39 -0500
Date: Tue, 20 Jan 2004 19:11:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] -mm5 has no i2c on amd64
Message-ID: <20040120181108.GC12912@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
References: <20040120124626.GA20023@bytesex.org> <20040120091035.0fb7b3ee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120091035.0fb7b3ee.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 09:10:35AM -0800, Andrew Morton wrote:
> >   Hi,
> > 
> > trivial fix ...
> > 
> >   Gerd
> > 
> > ==============================[ cut here ]==============================
> > --- linux-mm5-2.6.1/arch/x86_64/Kconfig.i2c	2004-01-20 13:14:42.000000000 +0100
> > +++ linux-mm5-2.6.1/arch/x86_64/Kconfig	2004-01-20 13:15:10.000000000 +0100
> > @@ -429,6 +429,8 @@
> >  
> >  source "drivers/char/Kconfig"
> >  
> > +source "drivers/i2c/Kconfig"
> > +
> >  source "drivers/misc/Kconfig"
> >  
> 
> Ah-hah!  That's why the ppc64 kbuild system is whining about undefined but
> used i2c symbols:
> 
> drivers/ieee1394/Kconfig:60:warning: enable is only allowed with boolean and tristate symbols
> drivers/media/video/Kconfig:13:warning: enable is only allowed with boolean and tristate symbols
> 
> So this change needs to be propagated to other architectures as well.

The better approach is to use the generic drivers/Kconfig,
as used by i386, parisc and cris today.

	Sam
