Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262543AbTDAOFC>; Tue, 1 Apr 2003 09:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262545AbTDAOFC>; Tue, 1 Apr 2003 09:05:02 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:46549 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262543AbTDAOE7>; Tue, 1 Apr 2003 09:04:59 -0500
Date: Wed, 2 Apr 2003 00:18:16 +1000
From: CaT <cat@zip.com.au>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030401141815.GB459@zip.com.au>
References: <fa.eagpkml.m3elbd@ifi.uio.no> <20030401133833.6C71DF3D@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401133833.6C71DF3D@oscar.casa.dyndns.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 08:38:32AM -0500, Ed Tomlinson wrote:
> CaT wrote:
> > tmpfs      /dev/shm tmpfs  rw,size=63%,noauto            0 0
> > 
> > This is taken from my working system and sets the tmpfs size to 63% of
> > my real RAM (256MB). The end result is:
> > 
> > Filesystem           1k-blocks      Used Available Use% Mounted on
> > /dev/shm/tmp            160868      6776    154092   5% /tmp
> 
> What does tmpfs have to do with ram size?  Its swappable.  This _might_ be
> useful for ramfs but for tmpfs, IMHO, its not a good idea.

Basically:

tmpfs size < ram size + swap size

now, lets say a fair bit of your ram dies. you can't repolace it but the
box will manage to run with your new ram size. if the tmpfs size is
static then you get

tmpfs size > new ram size + swap size

and so any process can fill up your ram+swap by writing to tmpfs when
you use tmpfs for /tmp.

By having the tmpfs size be a function of your ram size (as it is by
default at 50%) you wont get that. Currently my tmpfs size is 63%. If
half my ram dies I can still happily use my laptop without any fiddling
because its new size will by 63% of the new ram size (so it'll be around
80MB rather then 160MB). Now, it does mean my /tmp is smaller but
everything is still functional and it's bigger then my root partition,
which I'd rather nto be actively writing to and only has 20MB free by
design.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
