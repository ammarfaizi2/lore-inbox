Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUBRJnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 04:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUBRJnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 04:43:03 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:19329 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264233AbUBRJnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 04:43:01 -0500
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20040217235431.GF6242@redhat.com>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 18 Feb 2004 10:42:49 +0100
Message-ID: <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org>
In-Reply-To: <20040217235431.GF6242@redhat.com> (Dave Jones's message of
 "Tue, 17 Feb 2004 23:54:31 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == Dave Jones <davej@redhat.com> writes:

Dave> Wouldn't it make sense to have eisa_driver_register() check that the
Dave> root EISA bus actually got registered, and if not, -ENODEV
Dave> immediately ?

Most of the time, the bus driver kicks in *after* the device driver is
registered to the EISA framework (eisa is second to last in the driver
list, so if the driver is built-in, it is guaranted to init before the
root driver has a chance to discover the bus).

So, returning -ENODEV immediatly in this case prevents you from using
any built-in EISA driver. A possible solution to this problem would be
to move eisa just after the pci init (and even that would cause some
trouble, because the virtual_root driver would register before the
parisc root driver has a chance to be probed...).

So yes, this sucks, but I can't come up with a better solution...

Regards,

	M.
-- 
Places change, faces change. Life is so very strange.
