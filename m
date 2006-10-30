Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWJ3M3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWJ3M3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWJ3M3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:29:18 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:43933 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751552AbWJ3M3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:29:17 -0500
Date: Mon, 30 Oct 2006 05:29:16 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Stephen Hemminger <shemminger@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061030122915.GB10235@parisc-linux.org>
References: <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <1161989970.16839.45.camel@localhost.localdomain> <20061027160626.8ac4a910.akpm@osdl.org> <20061030104435.623fd057@gondolin.boeblingen.de.ibm.com> <1162205331.11965.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162205331.11965.0.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 10:48:51AM +0000, Alan Cox wrote:
> Ar Llu, 2006-10-30 am 10:44 +0100, ysgrifennodd Cornelia Huck:
> > Would it be sufficient just to make the busses wait until all their
> > devices are through with their setup? This is what the ccw bus on s390
> > does:
> 
> For ATA and IDE no, it might work with SCSI but your devices would
> randomly re-order which is also obnoxious. IDE relies on both link probe
> order and also has code that knows boot time processing is single
> threaded. 

There's no need to parallelise the scanning of SCSI host adapters.
Indeed, it only causes pain.  With

http://git.kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commitdiff;h=3e082a910d217b2e7b186077ebf5a1126a68c62f

and

http://git.parisc-linux.org/?p=linux-2.6.git;a=shortlog;h=scsi-async-scan

some bugfixing, and moving the scsi initialisation earlier (so it has
longer to complete while other things initialise), we should never have
to wait for scsi scans again.

And your devices only reorder as much as they ever used to with scsi.
