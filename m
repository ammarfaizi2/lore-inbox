Return-Path: <linux-kernel-owner+w=401wt.eu-S932305AbWLLSGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWLLSGx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWLLSGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:06:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33248 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932305AbWLLSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:06:52 -0500
Date: Tue, 12 Dec 2006 13:06:46 -0500
From: Dave Jones <davej@redhat.com>
To: Kevin Puetz <puetzk@puetzk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.19-rc1][AGP] Regression -  amd_k7_agp  no longer detected
Message-ID: <20061212180646.GF2140@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Kevin Puetz <puetzk@puetzk.org>, linux-kernel@vger.kernel.org
References: <200610060150.20415.shawn.starr@rogers.com> <20061006060803.GB3381@redhat.com> <200610060259.52742.shawn.starr@rogers.com> <loom.20061211T025904-121@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20061211T025904-121@post.gmane.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:06:19AM +0000, Kevin Puetz wrote:
 > Shawn Starr <shawn.starr <at> rogers.com> writes:
 > 
 > > 
 > > On Friday 06 October 2006 2:08 am, Dave Jones wrote:
 > > > On Fri, Oct 06, 2006 at 01:50:19AM -0400, Shawn Starr wrote:
 > > >  > When loading amd_k7_agp nothing appears from kernel, no information
 > > >  > about the AGP chipset/aptreture size etc. Even putting kprints inside
 > > >  > the probe() function of the driver does not get called.
 > > >
 > > > Even as the first thing in agp_amdk7_probe() ?
 > > ... (http://thread.gmane.org/gmane.linux.kernel/453869)
 > 
 > I'm hitting this problem too, and as it's still present in the 2.6.19 final, I'm
 > assuming you never got enough information to chase it. I found the following
 > note in the debian BTS that seems relevant:
 > http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=363682
 > 
 > I can confirm that if I remove the amd76x_edac module and reload amd_k7_agp, it
 > detects the aperture. If I then reload radeon.ko and X, I get DRI (and AIGLX).
 > So hopefully that's a lead to what might have changed...

This is increasingly becoming a problem.  For cases where we have >1 driver
trying to 'own' a single PCI ID, the first to init generally wins.

Similar problems exist with intel agp vs edac, intel agp vs intel watchdog,
matroxfb vs W1, and probably more..

What's needed is a governing module that claims the device and arbitrates
for drivers 'below' it.

		Dave

-- 
http://www.codemonkey.org.uk
