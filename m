Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVDZRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVDZRxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDZRwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:52:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5304 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261513AbVDZRvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:51:13 -0400
Date: Tue, 26 Apr 2005 13:50:42 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       alexn@dsv.su.se, greg@kroah.com, gud@eth.net,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       jgarzik@pobox.com, cramerj@intel.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426175041.GB23205@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se,
	greg@kroah.com, gud@eth.net, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
	cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com> <20050426093939.GC4175@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426093939.GC4175@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:39:39AM +0200, Pavel Machek wrote:
 
 > Well, you can do "half suspend to ram; change your frequency; half
 > resume" today, and it should work, but I do not think you'll like the
 > speed.

Indeed. With people running things like cpuspeed daemons to dynamically
scale speed, this is going to be really painful.
Of course, any operation where we have to quiesce DMA is going to mean
we're increasing latency around the scaling operation, but we don't
have to go through all the hoops that are necessary when suspending.

Thankfully some of the more recent implementations of speed/voltage
scaling don't have this requirement.

 > In a ideal world, calling device_suspend(PMSG_FREEZE) gets you exactly
 > that, and we'll do our best to make it fast enough.
 > 
 > OTOH it *needs* to switch consoles to text one (because X may be
 > running DMA, right?); I do not think you'll like that one.

That would be insane, and make cpufreq totally useless for anyone
running X, so no.   This is one of the reasons the kernel needs to
arbitrate DMA on behalf of X.  It just needs someone to do the work.

		Dave

