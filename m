Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTD3GyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTD3GyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:54:09 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:37815 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262105AbTD3GyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:54:08 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Max Krasnyansky <maxk@qualcomm.com>, Greg KH <greg@kroah.com>
Subject: Re: [Bluetooth] HCI USB driver update. Support for SCO over  HCI USB.
Date: Wed, 30 Apr 2003 09:06:25 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200304292334.19447.oliver@neukum.org> <5.1.0.14.2.20030429152151.10dc8db0@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030429152151.10dc8db0@unixmail.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304300906.25490.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 30. April 2003 02:44 schrieb Max Krasnyansky:
> At 02:40 PM 4/29/2003, Greg KH wrote:
> >On Tue, Apr 29, 2003 at 11:34:19PM +0200, Oliver Neukum wrote:
> >> > +int usb_init_urb(struct urb *urb)
> >> > +{
> >> > +   if (!urb)
> >> > +           return -EINVAL;
> >> > +   memset(urb, 0, sizeof(*urb));
> >> > +   urb->count = (atomic_t)ATOMIC_INIT(1);
> >> > +   spin_lock_init(&urb->lock);
> >> > +
> >> > +   return 0;
> >> > +}
> >>
> >> Greg, please don't do it this way. Somebody will
> >> try to free this urb. If the urb is part of a structure
> >> this must not lead to a kfree. Please init it to some
> >> insanely high dummy value in this case.
>
> Uh, I didn't think about that one. This stuff was first implemented
> for 2.4 which didn't have refcount in urb and then forward ported to 2.5.

It should work. However if you have a refcount bug, the failure case will
be spectacular.

	Regards
		Oliver

