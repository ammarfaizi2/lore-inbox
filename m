Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWH2M0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWH2M0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWH2M0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:26:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:18761 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751391AbWH2M0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:26:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n305p6UGp2oZsr5PCTsf/aPgSamEE/Cc6suINwEcUDuKYOiQrOOtbw3nMWeCIZrUJSrCF4SrAlVjNboS6WQRfzhGnHpFj3q4rEO1uW4wDHTrrrxLPdJMiBy0JGHCZ3RzWHhq7r3zWhbyjD8G1+6CV/svcPWO7lwsfMVFFLMCNpo=
Message-ID: <d120d5000608290526i208885f4u9eed3269e1d3ffb1@mail.gmail.com>
Date: Tue, 29 Aug 2006 08:26:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [RPC] OLPC tablet input driver.
Cc: "Komal Shah" <komal_shah802003@yahoo.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       "Marcelo Tosatti" <mtosatti@redhat.com>
In-Reply-To: <20060829104049.GB4181@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060829073339.GA4181@aehallh.com>
	 <20060829085537.22755.qmail@web37903.mail.mud.yahoo.com>
	 <20060829104049.GB4181@aehallh.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> On Tue, Aug 29, 2006 at 01:55:37AM -0700, Komal Shah wrote:
> > --- "Zephaniah E. Hull" <warp@aehallh.com> wrote:
> > >
> > > -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> > > lifebook.o trackpoint.o
> > > +psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o
> > > lifebook.o trackpoint.o olpc.o
> >
> > Where is KConfigurable entry ?
>
> It is a component of psmouse.o, which is a few lines up.
>
> Breaking out the components of psmouse.o into separate configuration
> items might be interesting, but it is quite a bit beyond the scope of
> this patch.

Is there a chance that this device will be used on generally-available
hardware? If not then having Kconfig sub-option would be nice.

> >
> > > diff --git a/drivers/input/mouse/olpc.c b/drivers/input/mouse/olpc.c
> > > new file mode 100644
> > > index 0000000..245f29e
> > > --- /dev/null
> > > +++ b/drivers/input/mouse/olpc.c
> > > @@ -0,0 +1,327 @@
> >
> >
> > > +/*
> > > + * OLPC touchpad PS/2 mouse driver
> > > + *
> > > +int olpc_init(struct psmouse *psmouse)
> > > +{
> > > +   struct olpc_data *priv;
> > > +   struct input_dev *dev = psmouse->dev;
> > > +   struct input_dev *dev2;
> > > +
> > > +   psmouse->private = priv = kzalloc(sizeof(struct olpc_data),
> > > GFP_KERNEL);
> >
> > I think you should assign priv to private only if !NULL.
>
> Fixed.
>
> It should not actually matter, as a failure to get a !NULL value causes
> us to return false, which will fall over to other psmouse drivers which
> will either set it themselves, or not use it at all, however.
>
> It should be noted that alps.c contains the same issue.
>

I do not consider this is an issue. priv is just a shortcut or alias
for psmouse->private that saves some typing and allows the compiled to
generate better code.

-- 
Dmitry
