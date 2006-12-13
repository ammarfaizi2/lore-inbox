Return-Path: <linux-kernel-owner+w=401wt.eu-S964854AbWLMAxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWLMAxI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWLMAxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:53:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:54253 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964854AbWLMAxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:53:07 -0500
From: Neil Brown <neilb@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 13 Dec 2006 11:53:16 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17791.20220.200213.305946@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-mm1 (md/raid1 randomly drops partitions - possible sata_uli problem)
In-Reply-To: message from Rafael J. Wysocki on Tuesday December 12
References: <20061211005807.f220b81c.akpm@osdl.org>
	<200612120043.22550.rjw@sisk.pl>
	<17789.61385.621098.265840@cse.unsw.edu.au>
	<200612122155.42213.rjw@sisk.pl>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 12, rjw@sisk.pl wrote:
> > 
> > So when md writes to write out the superblock, to gets EIO... Odd that
> > you aren't getting errors for normal writes.
> > 
> > What devices are the md/raid1 built on?
> 
> Sata drives, on sata_uli.
> 
> > > 
> > > I'll try to reproduce it tomorrow and collect some more information.
> > 
> > Thanks.  More information is definitely better than less, so send over
> > anything you can find.
> 
> Okay, seems to be readily reproducible, dmesg output from the failing kernel
> attached.

Weird.  You are getting silent write errors...

Can you write to these drives are all? e.g.

  dd if=/dev/sdb3 of=/tmp/tmp count=1
  dd if=/tmp/tmp of=/dev/sdb3 oflag=direct

(hopefully 'direct' will cause write errors to be passed up).

I really think this looks like a sata problem, not an md problem.

NeilBrown
