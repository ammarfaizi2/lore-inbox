Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWFHULu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWFHULu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWFHULu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:11:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17938 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964969AbWFHULt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:11:49 -0400
Date: Thu, 8 Jun 2006 20:11:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Don Zickus <dzickus@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, shaohua.li@intel.com, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060608201135.GC4006@ucw.cz>
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com> <200606061618.15415.ak@suse.de> <20060606214553.GB11696@redhat.com> <20060606151507.613edaad.akpm@osdl.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org> <44860F7B.2040105@goop.org> <20060606234232.GD11696@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606234232.GD11696@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >All the above applies to suspend-to-disk.  I don't know if suspend-to-RAM
> > >shuts down the APs.
> > >  
> > 
> > I'm using suspend-to-mem and it looks like its unplugging/replugging all 
> > the CPUs.
> > 
> > The part of the question I don't quite understand is why this is 
> > considered per-CPU state?  Surely NMI-watchdog is a system-wide thing?  
> > Or does this also tie into other uses of the performance registers which 
> > may be set per-CPU?
> 
> The nmi watchdog is enable/disabled on a per-cpu basis.  The fact that a
> single switch turns all of them on/off is just convienance.  Adding in
> code to turn them on/off on a per-cpu basis just requires a simple user
> interface.  It has been talked about before to deal with NUMA systems. 

Does it make sense to run watchdog on cpu 1 but not on cpu 0? If user
plugs cpu 2, should it get watchdog or not? If I unplug cpu 1 and plug
it back, should it run watchdog or not?

I believe it should be per-system thing.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
