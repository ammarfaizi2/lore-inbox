Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVBGHjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVBGHjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 02:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBGHjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 02:39:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14478 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261372AbVBGHjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 02:39:41 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: kdump on non-boot cpu
References: <20050204082358.18ED.ODA@valinux.co.jp>
	<m1fz0d9mag.fsf@ebiederm.dsl.xmission.com>
	<20050204144438.18F9.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Feb 2005 00:37:36 -0700
In-Reply-To: <20050204144438.18F9.ODA@valinux.co.jp>
Message-ID: <m1ekfs3jnj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> > So I believe the fix needs to be to enable apics before we calibrate
> > the delay timer.  I'm not certain off the top of my head what that
> > patch will look like but it should not be fundamentally hard.  
> > With that code in place we also don't need to do any APIC shutdown
> > as the kernel knows enough to completely setup the apics.
> 
> I see. Thank you for your explanation.

I have done a bit more digging.

For some reason, likely historical we don't initialize the
IO_APIC in init_IRQ().  Instead we wait until smp_prepare_cpus() or
smp_init().  Both functions are called much later in the init process
than calibrate_delay().

Given the separation that has happened between apics and SMP it should
be possible to initialize the local apic and the IO_APIC of the boot
cpu much earlier in the game.  It looks like it may take some heavy
lifting though.

Eric
