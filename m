Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTIWXOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTIWXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:14:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:35203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263276AbTIWXOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:14:38 -0400
Date: Tue, 23 Sep 2003 16:15:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, schwab@suse.de, bcrl@kvack.org, tony.luck@intel.com,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923161529.5203ce4d.akpm@osdl.org>
In-Reply-To: <20030923122200.258215a3.davem@redhat.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
	<jehe3372th.fsf@sykes.suse.de>
	<20030923115200.1f5b44df.davem@redhat.com>
	<20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk>
	<20030923122200.258215a3.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> > That's not true; they could be avoided by using get_unaligned() and
>  > put_unaligned().  You just don't want to because they'd make sparc suck.
> 
>  Not only sparc would be effected by this.  Using {get,put}_unaligned()
>  all over the networking would incur a penalty for many platforms, not
>  just sparc.

Really?  I'd have thought that get/put_unaligned would be a simple
load/store for architectures which wish to implement it in that manner.

Other architectures could take it as an optimisation hint, to avoid taking
a trap.  They'd probably still need to implement the fixup, but if a few of
these hints could reduce the trap frequency significantly then it may be
worth doing?

I guess it depends on how many of these hints would be needed at the source
level to avoid "most" of the traps.

