Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319066AbSHSUa5>; Mon, 19 Aug 2002 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSHSUa5>; Mon, 19 Aug 2002 16:30:57 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24192 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319066AbSHSUa4>;
	Mon, 19 Aug 2002 16:30:56 -0400
Date: Mon, 20 Aug 2001 20:03:16 +0000
From: Pavel Machek <pavel@suse.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
Message-ID: <20010820200315.A111@toy.ucw.cz>
References: <3D4F942D.7020100@colorfullife.com> <20020806.022813.27560736.davem@redhat.com> <3D4F9A19.5040100@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D4F9A19.5040100@colorfullife.com>; from manfred@colorfullife.com on Tue, Aug 06, 2002 at 11:42:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   From: Manfred Spraul <manfred@colorfullife.com>
> >   Date: Tue, 06 Aug 2002 11:17:33 +0200
> >
> >   > -		printk("No.\n");
> >   > +		printk("No (that's security hole).\n");
> >   >  #ifdef CONFIG_X86_WP_WORKS_OK
> >   
> >   Could you explain the hole?
> >   WP works for user space apps, only ring0 (or ring 0-2?) code
> >   ignores the WP bit on i386.
> >
> >So copy_to_user() could write to user areas that are write-proteced.
> >
> >verify_area() checks aren't enough, consider a threaded application
> >calling mprotect() while the copy is in progress.

> Then we should either fix copy_to_user(), or mark 80386 unsupported, or 
> disable multi-threading on 80386. It's a random memory corruption, far 
> worse than a security hole.

Fortunately app has to be seriously missbehaving for this to happen. Fixing
copy_to_user would be nicest; I do not think dropping 386 because of *this*
is good idea... [But it might force 386 users to fix copy_to_user ;-)]

									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

