Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265259AbUD3U2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUD3U2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUD3U2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:28:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:18315 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265259AbUD3U2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:28:47 -0400
Date: Fri, 30 Apr 2004 13:31:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: corbet@lwn.net (Jonathan Corbet)
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se, ak@suse.de
Subject: Re: [BUG] 2.6.6-rc2-bk5 mm/slab.c change broke x86-64 SMP
Message-Id: <20040430133110.5b9d293f.akpm@osdl.org>
In-Reply-To: <20040430192911.14289.qmail@lwn.net>
References: <20040430112704.3dca3c4c.akpm@osdl.org>
	<20040430192911.14289.qmail@lwn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corbet@lwn.net (Jonathan Corbet) wrote:
>
> > Does this fix?
> > 
> > diff -puN include/asm-x86_64/processor.h~a include/asm-x86_64/processor.h
> > --- 25/include/asm-x86_64/processor.h~a	Fri Apr 30 11:24:58 2004
> > +++ 25-akpm/include/asm-x86_64/processor.h	Fri Apr 30 11:25:28 2004
> > @@ -20,6 +20,8 @@
> >  #include <asm/mmsegment.h>
> >  #include <linux/personality.h>
> >  
> > +#define ARCH_MIN_TASKALIGN L1_CACHE_BYTES
> > +
> 
> That made my x86_64 boot problem go away; with that patch the system comes
> up just fine.

OK, thanks.  It broke parisc too...

> Now I have weird display problems with my Radeon card instead.  Ever seen X
> running 100% in kernel space, unkillable?

I did, about a year ago.  It was spinning madly in some ioctl waiting for a
bit in a device register to change state.  Are you able to generate a
kernel profile while it's being silly?  That will tell us where it's stuck.
