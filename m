Return-Path: <linux-kernel-owner+w=401wt.eu-S1751528AbXAHNU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbXAHNU5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXAHNU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:20:57 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:9763 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbXAHNU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:20:56 -0500
Date: Mon, 8 Jan 2007 14:21:48 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 32/36] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20070108142148.675a0976@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <1165332371.2756.23.camel@localhost>
References: <11650154123942-git-send-email-greg@kroah.com>
	<1165015415131-git-send-email-greg@kroah.com>
	<11650154181661-git-send-email-greg@kroah.com>
	<11650154221716-git-send-email-greg@kroah.com>
	<11650154251022-git-send-email-greg@kroah.com>
	<11650154282911-git-send-email-greg@kroah.com>
	<11650154311175-git-send-email-greg@kroah.com>
	<1165163163.19590.62.camel@localhost>
	<20061204195859.GB29637@kroah.com>
	<1165266903.12640.35.camel@localhost>
	<20061204230511.GA9382@kroah.com>
	<1165332371.2756.23.camel@localhost>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 16:26:11 +0100,
Marcel Holtmann <marcel@holtmann.org> wrote:

[sorry about the late reply, but I've been on vacation & offline]

> I was checking why device_move() fails and it seems that the check for
> is_registered is the problem here.
> 
>         if (!device_is_registered(dev)) {
>                 error = -EINVAL;
>                 goto out;
>         }
> 
> The ACL link has been attached to the Bluetooth bus, but for some reason
> it still thinks that it is unregistered. Is this check really needed. I
> think it should be possible to also move devices that are not part of a
> bus, yet. And removing that check makes it work for me.

Hm, device_is_registered() is always false for devices not belonging to
a bus. I'll remove that check.

> > > > > And shouldn't device_move(dev, NULL) re-attach it to the virtual device
> > > > > tree instead of failing?
> > > >
> > > > Yes, that would be good to have.
> > >
> > > Cornelia, please fix this, because otherwise we can't detach a device
> > > from its parent. Storing the current virtual parent looks racy to me.
> >
> > You can always restore the previous "virtual" parent from the
> > information given to you in the device itself.  That is what the code
> > does when it first registers the device.
> >
> > And yes, I too think it should be fixed.
> 
> My knowledge of the driver model is still limited. Can you fix that
> quickly. This is really needed.

I'm currently working on a patch. Sorry for the delay, I hope I can get
it out today.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
