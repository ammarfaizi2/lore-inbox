Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265399AbUEUFD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUEUFD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 01:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUEUFD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 01:03:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265399AbUEUFD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 01:03:27 -0400
Date: Thu, 20 May 2004 22:03:17 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: jnardelli@infosciences.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-Id: <20040520220317.2f6f1f2a.zaitcev@redhat.com>
In-Reply-To: <20040521043032.GA31113@kroah.com>
References: <40AD3A88.2000002@infosciences.com>
	<20040521043032.GA31113@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004 21:30:32 -0700
Greg KH <greg@kroah.com> wrote:

> > -	if (!port->read_urb) {
> > +	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
> > +	{

> Your patch says that we might not have a read_urb for the given port?
> How could that be true?  The check here in open() will catch any devices
> that this might not be correct for.  So that portion of this patch is
> not needed, right?

I know nothing about Palms, but also that part contradicted a comment.

-	if (!port->read_urb) {
+	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
+	{
 		/* this is needed for some brain dead Sony devices */

So.... the patch makes the body of the if to be used when it's NOT Sony,
but the comment says that it's intended for Sony. I think it's fishy.

-- Pete
