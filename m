Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316519AbSHRXOL>; Sun, 18 Aug 2002 19:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHRXOL>; Sun, 18 Aug 2002 19:14:11 -0400
Received: from ip68-4-77-172.oc.oc.cox.net ([68.4.77.172]:3834 "HELO
	ip68-4-77-172.oc.oc.cox.net") by vger.kernel.org with SMTP
	id <S316519AbSHRXOJ>; Sun, 18 Aug 2002 19:14:09 -0400
Date: Sun, 18 Aug 2002 16:18:11 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-ID: <20020818231811.GE12684@ip68-4-77-172.oc.oc.cox.net>
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu> <1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode> <6un0rkuiyg.fsf@zork.zork.net> <1029695363.1357.5.camel@psuedomode> <6uhehsui80.fsf@zork.zork.net> <20020818215355.GB5154@ip68-4-77-172.oc.oc.cox.net> <1029709596.3331.32.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029709596.3331.32.camel@psuedomode>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 06:26:35PM -0400, Ed Sweetman wrote:
> On Sun, 2002-08-18 at 17:53, Barry K. Nathan wrote:
[snip]
> > Starting at line 722 of
> > linux-2.4.19/Documentation/filesystems/devfs/README:
> > 
> > > In general, a kernel built with CONFIG_DEVFS_FS=y but without mounting
> > > devfs onto /dev is completely safe, and requires no
> > > configuration changes.
> > 
> > I skimmed through the documentation and it appears to assume that you're
> > not deleting all the stuff in /dev before switching over to devfs.
> 
> This has nothing to do with not mounting devfs and still using devfs to
> work with devices.   If devfs is not mounted but you're still using
> devfs, you shouldn't need anything in /dev.

IMO the combination of common sense and a little Linux/Unix knowledge
would suggest that you can't use a filesystem if it's not mounted.
(Also, see my next paragraph in this message.)

> The documentation says you
> can use devfs without mounting

No, that's not what it says. It says that you can run a kernel with
devfs enabled but not mounted. This does not imply that devfs is in use
and providing the device nodes, just that it is enabled and present in
the event that it should be mounted.

> and This is what i'm saying is
> problematic and doesn't seem possible in normal usage.   It's an
> optional config so are we using devfs when we dont mount it or not?  
> and if not, then why make not mounting it an option ? 

Why make not mounting it an option? There's more than one reason. You
might want to wait until well into the boot process before mounting it
(I think this one's mentioned in the documentation but I'm not 100%
sure). You might also want to temporarily disable devfs mounting to
avoid a security hole in the event that one is found in devfs, until an
updated kernel is available (this actually happened earlier this year
with recent Mandrake Linux releases that use devfs by default).

> If it's using the old device files in /dev then how can it be using
> devfs and how can accessing physical inodes on the disk be intentional
> to devfs? 

If it's using the old /dev nodes then it's not using devfs -- but you
can switch over later after or during boot.

> > In any event, it might be a good idea to make the documentation a bit
> > more explicit about this, and I might send a patch to the mailing
> > list later today.
> 
> I'm not talking about booting without devfs enabled being the problem, i
> know booting without devfs enabled I'll have issues booting the system
> without physical /dev entries, i was referring to having devfs enabled
> and not mounting it.  Which according to the documentation should be
> perfectly functional and valid.  This is not the case though.   devfs
> should not require the old /dev entries at all since it doesn't use them
> so why would keeping them be required at all when using it (not counting
> the "if i want to not use devfs" argument).  This is what should be
> cleared up in the documentation.  

I believe you misunderstood the existing documentation. Nonetheless it
probably should be clarified, and I'm about to send a patch to the
mailing list.

-Barry K. Nathan <barryn@pobox.com>
