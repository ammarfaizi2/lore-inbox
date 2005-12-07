Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbVLGSLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbVLGSLG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbVLGSLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:11:05 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:48581 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751634AbVLGSLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:11:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mO/fwjJJBeKNLjU7HQxBwVVv/RiVsrY88HMj1ZU1JbsURv5E46vS+nm5DexiMGkeUF2beme+7fsjNLLhS6xVK/x2OJsmBf0iNLYdiD/NSsoUTsnp3O7I8NgVGnw7ODVLW0v23745ScbHeFrRsarLLXrIUgnvxqs+q61dZNfNSrk=
Message-ID: <d120d5000512071011s2e2acf14u1532e47d0f24292e@mail.gmail.com>
Date: Wed, 7 Dec 2005 13:11:02 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 12/7/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
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
> >
>
> I have started moving drivers from the "_simple" interface and I found
> that I'm missing platform_device_del that would complement
> platform_device_add. Would you object to having such a function, like
> we do for other sysfs objects? With it one can write somthing like
> this:
>
>  err_delete_device:
>        platform_device_del(i8042_platform_device);
>  err_free_device:
>        platform_device_put(i8042_platform_device);
>  err_unregister_driver:
>        platform_driver_unregister(&i8042_driver);
>

Btw, what is the policy on placing EXPORT_SYMBOL(...). Should they all
go together (at the top or teh bottom) or after each symbol
definition? Right now platform.c mixes 2 styles...

--
Dmitry
