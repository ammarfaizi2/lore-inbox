Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTLWItF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbTLWItF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:49:05 -0500
Received: from linux-bt.org ([217.160.111.169]:22707 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S265062AbTLWItD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:49:03 -0500
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource
	dealloocation problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <200312222229.17991.dtor_core@ameritech.net>
References: <200312210137.41343.dtor_core@ameritech.net>
	 <20031222093759.GB30235@kroah.com>
	 <200312222229.17991.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1072169289.2876.57.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 09:48:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > > It seems that implementation of the firmware loader is racy as it
> > > relies on kobject hotplug handler. Unfortunately that handler runs
> > > too early, before firmware class attributes controlling the loading
> > > process, are created. This causes firmware loading fail at least half
> > > of the times on my laptop.
> >
> > Um, why not have your script wait until the files are present?  That
> > will remove any race conditions you will have.
> 
> How long should the userspace wait? One second as Manuel suggested?
> Indefinitely? Or should the firmware agent have some timeout? If userspace
> uses a timeout how should it correlate with the timeout on the kernel side?

the timeout of the kernel (which can be set from userspace) is for the
whole firmware loading process. What we talk about is waiting a little
bit before the files become visible for the firmware.agent.

> I am sorry but I have to disagree with you. Kernel should not call user
> space until it has all infrastructure in place and is ready. Anything
> else is just a sloppy practice.

The firmware.agent script has 3 extra lines to check for the visibility
of the "loading" file and if it is not present it will sleep one second.
This is a actual good practice compared to adding much more code to the
kernel and have an own way of running hotplug.

Regards

Marcel


