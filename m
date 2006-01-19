Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWASXn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWASXn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWASXn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:43:28 -0500
Received: from ns.suse.de ([195.135.220.2]:56791 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751371AbWASXn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:43:26 -0500
From: Neil Brown <neilb@suse.de>
To: Phillip Susi <psusi@cfl.rr.com>
Date: Fri, 20 Jan 2006 10:43:13 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.9233.215291.380922@cse.unsw.edu.au>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
In-Reply-To: message from Phillip Susi on Thursday January 19
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com>
	<Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr>
	<17358.52476.290687.858954@cse.unsw.edu.au>
	<43D00FFA.1040401@cfl.rr.com>
	<17360.5011.975665.371008@cse.unsw.edu.au>
	<43D02033.4070008@cfl.rr.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 19, psusi@cfl.rr.com wrote:
> Neil Brown wrote:
> > 
> > The in-kernel autodetection in md is purely legacy support as far as I
> > am concerned.  md does volume detection in user space via 'mdadm'.
> > 
> > What other "things like" were you thinking of.
> > 
> 
> Oh, I suppose that's true.  Well, another thing is your new mods to 
> support on the fly reshaping, which dm could do from user space.  Then 
> of course, there's multipath and snapshots and other lvm things which 
> you need dm for, so why use both when one will do?  That's my take on it.

Maybe the problem here is thinking of md and dm as different things.
Try just not thinking of them at all.  
Think about it like this:
  The linux kernel support lvm
  The linux kernel support multipath
  The linux kernel support snapshots
  The linux kernel support raid0
  The linux kernel support raid1
  The linux kernel support raid5

Use the bits that you want, and not the bits that you don't.

dm and md are just two different interface styles to various bits of
this.  Neither is clearly better than the other, partly because
different people have different tastes.

Maybe what you really want is for all of these functions to be managed
under the one umbrella application.  I think that is was EVMS tried to
do. 

One big selling point that 'dm' has is 'dmraid' - a tool that allows
you to use a lot of 'fakeraid' cards.  People would like dmraid to
work with raid5 as well, and that is a good goal.
However it doesn't mean that dm needs to get it's own raid5
implementation or that md/raid5 needs to be merged with dm.
It can be achieved by giving md/raid5 the right interfaces so that
metadata can be managed from userspace (and I am nearly there).
Then 'dmraid' (or a similar tool) can use 'dm' interfaces for some
raid levels and 'md' interfaces for others.

NeilBrown
