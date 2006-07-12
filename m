Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWGLDGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWGLDGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGLDGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:06:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33230 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932355AbWGLDGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:06:50 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Dave Olson <olson@unixfolk.com>, <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<p734pxnojyt.fsf@verdi.suse.de>
Date: Tue, 11 Jul 2006 21:05:54 -0600
In-Reply-To: <p734pxnojyt.fsf@verdi.suse.de> (Andi Kleen's message of "12 Jul
	2006 00:27:54 +0200")
Message-ID: <m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> This patch implements two functions ht_create_irq and ht_destroy_irq
>> for use by drivers.  Several other functions are implemented as helpers
>> for arch specific irq_chip handlers.
>
> What do you want to use it for? Normally all HT configuration should be handled
> by the BIOS and not messed with by the kernel.

I don't believe this is a typical HT configuration as you are thinking of it.

There is a hypertransport capability that implements a rough equivalent
of a per device ioapic.  It is quite similar to MSI but with a different
register level interface.

Since native hypertransport devices do not implement a pin emulation mode
as native pci express devices do so if you want an interrupt you must support
the native hypertransport method.

The pathscale ipath-ht400 driver already in the kernel tree uses these
and uses so an ugly hack to make work that broke in the last round of
the msi cleanups.  I also know of a driver under development for a
device that uses these as well.

So I want to use this so I can get irqs from native hypertransport
devices.

Eric
