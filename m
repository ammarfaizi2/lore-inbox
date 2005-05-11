Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVEKT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVEKT5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVEKT5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:57:50 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:64055 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262038AbVEKT5j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:57:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zpouuch3MtTKArccTONV4FkCDitPEEMiGdxv2YFuTc2Op7+ILnTMo6yoM8UEpVAsq9/aIDqydnpY8iGCojVtt1AFHcG8zsEJ4ewRGBcp3FTWF3rVQtQ6L4LrJlp9zSYBLLe2R6nQMbq+AVpR+9TJtUSA4Veykt53R8qwwxcwp2M=
Message-ID: <25381867050511125761fcfad0@mail.gmail.com>
Date: Wed, 11 May 2005 15:57:37 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org,
       Justin Thiessen <jthiessen@penguincomputing.com>
In-Reply-To: <20050511170600.GD15398@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051100583c6b1ffb@mail.gmail.com>
	 <20050511170600.GD15398@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, Greg KH <greg@kroah.com> wrote:
> On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> > -static ssize_t show_in(struct device *dev, char *buf, int nr)
> > +static ssize_t show_in(struct device *dev, char *buf, void *private)
> >  {
> > +     int nr = *((int*)private);
> 
> What's wrong with a simple:
>         int nr = (int)private;

Ouch, yes thanks for catching that, that's horribly wrong. Its a
leftover from a previous example where I was actually was passing int*
not int. I'll fix up the example and resend it. That is what comes
from not being able to test it I guess.

> Sorry, but I need a real patch in email form so I can apply it.  I can
> handle a 300K+ email :)
> 
> Or you can break it up into smaller pieces, like one per major part of
> the kernel.  That is the preferred way.

I'd like to break it up, but I think even broken up by major part of
the kernel it one piece will still be too large since the majority of
the changes take place in drivers & drivers/i2c and are very
asymmetric :-(. I'll send you the patch inline privately for now.

> We should make a __ATTR macro instead, right?

Well another __ATTR macro (e.g. ATTR_PRIVATE) would make declaring the
new DEVICE_ATTR_PRIVATE macro, etc, easier. We can't really use __ATTR
nicely though when declaring static attributes and wanting to set the
private data, hence why I think there is the need for a macro (see
http://archives.andrew.net.au/lm-sensors/msg31399.html).

The question really is, is it better to just add that new parameter to
the DEVICE_ATTR macro, or to declare a new DEVICE_ATTR_PRIVATE macro
instead. The former obviously breaks a lot of code although my scripts
can generate another large patch for that too...

Thanks,
Yani
