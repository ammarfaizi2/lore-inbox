Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031039AbWKPDVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031039AbWKPDVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031048AbWKPDVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:21:39 -0500
Received: from ns2.suse.de ([195.135.220.15]:21702 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1031039AbWKPDVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:21:38 -0500
Date: Thu, 16 Nov 2006 04:21:09 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, William Cohen <wcohen@redhat.com>,
       Eric Dumazet <dada1@cosmosbay.com>, Komuro <komurojun-mbn@nifty.com>,
       Ernst Herzberg <earny@net4u.de>, Andre Noll <maan@systemlinux.org>,
       oprofile-list@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>,
       linux-usb-devel@lists.sourceforge.net, phil.el@wanadoo.fr,
       Adrian Bunk <bunk@stusta.de>, Ingo Molnar <mingo@redhat.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Stephen Hemminger <shemminger@osdl.org>,
       Prakash Punnoor <prakash@punnoor.de>, Len Brown <len.brown@intel.com>,
       Alex Romosan <romosan@sycorax.lbl.gov>, gregkh@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [discuss] Re: 2.6.19-rc5: known regressions (v3)
Message-ID: <20061116032109.GG9579@bingen.suse.de>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <200611151945.31535.ak@suse.de> <Pine.LNX.4.64.0611151105560.3349@woody.osdl.org> <200611152023.53960.ak@suse.de> <20061115122118.14fa2177.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115122118.14fa2177.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 12:21:18PM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> 
> > 
> > > The fact is, it used to work, and the kernel changed interfaces, so now it 
> > > doesn't. 
> > 
> > No, it didn't work. oprofile may have done something, but it 
> > just silently killed the NMI watchdog in the process.
> > That was never acceptable.
> 
> But people could get profiles out.  I know, I've seen them!

Just the nmi watchdog was gone then.

> 
> > Now we do proper accounting of NMI sources and also proper allocation
> > of performance counters.
> > 
> >  
> > > Yes, "oprofile" should be fixed to not depend on that, but the kernel 
> > > shouldn't change the interfaces, and we should add back the zero entry.
> > 
> > That would break the nmi watchdog again.
> > 
> > Anyways, there is a sysctl to disable the nmi watchdog if someone
> > is desperate.
> > 
> > But I think it is clearly oprofile who did wrong here and needs
> > to be fixed.
> > 
> 
> Is it correct to say that oprofile-on-2.6.18 works, and that
> oprofile-on-2.6.19-rc5 does not?
> 
> Or is there some sort of workaround for this, or does 2.6.19-rc5 only fail

echo 0 > /proc/sys/kernel/nmi_watchdog before the oprofile module is loaded.
With builtin oprofile probably nmi_watchdog=0

> in some particular scenarios?

On x86-64 and on newer i386 machines (based on DMI year)


> 
> If it's really true that oprofile is simply busted then that's a serious
> problem and we should find some way of unbusting it.  If that means just
> adding a dummy "0" entry which always returns zero or something like that,
> then fine.

That could be probably done.

> But we can't just go and bust it.

It just did something unbelievable broken before. I would say it busted
itself.

-Andi

