Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTKYUS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 15:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTKYUS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 15:18:28 -0500
Received: from gw.uk.sistina.com ([62.172.100.98]:54022 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S263002AbTKYUS0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 15:18:26 -0500
Date: Tue, 25 Nov 2003 20:18:25 +0000
From: Alasdair G Kergon <agk@uk.sistina.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125201825.B27307@uk.sistina.com>
Mail-Followup-To: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com> <20031125170503.GG524@reti> <20031125172949.GE17907@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031125172949.GE17907@wiggy.net>; from wichert@wiggy.net on Tue, Nov 25, 2003 at 06:29:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 06:29:49PM +0100, Wichert Akkerman wrote:
> 'last few months' is extremely short for a migration path. Can't we
> ditch the v1 interface in 2.7 and allow people to migrate slowly?

People still using LVM2/device-mapper userspace components that 
don't support v4 really should upgrade them to fix some significant
(unrelated) issues with those old versions.

The v1 interface was broken.
(Not architecture independent.  And used __kernel_dev_t.)

The v4 interface fixed things, and is the only version anyone 
compiling a new kernel should be using.

The v4 interface has been supported officially since mid-July in
device-mapper 1.0 (with LVM 2.0).

Since then, the userspace component that communicates with device-mapper
(libdevmapper.so) has supported *both* versions simultaneously - so you
don't need to change anything in userspace when switching between
kernels running v1 and v4.  (The LVM2 tools talk to libdevmapper.so
which detects and handles the interface version transparently.)

In the current device-mapper tarball that I put on the Sistina FTP site
last Friday v1 support is no longer available by default - it has to be
specifically requested as a configuration option.

Alasdair
-- 
agk@uk.sistina.com
