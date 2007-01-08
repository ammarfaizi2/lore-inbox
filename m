Return-Path: <linux-kernel-owner+w=401wt.eu-S1422717AbXAHTcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbXAHTcs (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbXAHTcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:32:14 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36316 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422710AbXAHTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:32:07 -0500
Date: Mon, 8 Jan 2007 20:32:58 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.20-rc3-mm1
Message-ID: <20070108203258.751aa353@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1168032284.22458.33.camel@localhost.localdomain>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
	<20070105131516.bd9d8f45.akpm@osdl.org>
	<1168032284.22458.33.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 08:24:44 +1100,
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/broken-out/driver-core-per-subsystem-multithreaded-probing.patch
> 
> Hrm. I disagree with this change. I have a few cases where drivers
> actually want to explicitely do that. I suppose they can always fire off
> a thread themselves from probe() but I don't see the reason to move it
> to the bus type...

The idea behind this is to have a probing thread for each device that
does the actual work (call probe for the matching drivers) so that
multiple devices can be probed in parallel. The decision to do this can
only be made at the bus level.

Previously, the code made it possible to have a probing thread for each
matching driver for the same device in parallel. I didn't see any
benefit in that, but maybe I'm just dense...

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
