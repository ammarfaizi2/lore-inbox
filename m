Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFXKTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFXKTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:19:34 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:55938 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261797AbTFXKTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:19:33 -0400
Date: Tue, 24 Jun 2003 12:33:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: Provide example copy_in_user implementation
Message-ID: <20030624103308.GF159@elf.ucw.cz>
References: <20030624100610.GC159@elf.ucw.cz> <20030624032904.13213eb8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624032904.13213eb8.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static inline unsigned long copy_in_user(void *dst, const void *src, unsigned size) 
> >  +{ 
> >  +	unsigned i, ret;
> >  +	unsigned char c;
> >  +	for (i=0; i<size; i++) {
> >  +		if (copy_from_user(&c, src+i, 1)) 
> >  +			return size-i;
> >  +		if (copy_to_user(dst+i, &c, 1))
> >  +			return size-i;
> >  +	}
> >  +	return 0;
> >  +}	
> >  +
> 
> I know that this is usually not performance critical, but by gawd that code
> is inefficient and bloaty.
> 
> It has 18 callsites; it can be put in lib/lib.a:copy_in_user.o.  The
> access_ok() checks only need to be run once.  It can copy a cacheline at a
> time.

It was meant to demonstrate calling convention of copy_in_user();
architectures probably want to modify their copy_from_user to be able
to copy into user, too; usually that can be done at 0 overhead.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
