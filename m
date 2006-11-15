Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965909AbWKOH2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965909AbWKOH2Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbWKOH2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:28:25 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:30969 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S965909AbWKOH2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:28:24 -0500
Date: Wed, 15 Nov 2006 08:28:56 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061115065052.GC23810@kroah.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	<20061115065052.GC23810@kroah.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 22:50:52 -0800,
Greg KH <greg@kroah.com> wrote:

> On Tue, Nov 14, 2006 at 11:32:08AM +0100, Cornelia Huck wrote:
> > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > Provide a function device_move() to move a device to a new parent device. Add
> > auxilliary functions kobject_move() and sysfs_move_dir().
> 
> At first glance, this looks sane, but for the kobject_move function, we
> are not notifying userspace that something has changed here.
> 
> Is that ok?
> 
> How will udev and HAL handle something like this without being told
> about it?  When the device eventually goes away, I think they will be
> very confused.

Hm. I don't think we want to trigger udev with some remove/add events
(especially since it is still the same device, it just has been moved
around). A change event doesn't sound quite right either. But I guess
we need to do something, at least to make HAL happy since it remembers
the path in sysfs (although I seem to remember a HAL patch that got rid
of it?)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
