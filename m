Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWA0VHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWA0VHk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWA0VHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:07:40 -0500
Received: from mail.suse.de ([195.135.220.2]:22940 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161022AbWA0VHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:07:37 -0500
From: Neil Brown <neilb@suse.de>
To: Ariel <askernel2615@dsgml.com>
Date: Sat, 28 Jan 2006 08:07:12 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17370.35712.629959.808446@cse.unsw.edu.au>
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org, a.titov@host.bg,
       axboe@suse.de, jamie@audible.transient.net, arjan@infradead.org
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
In-Reply-To: message from Ariel on Friday January 27
References: <200601270410.06762.chase.venters@clientec.com>
	<Pine.LNX.4.62.0601271335470.8977@pureeloreel.qftzy.pbz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday January 27, askernel2615@dsgml.com wrote:
> 
> On Fri, 27 Jan 2006, Chase Venters wrote:
> 
> > 	After dealing with this leak for a while, I decided to do some dancing around
> > with git bisect. I've landed on a possible point of regression:
> >
> > commit: a9701a30470856408d08657eb1bd7ae29a146190
> > [PATCH] md: support BIO_RW_BARRIER for md/raid1
> 
> I can confirm that it only leaks with raid!
> 
> I rebooted with my raid5 root, read only, and it didn't leak. As soon as I 
> remount,rw it started leaking. Go back to ro and it stopped (although it 
> didn't clean up the old leaks). Tried my raid1 /boot and same thing - rw 
> leaks, ro doesn't. But, it only leaks on activity.
> 
> I then tried a regular lvm mount (with root ro), and no leaks!

It might be interesting, but probably not particularly helpful, to
create an ext3 filesystem on this device and mount it with the
  barrier=1
mount option.
That should send BIO_RW_BARRIER requests to the device just line md
does.

NeilBrown
