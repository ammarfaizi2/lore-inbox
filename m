Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFPQYD>; Sun, 16 Jun 2002 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSFPQYC>; Sun, 16 Jun 2002 12:24:02 -0400
Received: from web14201.mail.yahoo.com ([216.136.172.143]:14704 "HELO
	web14201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S316322AbSFPQYB>; Sun, 16 Jun 2002 12:24:01 -0400
Message-ID: <20020616162402.32079.qmail@web14201.mail.yahoo.com>
Date: Sun, 16 Jun 2002 09:24:02 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: Re: [ERROR][PATCH] smbfs compilation in 2.5.21
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       kernel-newbies@vger.kernel.org, davej@suse.de,
       Adrian Bunk <bunk@fs.tum.de>
In-Reply-To: <Pine.LNX.4.44.0206161257390.5774-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

THis is from the bk tree.  It's gcc 2.95.3.  That solution might be a bettr one
after all ;)  However, would the stringifying done here to get the function
name in there mess that up?

Erik McKee


--- Urban Widmark <urban@teststation.com> wrote:
> On Sat, 15 Jun 2002, Erik McKee wrote:
> 
> > diff -Nru a/fs/smbfs/smb_debug.h b/fs/smbfs/smb_debug.h
> > --- a/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
> > +++ b/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
> > @@ -12,8 +12,10 @@
> >   */
> >  #ifdef SMBFS_PARANOIA
> >  # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ##
> a)
> > +# define PARANOIA2(f) printk(KERN_NOTICE "%s: "f, __FUNCTION__)
> 
> Are you looking at BK, the 2.5.21 tree I'm looking at still has:
> #define PARANOIA(x...) printk(KERN_NOTICE __FUNCTION__ ": " x)
> 
> I assume you are using gcc 3.x? (which one?)
> I don't get any warnings/errors on 2.96.
> 
> 
> I think having two macros for exactly the same thing is ugly. A better
> solution might be to borrow some code from arch/ia64/kernel/unaligned.c
> 
> #define PARANOIA(f...) \
> 	do { printk(KERN_NOTICE "%s: ", __FUNCTION__); printk(f); } while(0)
> 
> (untested, and I think this will print an extra "<4>" ?)
> Unless someone has a better idea. In any case, the other printk macros in
> smb_debug.h needs treatment too and not just the PARANOIA macro.
> 
> 
> If you are cleaning things up I think that the following also sometimes
> use debug macros with a single string, but with a 'macro(a, b...)' syntax:
> 
> drivers/net/pci-skeleton.c
> drivers/char/i810_rng.c
> sound/oss/via82cxxx_audio.c
> 	DPRINTK
> 
> drivers/hotplug/pci_hotplug_{core,util}.c
> 	dbg/err/info/warn
> 
> drivers/char/machzwd.c
> 	dprnintk
> 
> drivers/ieee1394/sbp2.c
> 	SBP2_ORB_DEBUG
> 
> net/ipv4/netfilter/ipt_ULOG.c
> net/ipv4/netfilter/ip_conntrack_irc.c
> 	DEBUGP
> 
> sound/oss/vwsnd.c
> 	DBGP
> 
> fs/ntfs/debug.h
> 	ntfs_warning/ntfs_error
> 
> 
> Many of them are not enabled by default, and maybe they have already been
> taken care of.
> 
> And maybe run suggested changes by the respective maintainers first.
> Thanks.
> 
> /Urban
> 


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
