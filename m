Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751571AbVLGR7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbVLGR7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbVLGR7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:59:11 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:24536 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751570AbVLGR7K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:59:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WKVxzUf8/O19PFVo6K/dLvn6c1ejRbeik/I/W0sutmkarrzuvXzfIClR2h0fQbxOPh5sKrRyk0X8UXjWBq1ZrG5tx1eYkk+GYPMz36CjDJzxwe0GqMYqquZG7/ZDlyvuWBIirC2o0R7FKCST6Qe+Px/epUQadKhqA7eVUvVea40=
Message-ID: <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
Date: Wed, 7 Dec 2005 12:59:09 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <200512070105.40169.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 05 December 2005 15:27, Russell King wrote:
> > On Mon, Dec 05, 2005 at 09:23:37PM +0100, Jean Delvare wrote:
> > > The name parameter of platform_device_register_simple should be of
> > > type const char * instead of char *, as we simply pass it to
> > > platform_device_alloc, where it has type const char *.
> > >
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> >
> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > However, I've been wondering whether we want to keep this "simple"
> > interface around long-term given that we now have a more flexible
> > platform device allocation interface - I don't particularly like
> > having superfluous interfaces for folk to get confused with.
>
> Now that you made platform_device_alloc install default release
> handler there is no need to have the _simple interface. I will
> convert input devices (main users of _simple) to the new interface
> and then we can get rid of it.
>

I have started moving drivers from the "_simple" interface and I found
that I'm missing platform_device_del that would complement
platform_device_add. Would you object to having such a function, like
we do for other sysfs objects? With it one can write somthing like
this:

 err_delete_device:
        platform_device_del(i8042_platform_device);
 err_free_device:
        platform_device_put(i8042_platform_device);
 err_unregister_driver:
        platform_driver_unregister(&i8042_driver);


--
Dmitry
