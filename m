Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSICKAz>; Tue, 3 Sep 2002 06:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSICKAz>; Tue, 3 Sep 2002 06:00:55 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:62376 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318717AbSICKAy>; Tue, 3 Sep 2002 06:00:54 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Date: Tue, 3 Sep 2002 20:01:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15732.34929.657481.777572@notabene.cse.unsw.edu.au>
Cc: Pavel Machek <pavel@suse.cz>, Peter Chubb <peter@chubb.wattle.id.au>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: message from Benjamin LaHaise on Tuesday August 27
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au>
	<20020823070759.GS19435@clusterfs.com>
	<20020827152303.L35@toy.ucw.cz>
	<20020827185833.B26573@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 27, bcrl@redhat.com wrote:
> On Tue, Aug 27, 2002 at 03:23:04PM +0000, Pavel Machek wrote:
> > Hi!
> > 
> > > Then the following works properly without ugly casts or warnings:
> > > 
> > > 	__u64 val = 1;
> > > 
> > > 	printk("at least "PFU64" of your u64s are belong to us\n", val);
> > 
> > Casts are ugly but this looks even worse. I'd go for casts.
> 
> Casts override the few type checking abilities the compiler gives us.  At 
> least with the PFU64 style, we'll get warnings when someone changes a variable 
> into a pointer without remembering to update the printk.
> 

You could have the best of both worlds with:

static inline long long llsect(sector_t sector) { return (long long)sector;}

and then
   printk("The sector number is %Lu.", llsect(sect_num));

Effectively, this is a type-safe cast.  You still get the warning, but
it looks more like the C that we are used to.

NeilBrown

