Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVLHVV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVLHVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVLHVV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:21:26 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:20253 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932265AbVLHVV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:21:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AHn2n5sgWf+LdhzDmGkkIsIhN6bB5/CyU386fBGJk/GOjO9z8ZX76/UB9ja3kd3z6YwHEtctp3Vm60mVdlm3JNmAsKw/WbzMRp0oExJbbFoGJigJRA76d23EPQ5RwEPePmg1FFsdm0uJH+YttDIjzWQpw2Et9pWrnhSvRNv6gY0=
Message-ID: <d120d5000512081321p36c422cdg4d360263d89fa826@mail.gmail.com>
Date: Thu, 8 Dec 2005 16:21:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051207170426.GB28414@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <20051207170426.GB28414@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Dec 07, 2005 at 01:05:39AM -0500, Dmitry Torokhov wrote:
> > On Monday 05 December 2005 15:27, Russell King wrote:
> > > On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > > > The name parameter of platform_device_register_simple should be of
> > > > type const char * instead of char *, as we simply pass it to
> > > > platform_device_alloc, where it has type const char *.
> > > >
> > > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > >
> > > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > >
> > > However, I've been wondering whether we want to keep this "simple"
> > > interface around long-term given that we now have a more flexible
> > > platform device allocation interface - I don't particularly like
> > > having superfluous interfaces for folk to get confused with.
> >
> > Now that you made platform_device_alloc install default release
> > handler there is no need to have the _simple interface. I will
> > convert input devices (main users of _simple) to the new interface
> > and then we can get rid of it.
>
> That sounds like a very good idea.
>

Another thing - bunch of input code currently creates platform devices
but does not create corresponding platform drivers (because they don't
support suspend/resume or shutdown and probing is done right there in
module init function).

What is the genral policy on platform devices? Should they always have
a corresponding driver ir it is OK to leave them without one?

--
Dmitry
