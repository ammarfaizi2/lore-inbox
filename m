Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTJAVKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTJAVKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:10:39 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51468 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262583AbTJAVJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:09:29 -0400
Date: Wed, 1 Oct 2003 23:09:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] check headers for complete includes, etc.
Message-ID: <20031001210926.GA1011@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org> <20031001094825.GB31698@wohnheim.fh-wedel.de> <20031001163930.GA11493@mars.ravnborg.org> <20031001180114.GA9657@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031001180114.GA9657@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 08:01:14PM +0200, Jörn Engel wrote:
> > > +my $basename = "lib/header";
> > I much rather have it be: include/headercheck
> > then people realise where eventual temporary files comes from.
> 
> Doesn't work in include/, there is no include/Makefile.  But lib/ is a
> hack, I agree.

Sigh, OK.

> > So we need something like the following here: (untested)
> > >  
> > > +headercheck: prepare-all
> > > +	$(PERL) scripts/checkheader.pl $(if $(KBUILD_VERBOSE),-verbose)
> > > +

Forgot that KBUILD_VERBOSE is always defined.
Try:
$(if $(KBUILD_VERBOSE:0=),--verbose)

prepare-all exist in BK-latest.
The purpose is to create the asm-$(ARCH) -> asm symlink.
Add an dependency on include/asm, that should do it.

Try:
make mrproper
make headercheck

To test it before and after.

	Sam
