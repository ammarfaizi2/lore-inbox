Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272334AbRHXViC>; Fri, 24 Aug 2001 17:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272337AbRHXVhv>; Fri, 24 Aug 2001 17:37:51 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:46663 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S272334AbRHXVhs>; Fri, 24 Aug 2001 17:37:48 -0400
Date: Fri, 24 Aug 2001 17:38:05 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200108242138.f7OLc5D12711@devserv.devel.redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
In-Reply-To: <mailman.998676421.4273.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com> <3B8355D9.7DE64E38@home.com> <20010822165853.A24726@devserv.devel.redhat.com> <mailman.998676421.4273.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What was you test scenario where you didn't see a completion callback?

The root hub emulation never posts one.

> > +	if (ret == 0) {				/* N.B. Done, must notify */
> > +		/* uhci_call_completion(urb); */ /* ->> uhci_destroy_urb_priv */
> > +		urb->dev = NULL;
> > +		if (urb->complete)
> > +			urb->complete(urb);
> > +	}
> >  
> > -	usb_dec_dev_use(urb->dev);
> > +	usb_dec_dev_use(dev);

> What's all of this for? Protecting against an urb->dev race condition?

No race, but we cannot use urb after callback.

-- Pete
