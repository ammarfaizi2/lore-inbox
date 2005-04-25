Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVDYWOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVDYWOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVDYWOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:14:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16301 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261241AbVDYWOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:14:17 -0400
Date: Mon, 25 Apr 2005 18:13:27 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se, greg@kroah.com,
       gud@eth.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
       cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425221326.GC15366@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Alan Stern <stern@rowland.harvard.edu>, alexn@dsv.su.se,
	greg@kroah.com, gud@eth.net, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
	cramerj@intel.com, linux-usb-devel@lists.sourceforge.net
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050425145831.48f27edb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425145831.48f27edb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 02:58:31PM -0700, Andrew Morton wrote:
 > Alan Stern <stern@rowland.harvard.edu> wrote:
 > >
 > > On Mon, 25 Apr 2005, Alexander Nyberg wrote:
 > > 
 > > > Not sure what you mean by "make kexec work nicer" but if it is because
 > > > some devices don't work after a kexec I have some objections.
 > > 
 > > That was indeed the reason, at least in my case.  The newly-rebooted
 > > kernel doesn't work too well when there are active devices, with no driver
 > > loaded, doing DMA and issuing IRQs because they were never shut down.
 > 
 > I have vague memories of this being discussed at some length last year. 
 > Nothing comprehensive came of it, except that perhaps the kdump code should
 > spin with irqs off for a couple of seconds so the DMA and IRQs stop.
 > 
 > (Ongoing DMA is not a problem actually, because the kdump kernel won't be
 > using that memory anyway)

Actually, some cpufreq drivers *should* do their speed transitions with
all PCI mastering disabled. The lack of any infrastructure to quiesce drivers
and prevent new DMA transactions from occuring whilst the transition occurs
means that currently.. we don't.  So +1 for any driver model work that
may lead to something we can use here.

This is the main reason the longhaul cpufreq driver is currently busted.
That it ever worked at all is a miracle.

		Dave

