Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbVIOBHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbVIOBHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVIOBHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:07:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21411 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030321AbVIOBHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:07:19 -0400
Date: Thu, 15 Sep 2005 02:07:14 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050915010714.GY25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org> <20050911231601.GL25261@ZenIV.linux.org.uk> <20050912191525.GA13435@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912191525.GA13435@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 09:15:25PM +0200, Sam Ravnborg wrote:
> Because we leave it to the build system to figure out what .h file to
> include, and thus letting the build system having full knowledge we make
> sure to recompile whatever is needed when we change subarch.
> Without the asm symlink in the kernel it would just work in many cases
> when you changed architecture.

Correct cross-toolchain would be picked by some miracle, presumably?
Both for include/asm and for include/asm-um/arch...  And after that
we win a stunning fraction of percent - some of the generated files
do _not_ depend on any target .o, so we will avoid rebuilding them.

Note that in cases when rebuild involving symlink change _is_ possible
(e.g. arm or sh subarch) we already get the right thing - change it in
.config and symlinks will be flipped.
