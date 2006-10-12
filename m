Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWJLPqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWJLPqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWJLPqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:46:34 -0400
Received: from mx2.netapp.com ([216.240.18.37]:61998 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932648AbWJLPqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:46:33 -0400
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="417397017:sNHT22545784"
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1160648107.23731.6.camel@localhost.localdomain>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
	 <1160616905.6596.14.camel@lade.trondhjem.org>
	 <20061012015306.GB27693@lists.us.dell.com>
	 <1160648107.23731.6.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Thu, 12 Oct 2006 08:15:26 -0700
Message-Id: <1160666126.6004.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 12 Oct 2006 15:15:27.0426 (UTC) FILETIME=[3F865220:01C6EE11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 11:15 +0100, Alan Cox wrote:
> Ar Mer, 2006-10-11 am 20:53 -0500, ysgrifennodd Matt Domsch:
> > > > Then their hardware is faulty and should be specifically blacklisted not
> > > > make everyone have to deal with silly unmaintainable hacks.
> > > 
> > > They are not hacks. The actual range of ports used by the RPC client is
> > > set using /proc/sys/sunrpc/(min|max)_resvport. People that don't have
> > > broken motherboards can override the default range, which is all that we
> > > are changing here.
> 
> No.. you have it backwards. The tiny tiny number of people with broken
> boards can either set it themselves, use DMI, or ram the offending board
> somewhere dark belonging to whoever sold it to them

:-)

The main problem with that approach is that the offending boardmakers
tend to hide these details deep in technical docs that are not bundled
with the motherboard, and which consequently nobody actually reads.
Instead they see that NFS doesn't work, and conclude to waste NFS
community's time in debugging it.

We're still leaving a fairly large range of ports for the NFS client to
use: there should be 373 that are rife for the taking.

> > > To be fair, the motherboard manufacturers have actually registered these
> > > ports with IANA:
> 
> This is irrelevant, they are stealing bits out of the incoming network
> stream. That's not just rude its dangerous - they should have their own
> MAC and IP stack for this. Port assignments are courtesy numbering to
> avoid collisions on your own stack. They have no more right to steal
> packets from that port than CERN does to claim all port 80 traffic on
> the internet.
> 
> Why do I say dangerous - because they steal the data *before* your Linux
> firewalling and feed it to an unauditable binary firmware which has
> controlling access to large parts of the system without the OS even
> seeing it.
> 
> Not a good idea IMHO on any box facing even a slightly insecure port.

No arguments with this.
