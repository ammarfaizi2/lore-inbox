Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCKVSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCKVSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCKVSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:18:18 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:15352 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261253AbVCKVSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:18:06 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Albert Cahalan <albert@users.sf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       peterc@gelato.unsw.edu.au
In-Reply-To: <1110568542.15927.76.camel@localhost.localdomain>
References: <1110518308.1949.67.camel@cube>
	 <1110568542.15927.76.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 16:04:28 -0500
Message-Id: <1110575069.1949.72.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-11 at 19:15 +0000, Alan Cox wrote:
> > You forgot the PCI domain (a.k.a. hose, phb...) number.
> > Also, you might encode bus,slot,function according to
> > the PCI spec. So that gives:
> > 
> > long usr_pci_open(unsigned pcidomain, unsigned devspec, __u64 dmamask);
> 
> Still insufficient because the device might be hotplugged on you. You
> need a file handle that has the expected revocation effects on unplug
> and refcounts

I was under the impression that a file handle would be returned.

I'm not so sure that is a sane way to handle hot-plug though.
First of all, in general, it's going to be like this:

Fan, meet shit.
Shit, meet fan.

Those who care might best be served by SIGBUS with si_code
and si_info set appropriately. Perhaps a revoke() syscall
that handled mmap() would work the same way.



