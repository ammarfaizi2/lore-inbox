Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWGLGK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWGLGK4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWGLGK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:10:56 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:61102 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932442AbWGLGKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:10:55 -0400
Date: Tue, 11 Jul 2006 23:10:53 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
In-Reply-To: <m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com> <p734pxnojyt.fsf@verdi.suse.de>
 <m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006, Eric W. Biederman wrote:
| There is a hypertransport capability that implements a rough equivalent
| of a per device ioapic.  It is quite similar to MSI but with a different
| register level interface.

It's really just the same as MSI, and is set up and handled pretty
much the same way.

| Since native hypertransport devices do not implement a pin emulation mode
| as native pci express devices do so if you want an interrupt you must support
| the native hypertransport method.

Right.

| The pathscale ipath-ht400 driver already in the kernel tree uses these
| and uses so an ugly hack to make work that broke in the last round of
| the msi cleanups.  I also know of a driver under development for a
| device that uses these as well.

Umm, it's not broken by any of the the MSI cleanups, at least
through last week's 2.6.18.

| So I want to use this so I can get irqs from native hypertransport
| devices.

This part I never really quite understood.  Why do you want a separate
interface than the existing request_irq() and pci_enable_msi()?  Yes,
there needs to be some HT-specific implementation behind it, but I
don't see a reason for a whole new interface.  Most of the rest of
the HT stuff is setup via the pci_* functions, so why not the interrupts?

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
