Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWHQIVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWHQIVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 04:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWHQIVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 04:21:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38554 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932162AbWHQIVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 04:21:01 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155797833.11312.160.camel@localhost.localdomain>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 09:41:00 +0100
Message-Id: <1155804060.15195.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 08:57 +0200, ysgrifennodd Benjamin Herrenschmidt:
> In fact, I'm all about making the problem worse by agressively
> paralellilizing everything to get distros config mecanisms to catch up
> and stop using the interface name (or use ifrename).

I'm so glad I don't have to depend on your code then because I have to
actually deal with the real world not try to commit design suicide in
pursuit in of elegance.

There are numerous cases where bus stability happens to matter because
you cannot identify the different devices. The disk and ethernet cases
are relatively managable (disk has some distribution issues with fstab
etc on older setups). Things get nasty when you look at say sound or
video.

A classic example would be a typical security system with four identical
PCI video capture cards. There is no way other than PCI bus ordering to
order them, and if you don't order them your system isn't useful as you
do different processing on different camera streams.

>From a performance perspective the only one we really care about is
probably disks. Even there we need some kind of ordering (or ability to
order) so that we can handle unlabelled (eg new) volumes and md
components.

Right now lvm/dm/md all depend on real disk names to be useful on large
systems because the time to scan for labels is too high. On small
systems some tools work ok although not all with labels.

Disk has another awkward problem too - power control and management.

