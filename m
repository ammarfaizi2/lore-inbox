Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTKZRLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTKZRLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:11:06 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:10369
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264257AbTKZRLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:11:03 -0500
Date: Wed, 26 Nov 2003 12:09:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Kai Bankett <kbankett@aol.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_balance does not make sense with HT but single
 physical CPU
In-Reply-To: <3FC4D5B8.2010808@aol.com>
Message-ID: <Pine.LNX.4.58.0311261158230.1683@montezuma.fsmlabs.com>
References: <3FC4B5C8.6020405@aol.com> <Pine.LNX.4.58.0311261042540.1683@montezuma.fsmlabs.com>
 <3FC4D5B8.2010808@aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Kai Bankett wrote:

> But anyways if physical_balance is set to 1 that won´t prevent anything
> from running through/sleeping in the kernel_thread-loop.
> The kernel_thread(balance_irq ...) later on will be started/will run not
> matter what physical_balance says.

Yes that only stops balancing across physical packages when there are
none. But there might be a performance improvement for light (cache
footprint wise) high frequency interrupt handling which stays affined to
one logical processor.

> Do there exist any cases where smp_siblings are created without
> HyperThreading ? (As far as I remember it´s only incremented/used on
> i386 hyperthreaded architectures - but not 100% sure)

This is all i386 specific code so we don't have to care about other
architectures in here.

> -> At least the if has to look like :
>
> ...
> if (smp_num_siblings > 2 && !cpus_empty(tm))
>      physical_balance = 1;
> ...

smp_num_siblings won't be greater than 2 with current i386 processors,
it's not a total sibling count, but a per physical package count.
