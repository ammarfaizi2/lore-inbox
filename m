Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUEJTkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUEJTkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUEJTkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:40:00 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:10698 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261358AbUEJTjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:39:47 -0400
Subject: Re: [PATCH] hci-usb bugfix
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405102115.26504.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org>
	 <200405101836.35239.oliver@neukum.org> <1084207959.9639.23.camel@pegasus>
	 <200405102115.26504.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1084217971.9639.55.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 21:39:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

> > > Which is wrong. It assumes that interfaces are disconnected in a certain
> > > order, which happens only by chance in your case.
> > 
> > why is it wrong? If interface 0 is disconnected first then we go into
> > the disconnect routine and cleanup. But if interface 1 is disconnected
> > first, we don't do anything and "wait" for the disconnect on first
> > interface.
> 
> Which not necessarily will ever come. It is possible that just one
> interface is disconnected.

which results in the same as if we set NULL for the private pointer when
we claim the second interface. If this really happens then we have more
problems in the driver itself, because this case won't be handled in
either way. However I don't think that this will happen, because for
Bluetooth devices interface 0 and 1 can be seen as a unit. The only
reason that this was split over two interfaces, was that you don't have
to stop the bulk transfers when you change the altsetting on the second
interface.

Regards

Marcel


