Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVLHVtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVLHVtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVLHVtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:49:42 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:25689 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbVLHVtl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:49:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NhWfc4Mz6SAiKzRq9E4NGin3/81mvnkog14JPn5MvIoaNxv1N2UdxFpOrG3EztQWiiMZLfbeIJ+TVuw5FIm8r1qJPqGsvgRFsnxpGV+S4QMRT3XqoSxv0DfVTGfcVscOfAsH+SoLB3f3TXWq48yrS423EulTqVnIiTVG2+x/z/Y=
Message-ID: <d120d5000512081349s1145760cha1812c7a9ec452e8@mail.gmail.com>
Date: Thu, 8 Dec 2005 16:49:37 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
Cc: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051208223705.6d375083.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <20051207170426.GB28414@kroah.com>
	 <d120d5000512081321p36c422cdg4d360263d89fa826@mail.gmail.com>
	 <20051208223705.6d375083.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, Jean Delvare <khali@linux-fr.org> wrote:
> > Another thing - bunch of input code currently creates platform devices
> > but does not create corresponding platform drivers (because they don't
> > support suspend/resume or shutdown and probing is done right there in
> > module init function).
> >
> > What is the general policy on platform devices? Should they always have
> > a corresponding driver or is it OK to leave them without one?
>
> If it wasn't OK, I'd expect platform_device_alloc and
> platform_device_register to fail when no matching driver is found.
> Since they do not, I'd guess it is considered OK not to have a matching
> driver. But that's really only a guess and not a replacement for
> Russell's (or Greg's) authoritative answer.
>
> Reciprocally, if it is finally decided that it is *not* OK to have a
> platform device without a driver, they we want to make both functions
> mentioned above fail when no match is found.
>

I don't think so - some platforms could discover platform devices
separately from drivers being loaded (think separate modules). Then,
like with PCI, they would have devices without drivers... My question
was more along the loines "do we want to waste some memory registering
a driver that does absolutely nothing except for signalling userspace
that drive is indeed has a driver attached". And letting userspace
know that device is handled is probably a good thing.

--
Dmitry
