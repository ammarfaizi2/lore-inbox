Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUBYR7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUBYR7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:59:24 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:19496 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261491AbUBYR7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:59:19 -0500
Date: Wed, 25 Feb 2004 20:00:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225190049.GB2474@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	linux-kernel@vger.kernel.org
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224215548.GF1052@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hmm.  Would something (untested) like the following be horribly
> wrong/bad?
> 
> define archhelp
>         @echo '  zImage           - Compressed kernel image (arch/sh/boot/zImage)'
> 	@if [ -d arch/$(ARCH)/configs/SCCS ]; then bk get -q arch/$(ARCH)/configs/;fi
> # Assume board_defconfig
> 	for board in arch/$(ARCH)/configs/*defconfig; \
>         do \
>                  echo -n ' ' $$board | sed -e 's|arch/$(ARCH)/configs/||g' ; \
>                  echo -n '        - Build for ' ; \
>                  echo -e $$board | sed -e 's|.*_||g'; \
>         done
> endef

I do not want kbuild to be cluttered with bk specific stuff.
Also the "- Build for xxxxx" is not good enough.

I will try to come up with a patch the uses a file named
arch/$(ARCH)/configs/index.txt
to actually display the help text. Gim'me a few hours.

	Sam
