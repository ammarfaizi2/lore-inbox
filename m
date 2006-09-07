Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWIGQbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWIGQbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 12:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWIGQbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 12:31:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932268AbWIGQbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 12:31:40 -0400
Date: Thu, 7 Sep 2006 09:27:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olaf@aepfle.de>, Adrian Bunk <bunk@stusta.de>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrey Mirkin <amirkin@sw.ru>, devel@openvz.org, mikpe@it.uu.se,
       sam@ravnborg.org
Subject: Re: [PATCH] fail kernel compilation in case of unresolved symbols
 (v2)
Message-Id: <20060907092738.f4088e7d.akpm@osdl.org>
In-Reply-To: <45003985.7060304@sw.ru>
References: <44FFEE5D.2050905@openvz.org>
	<20060907110513.GA22319@aepfle.de>
	<20060907111329.GI25473@stusta.de>
	<20060907122607.GA22882@aepfle.de>
	<45003985.7060304@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Sep 2006 19:23:49 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> Olaf Hering wrote:
> > On Thu, Sep 07, Adrian Bunk wrote:
> > 
> > 
> >>If any module shipped with the kernel has in any configuration 
> >>unresolved symbols that's a bug that should be reported, not ignored.
> > 
> > 
> > Yes, but on request when building the package. Not per default.
> > I probably missed the reason why this is now suddenly a problem.
> It is not that sudden at all. I experienced this problem many times so far
> and working with a build system came to the idea of failing
> builds when there are unresolved symbols.
> 
> I'm pretty sure that having this patch in mainstream
> will make unresolved symbols a rare problem as many of them will be fixed soon.
> So I'm pretty agree with Adrian that modules with unresolved symbols is a bug
> and it MUST be fixed.
> I would be very much interested to hear Andrew opinion on this as
> he probably makes kernels even more often than any of us :)
> 

Am sympathetic to the idea.

Some architectures (eg sparc64) generate large numbers of unresolved module
symbol warnings during an allmodconfig build.  It's not a big problem in
practice - these are subsystems which everyone statically links anyway.

But it does mean that additional work needs to be done if we want to
prevent these allmodconfig builds from erroring out.
