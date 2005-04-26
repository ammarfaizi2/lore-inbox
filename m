Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDZUXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDZUXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDZUXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:23:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261534AbVDZUXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:23:42 -0400
Date: Tue, 26 Apr 2005 22:23:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se, greg@kroah.com,
       gud@eth.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426202302.GC20109@elf.ucw.cz>
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com> <20050426093939.GC4175@elf.ucw.cz> <20050426175041.GB23205@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426175041.GB23205@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Well, you can do "half suspend to ram; change your frequency; half
>  > resume" today, and it should work, but I do not think you'll like the
>  > speed.
> 
> Indeed. With people running things like cpuspeed daemons to dynamically
> scale speed, this is going to be really painful.
> Of course, any operation where we have to quiesce DMA is going to mean
> we're increasing latency around the scaling operation, but we don't
> have to go through all the hoops that are necessary when suspending.

> Thankfully some of the more recent implementations of speed/voltage
> scaling don't have this requirement.

Good, because some devices really need DMA. (Won't audio skip, and USB
break when you disable DMA? I do not see how cpufreq doing DMA disable
can be usefull.)

>  > In a ideal world, calling device_suspend(PMSG_FREEZE) gets you exactly
>  > that, and we'll do our best to make it fast enough.
>  > 
>  > OTOH it *needs* to switch consoles to text one (because X may be
>  > running DMA, right?); I do not think you'll like that one.
> 
> That would be insane, and make cpufreq totally useless for anyone
> running X, so no.   This is one of the reasons the kernel needs to
> arbitrate DMA on behalf of X.  It just needs someone to do the work.

Yes... But it also looks like a lot of work :-(.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
