Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbVINJUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbVINJUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbVINJUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:20:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24339 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965103AbVINJUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:20:23 -0400
Date: Wed, 14 Sep 2005 10:20:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: kbuild-permanently-fix-kernel-configuration-include-mess.patch added to -mm tree
Message-ID: <20050914102016.B30672@flint.arm.linux.org.uk>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@gmail.com>,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <200509140841.j8E8fG1w022954@shell0.pdx.osdl.net> <2cd57c900509140205572f19b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2cd57c900509140205572f19b7@mail.gmail.com>; from coywolf@gmail.com on Wed, Sep 14, 2005 at 05:05:57PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 05:05:57PM +0800, Coywolf Qi Hunt wrote:
> On 9/14/05, akpm@osdl.org <akpm@osdl.org> wrote:
> > 
> > The patch titled
> > 
> >      kbuild: permanently fix kernel configuration include mess.
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      kbuild-permanently-fix-kernel-configuration-include-mess.patch
> > 
> > 
> > From: Russell King <rmk+lkml@arm.linux.org.uk>
> > 
> > Include autoconf.h into every kernel compilation via the gcc command line
> > using -imacros.  This ensures that we have the kernel configuration
> > included from the start, rather than relying on each file having #include
> > <linux/config.h> as appropriate.  History has shown that this is something
> > which is difficult to get right.
> 
> Not all compilations need config.h included and this slows down gratuitously.

That is a small price to pay, rather than having to continually maintain
"does this file need config.h included" - which I think can conclusively
be shown to be a total lost cause.  There are about 3450 configuration
include errors in the kernel as of -git last night.

Getting config.h includes wrong causes subtle bugs - for instance, one
file may be built with some feature enabled which changes a structure
size, and another filfe may be built with it disabled.

I put forward that maintaining correct config.h include across all
files is demonstratably impossible in such a large source base without
considerable work.

I also put forward that the percentage of compilations which do not need
config.h is small and probably realistically zero.

Therefore, I think that a small slowdown for the few (if any) files which
don't need linux/config.h including is a good tradeoff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
