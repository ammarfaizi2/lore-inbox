Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUBYSJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUBYSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:09:05 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:62698 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261509AbUBYSJA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:09:00 -0500
Date: Wed, 25 Feb 2004 11:08:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225180858.GW1052@smtp.west.cox.net>
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225190049.GB2474@mars.ravnborg.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 08:00:49PM +0100, Sam Ravnborg wrote:
> > 
> > Hmm.  Would something (untested) like the following be horribly
> > wrong/bad?
> > 
> > define archhelp
> >         @echo '  zImage           - Compressed kernel image (arch/sh/boot/zImage)'
> > 	@if [ -d arch/$(ARCH)/configs/SCCS ]; then bk get -q arch/$(ARCH)/configs/;fi
> > # Assume board_defconfig
> > 	for board in arch/$(ARCH)/configs/*defconfig; \
> >         do \
> >                  echo -n ' ' $$board | sed -e 's|arch/$(ARCH)/configs/||g' ; \
> >                  echo -n '        - Build for ' ; \
> >                  echo -e $$board | sed -e 's|.*_||g'; \
> >         done
> > endef
> 
> I do not want kbuild to be cluttered with bk specific stuff.

I can understand that.  How about:
for board in arch/$(ARCH)/configs/*defconfig; \
 do \
   if [ -f $board ]; then
    ...
   fi
 done

> Also the "- Build for xxxxx" is not good enough.

Erm, it's usually something descriptive enough, if one is firmiliar with
the platform / what's intended to build.

> I will try to come up with a patch the uses a file named
> arch/$(ARCH)/configs/index.txt

The 'issue' with configs/index.txt, I'll wager, is that for every new
board, that's one more file to modify (and thus possibly conflict on).

-- 
Tom Rini
http://gate.crashing.org/~trini/
