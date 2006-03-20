Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965822AbWCTQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965822AbWCTQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbWCTQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:33:59 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:17540 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965818AbWCTQd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:33:57 -0500
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Dave Miller <davem@redhat.com>, axboe@suse.de, bzolnier@gmail.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org, mattjreimer@gmail.com,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <441ED79B.4000009@gmail.com>
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137167419.3365.5.camel@mulgrave>
	 <20060113182035.GC25849@flint.arm.linux.org.uk>
	 <1137177324.3365.67.camel@mulgrave>
	 <20060113190613.GD25849@flint.arm.linux.org.uk>
	 <20060222082732.GA24320@htj.dyndns.org>
	 <1142871172.3283.17.camel@mulgrave.il.steeleye.com>
	 <441ED79B.4000009@gmail.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 10:33:32 -0600
Message-Id: <1142872412.3283.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 01:26 +0900, Tejun Heo wrote:
> Okay by me, although I think we also need to fix flush_dcache_page()
> such that it doesn't abruptly enable irq after itself. That's just
> broken. I'll make some kmap wrappers such that callers don't have to try
> too hard to get synchronization correct.

That would involve fixing all of the flush_dcache_mmap_lock/unlock()
wrappers to take an extra flags variable (which would be unused on null
implementations) ... it can be done, but it's a lot of work; I think,
since all the current users aren't in atomic context, that we shouldn't
bother unless anyone can see a real need to call it from atomic context.

James


