Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTI3LjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTI3LjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:39:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1030 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261344AbTI3LjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:39:17 -0400
Date: Tue, 30 Sep 2003 13:39:12 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, bunk@fs.tum.de,
       acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930113912.GA1731@mars.ravnborg.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@redhat.com>, bunk@fs.tum.de,
	acme@conectiva.com.br, netdev@oss.sgi.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030930000302.3e1bf8bb.davem@redhat.com> <1064907572.21551.31.camel@hades.cambridge.redhat.com> <20030930010855.095c2c35.davem@redhat.com> <1064910398.21551.41.camel@hades.cambridge.redhat.com> <20030930013025.697c786e.davem@redhat.com> <1064911360.21551.49.camel@hades.cambridge.redhat.com> <20030930015125.5de36d97.davem@redhat.com> <1064913241.21551.69.camel@hades.cambridge.redhat.com> <20030930022410.08c5649c.davem@redhat.com> <1064916168.21551.105.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064916168.21551.105.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:02:49AM +0100, David Woodhouse wrote:
> On Tue, 2003-09-30 at 02:24 -0700, David S. Miller wrote:
> > I think they are the same.  It's module building depending upon the
> > kernel image being up to date.
> > 
> > modules: vmlinux image
> > 	... blah blah blah
> > 
> > or however you want to express it in the makefiles.
> 
> In the case of modversions, we are talking about the fact that it may be
> physically _impossible_ to build a module referencing an in-kernel
> symbol, if the checksum required for that symbol -- the 'version string'
> -- is not yet calculated. If the version strings are generated as a
> side-effect of compiling the files which actually export the symbols in
> question, then it's necessary to do that before building any module
> which attempts to use those symbols.
The version strings are made from info obtained from vmlinux and the *.o
files.
So vmlinux is a prerequisite to calculate the version string.
And to get vmlinux you need to build the kernel.
And the build system will check all dependencies when it needs vmlinux.

> Note that it's not actually necessary to provide a vmlinux file, nor to
> do any linking. It's only necessary to perform those steps which produce
> the version strings for those symbols actually referenced by the modules
> which are being built.

Which require vmlinux and other module.o files.

> That is the requirement for correctness from the makefiles; nothing
> more. Of course it's usually considered acceptable for the makefiles to
> recompile _more_ than is necessary

I would like to know if there exists any cases where _more_ (or less)
is being build.
Mostly I consider it a bug in such case, but there are a few corner cases.

[Only commenting on the kbuild side of things - I'm not trying to be 
involved in the other part of the discussion ;-)]

	Sam
