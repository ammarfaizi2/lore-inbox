Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWELRro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWELRro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWELRro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:47:44 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:11963 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932174AbWELRrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:47:43 -0400
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache
	scsi_cmd_cache
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Or Gerlitz <or.gerlitz@gmail.com>,
       linux-scsi@vger.kernel.org, rmk@arm.linux.org.uk, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
	 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
	 <20060512171632.GA29077@harddisk-recovery.com>
	 <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 12:47:18 -0500
Message-Id: <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 10:36 -0700, Linus Torvalds wrote:
> Ok, that's just _strange_. Clearly bisection picked the right commit, 
> since:

I can guess what the problem is.

The kmem_cache_release is triggered from the device model release of the
host generic device.   I suspect we've induced a tangle in here that
means scsi devices (and hence hosts) get deleted but never released.

I'll look at the release paths and see if I can work out what it is.

James


