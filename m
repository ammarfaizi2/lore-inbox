Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWAaRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWAaRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWAaRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:36:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65417 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751230AbWAaRgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:36:08 -0500
Date: Tue, 31 Jan 2006 12:36:01 -0500
From: Dave Jones <davej@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: more cfq spinlock badness
Message-ID: <20060131173601.GA7204@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060131063938.GA1876@redhat.com> <20060131090944.GU4215@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131090944.GU4215@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 10:09:45AM +0100, Jens Axboe wrote:
 > On Tue, Jan 31 2006, Dave Jones wrote:
 > > Not seen this break for a while, but I just hit it again in 2.6.16rc1-git4.
 > > 
 > > 		Dave
 > > 
 > > BUG: spinlock bad magic on CPU#0, pdflush/1128
 > >  lock: ffff81003a219000, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
 > > 
 > > Call Trace: <ffffffff80206edc>{spin_bug+177} <ffffffff80207045>{_raw_spin_lock+25}
 > >        <ffffffff801fea4a>{cfq_exit_single_io_context+85} <ffffffff801ff9a6>{cfq_exit_io_context+24}
 > >        <ffffffff801f79b0>{exit_io_context+137} <ffffffff80135fbc>{do_exit+182}
 > >        <ffffffff8010ba49>{child_rip+15} <ffffffff80146087>{keventd_create_kthread+0}
 > >        <ffffffff8014629c>{kthread+0} <ffffffff8010ba3a>{child_rip+0}
 > > Kernel panic - not syncing: bad locking
 > 
 > Again, which devices have you used?

nothing special (Ie, no usb bits, just the onboard ata_piix SATA)

 > Did it happen at shutdown, or?

whislt starting up a bunch of gnome panel applets.

 > Did the ub bug get fixed

yes

 > if you are using that? The bug above has in the
 > past always been able to be explained by a driver destroying a structure
 > embedding the queue lock before the queue is dead.

as there were no ub devices plugged in at the time, I think
Pete is off the hook for this one.

		Dave

