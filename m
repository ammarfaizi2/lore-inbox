Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272328AbRHXV5G>; Fri, 24 Aug 2001 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272336AbRHXV45>; Fri, 24 Aug 2001 17:56:57 -0400
Received: from quattro.sventech.com ([205.252.248.110]:26636 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S272328AbRHXV4m>; Fri, 24 Aug 2001 17:56:42 -0400
Date: Fri, 24 Aug 2001 17:56:58 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
Message-ID: <20010824175657.F27695@sventech.com>
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com> <3B8355D9.7DE64E38@home.com> <20010822165853.A24726@devserv.devel.redhat.com> <mailman.998676421.4273.linux-kernel2news@redhat.com> <200108242138.f7OLc5D12711@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200108242138.f7OLc5D12711@devserv.devel.redhat.com>; from zaitcev@redhat.com on Fri, Aug 24, 2001 at 05:38:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001, Pete Zaitcev <zaitcev@redhat.com> wrote:
> > What was you test scenario where you didn't see a completion callback?
> 
> The root hub emulation never posts one.

Hmm, it should. I'll check that again.

> > > +	if (ret == 0) {				/* N.B. Done, must notify */
> > > +		/* uhci_call_completion(urb); */ /* ->> uhci_destroy_urb_priv */
> > > +		urb->dev = NULL;
> > > +		if (urb->complete)
> > > +			urb->complete(urb);
> > > +	}
> > >  
> > > -	usb_dec_dev_use(urb->dev);
> > > +	usb_dec_dev_use(dev);
> 
> > What's all of this for? Protecting against an urb->dev race condition?
> 
> No race, but we cannot use urb after callback.

Ahh, good point.

Thanks.

JE

