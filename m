Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbUBXVzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUBXVzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:55:52 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:23021 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262487AbUBXVzt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:55:49 -0500
Date: Tue, 24 Feb 2004 14:55:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040224215548.GF1052@smtp.west.cox.net>
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222095021.GB2266@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 10:50:21AM +0100, Sam Ravnborg wrote:

> On Sat, Feb 21, 2004 at 09:26:41AM -0500, James H. Cloos Jr. wrote:
> > I was looking at the arch-specific make options for various archs,
> > and found this bit of fun:
> > 
> > :; make help ARCH=sh
> > [elided]
> > Architecture specific targets (sh):
> >   zImage                  - Compressed kernel image (arch/sh/boot/zImage)
> >   SCCS            - Build for arch/sh/configs/SCCS
> >   defconfig-adx           - Build for adx
> >   defconfig-cqreek        - Build for cqreek
> >   defconfig-dreamcast     - Build for dreamcast
> >   defconfig-hp680         - Build for hp680
> >   defconfig-se7751        - Build for se7751
> >   defconfig-snapgear      - Build for snapgear
> >   defconfig-systemh       - Build for systemh
> > [elided]
> > 
> > The defconfig options only show up after a bk get in arch/sh/configs/.
> The sh people have decided to create the list based on the content of the directory.
> Therefore you see the SCCS entry, and that's why you need to do a 'bk bet'.
> In general you cannot expect the konfig and build system to work 100% if there is
> random files missing in the tree. Those files bk can checkout automatically is
> more by luck - and no effort has been put into making this a trustworthy way
> to do it.

Hmm.  Would something (untested) like the following be horribly
wrong/bad?

define archhelp
        @echo '  zImage           - Compressed kernel image (arch/sh/boot/zImage)'
	@if [ -d arch/$(ARCH)/configs/SCCS ]; then bk get -q arch/$(ARCH)/configs/;fi
# Assume board_defconfig
	for board in arch/$(ARCH)/configs/*defconfig; \
        do \
                 echo -n ' ' $$board | sed -e 's|arch/$(ARCH)/configs/||g' ; \
                 echo -n '        - Build for ' ; \
                 echo -e $$board | sed -e 's|.*_||g'; \
        done
endef

I kinda like the idea of documenting the various defconfig targets, in
make help, so maybe even adding that to the normal help section iff
arch/$(ARCH)/configs exists...  Thoughts?

-- 
Tom Rini
http://gate.crashing.org/~trini/
