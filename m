Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWDVTyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWDVTyP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWDVTxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:53:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:36036 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751101AbWDVTxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:53:33 -0400
Date: Sat, 22 Apr 2006 15:20:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422132032.GB5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422123835.GA5010@stusta.de> <1145710123.11909.241.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145710123.11909.241.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 01:48:43PM +0100, David Woodhouse wrote:
> On Sat, 2006-04-22 at 14:38 +0200, Adrian Bunk wrote:
> > What was the recommended way for getting userspace header at last
> > year's kernel summit?
> 
> It was said that we need _incremental_ changes, and this is an attempt
> to satisfy that request.
> 
> > > The important thing is that we all get our editors out and clean up the
> > > _contents_ our own headers, and actually start to _think_ about the
> > > visibility of any new header-file content we introduce. Let's not
> > > concentrate too much on the implementation details of how we actually
> > > get those to userspace.
> > 
> > Currently, it's said the kernel headers aren't suitable for userspace.
> 
> Indeed they aren't.
> 
> > After the cleanups you propose, the kernel headers will be suitable for 
> > userspace (the copy steps you propose are not required, distributions 
> > could equally start to copy the verbatim headers again).
> 
> After the _first_ stage of the cleanups I propose, the export step will
> still be necessary. You'll need to pick those headers which are intended
> to be user-visible, and leave behind those which are not. 
> 
> If we actually go on to abolish __KERNEL__ and move the public headers
> to a separate directory, you're right -- as I said, one day hopefully
> it'll just be 'cp -a'. But that is not the _first_ stage. We need to do
> this incrementally.
>...

Why can't the splitting happen incrementally?

Assume you have a header include/linux/foo.h:
- Add an #include <kabi/linux/foo.h> at the top.
- Move the part of the contents that is part of the userspace ABI to 
  include/kabi/linux/foo.h.

When this is done for all headers containing parts of the userspace ABI:
- test the kabi/ headers in userspace
- review all headers under kabi/ since what's there will become a fixed
  ABI that can never be changed
- test the kabi/ headers in userspace
- make the ABI headers official

For kernel code, this header splitting should be completely transparent
(and nothing outside include/ should directly include headers under 
include/kabi/).

For userspace, this will be one switch from the many different header 
packages floating around to the new ABI headers, but it should break 
nearly none usespace applications (it will break some abuses, but
that's OK).

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

