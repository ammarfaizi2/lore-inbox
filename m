Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965313AbWIRCYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbWIRCYm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 22:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965314AbWIRCYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 22:24:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:59592 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965313AbWIRCYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 22:24:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rznmOY0haASjcmr2wg1JpTOiItsoVoq1w90nGarhTr2ef5ybmVtYTCUL/PZFs/9Db9/3kOE10E+UpX4S0j6p0eRs7K48/kHdTaXvPKTY8K9kxyWiOnoxYSDBqZkYuAzG8lDRTXtaf6ywBoGT2Vop+1eauOHvfUZAcCpDsl4i2jc=
Message-ID: <6b4e42d10609171924v1bb5d238l597fae8a21641a4d@mail.gmail.com>
Date: Sun, 17 Sep 2006 19:24:39 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: bluetooth drivers : kmalloc to kzalloc conversion
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       bluez-devel@lists.sourceforge.net
In-Reply-To: <200609172121.36247.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609171754q7c7335f9pfab703d6b746236b@mail.gmail.com>
	 <200609172121.36247.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/06, Dmitry Torokhov <dtor@insightbb.com> wrote:
> On Sunday 17 September 2006 20:54, Om Narasimhan wrote:
> > --- a/drivers/bluetooth/hci_usb.c
> > +++ b/drivers/bluetooth/hci_usb.c
> > @@ -147,10 +147,9 @@ static struct usb_device_id blacklist_id
> >
> > static struct _urb *_urb_alloc(int isoc, gfp_t gfp)
> > {
> > -struct _urb *_urb = kmalloc(sizeof(struct _urb) +
> > +struct _urb *_urb = kzalloc(sizeof(struct _urb) +
> > sizeof(struct usb_iso_packet_descriptor) * isoc, gfp);
> > if (_urb) {
> > -memset(_urb, 0, sizeof(*_urb));
> > usb_init_urb(&_urb->urb);
> > }
> > return _urb;
> >
>
> Note that only beginning if the aloocated memory was zeroed in original
> code; your patch may introduce slowdowns.
Would it? I thought memset() uses block move operation which doesn't
scale linearly.
And, usb_init_urb() calls memset() anyway, so the previously existed
memset() was superfluous.

Thanks for the comment.
Regards,
Om.
