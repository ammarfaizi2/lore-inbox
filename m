Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965320AbWIRCia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWIRCia (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965322AbWIRCia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:38:30 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:62216 "EHLO
	asav04.insightbb.com") by vger.kernel.org with ESMTP
	id S965320AbWIRCi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:38:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAHCiDUWBTooRLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Om Narasimhan <om.turyx@gmail.com>
Subject: Re: bluetooth drivers : kmalloc to kzalloc conversion
Date: Sun, 17 Sep 2006 22:38:27 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       bluez-devel@lists.sourceforge.net
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com> <200609172121.36247.dtor@insightbb.com> <6b4e42d10609171924v1bb5d238l597fae8a21641a4d@mail.gmail.com>
In-Reply-To: <6b4e42d10609171924v1bb5d238l597fae8a21641a4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609172238.27674.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 September 2006 22:24, Om Narasimhan wrote:
> On 9/17/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> > On Sunday 17 September 2006 20:54, Om Narasimhan wrote:
> > > --- a/drivers/bluetooth/hci_usb.c
> > > +++ b/drivers/bluetooth/hci_usb.c
> > > @@ -147,10 +147,9 @@ static struct usb_device_id blacklist_id
> > >
> > > static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
> > > {
> > > -struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> > > +struct _urb *_urb = kzalloc(sizeof(struct _urb) +
> > > sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
> > > if (_urb) {
> > > -memset(_urb, 0, sizeof(*_urb));
> > > usb_init_urb(&_urb->urb);
> > > }
> > > return _urb;
> > >
> >
> > Note that only beginning if the aloocated memory was zeroed in original
> > code; your patch may introduce slowdowns.
> Would it? I thought memset() uses block move operation which doesn't
> scale linearly.

Well, the old code was zeroing sizeof(struct _urb) bytes while yours is
zeroing sizeof(struct _urb) + X so it will definitely take more time.

> And, usb_init_urb() calls memset() anyway, so the previously existed
> memset() was superfluous.
> 

It only clears part of struct _urb. Note that "stuct _urb" and "struct urb"
are 2 different structures.

-- 
Dmitry
