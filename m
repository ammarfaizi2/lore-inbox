Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUEJU6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUEJU6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEJU6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:58:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:57802 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261605AbUEJU6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:58:50 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405102238.11876.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
	 <200405102115.26504.oliver@neukum.org> <1084217971.9639.55.camel@pegasus>
	 <200405102238.11876.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1084222715.9639.105.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 22:58:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> > which results in the same as if we set NULL for the private pointer when
> > we claim the second interface. If this really happens then we have more
> > problems in the driver itself, because this case won't be handled in
> > either way. However I don't think that this will happen, because for
> 
> You can trigger it in software through usbfs.

I've never done this before. Can you show me how?

> > Bluetooth devices interface 0 and 1 can be seen as a unit. The only
> > reason that this was split over two interfaces, was that you don't have
> > to stop the bulk transfers when you change the altsetting on the second
> > interface.
> 
> Yes, but you should really stop using the second interface _before_
> returning returning from disconnect() for _that_ interface. You will
> operate correctly if the primary interface is disconnected first,
> but you cannot depend on that. If the secondary interface is
> disconnected first, you have a window where you illegally use an
> interface you no longer own.

You are absolutely right and this needs to be fixed, but this problem is
a different one than that my patch fixes. However this problem is now on
my todo list. Thanks for making me aware of.

Regards

Marcel


