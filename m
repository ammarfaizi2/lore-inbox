Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318802AbSICTgS>; Tue, 3 Sep 2002 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318818AbSICTgS>; Tue, 3 Sep 2002 15:36:18 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:12950 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318802AbSICTgR>;
	Tue, 3 Sep 2002 15:36:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
Date: Tue, 3 Sep 2002 21:42:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Pavel Machek <pavel@suse.cz>, Peter Chubb <peter@chubb.wattle.id.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020827185833.B26573@redhat.com> <15732.34929.657481.777572@notabene.cse.unsw.edu.au>
In-Reply-To: <15732.34929.657481.777572@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mJZh-0005jw-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 12:01, Neil Brown wrote:
> On Tuesday August 27, bcrl@redhat.com wrote:
> > On Tue, Aug 27, 2002 at 03:23:04PM +0000, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Then the following works properly without ugly casts or warnings:
> > > > 
> > > > 	__u64 val = 1;
> > > > 
> > > > 	printk("at least "PFU64" of your u64s are belong to us\n", val);
> > > 
> > > Casts are ugly but this looks even worse. I'd go for casts.
> > 
> > Casts override the few type checking abilities the compiler gives us.  At 
> > least with the PFU64 style, we'll get warnings when someone changes a variable 
> > into a pointer without remembering to update the printk.
> > 
> 
> You could have the best of both worlds with:
> 
> static inline long long llsect(sector_t sector) { return (long long)sector;}
> 
> and then
>    printk("The sector number is %Lu.", llsect(sect_num));
> 
> Effectively, this is a type-safe cast.  You still get the warning, but
> it looks more like the C that we are used to.

We've been through this before.  Last time, the winning solution was:

   printk("at least %lli of your u64s are belong to us\n", (long long) sect_num);

and I expect it will be this time too.  It's just a printk!  Who cares if it
wastes a few bytes.  It's even conceivable that if we use this idiom heavily
enough, some gcc boffin will take the time to optimize away the useless
conversions.

-- 
Daniel
