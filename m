Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUEJUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUEJUic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUEJUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:38:32 -0400
Received: from mail1.kontent.de ([81.88.34.36]:13509 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261576AbUEJUib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:38:31 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hci-usb bugfix
Date: Mon, 10 May 2004 22:38:11 +0200
User-Agent: KMail/1.6.2
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Sebastian Schmidt <yath@yath.eu.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0405101211350.669-100000@ida.rowland.org> <200405102115.26504.oliver@neukum.org> <1084217971.9639.55.camel@pegasus>
In-Reply-To: <1084217971.9639.55.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405102238.11876.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> which results in the same as if we set NULL for the private pointer when
> we claim the second interface. If this really happens then we have more
> problems in the driver itself, because this case won't be handled in
> either way. However I don't think that this will happen, because for

You can trigger it in software through usbfs.

> Bluetooth devices interface 0 and 1 can be seen as a unit. The only
> reason that this was split over two interfaces, was that you don't have
> to stop the bulk transfers when you change the altsetting on the second
> interface.

Yes, but you should really stop using the second interface _before_
returning returning from disconnect() for _that_ interface. You will
operate correctly if the primary interface is disconnected first,
but you cannot depend on that. If the secondary interface is
disconnected first, you have a window where you illegally use an
interface you no longer own.

	Regards
		Oliver
