Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVLGSXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVLGSXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbVLGSXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:23:14 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:30078 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751242AbVLGSXM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:23:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AtIHvut9BAew2qGxyRMwl56IF16iFTKfBy+u3Aav99v8xYd1kdhi1PG/xrfcbcc9TxIYXQwNmFEzqwUQKeK4NPa8pdPSxf8XSRMIN41fKdZiDHsS9iiNm7vI3qMkrR7+8jINyOwgAWI1wOXxkAUFDyHiwp13XqhQ1o6w6IVrXxE=
Message-ID: <d120d5000512071023u151c42f4lcc40862b2debad73@mail.gmail.com>
Date: Wed, 7 Dec 2005 13:23:11 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: dtor_core@ameritech.net, Greg KH <greg@kroah.com>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Minor change to platform_device_register_simple prototype
In-Reply-To: <20051207180842.GG6793@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051205212337.74103b96.khali@linux-fr.org>
	 <20051205202707.GH15201@flint.arm.linux.org.uk>
	 <200512070105.40169.dtor_core@ameritech.net>
	 <d120d5000512070959q6a957009j654e298d6767a5da@mail.gmail.com>
	 <20051207180842.GG6793@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Wed, Dec 07, 2005 at 12:59:09PM -0500, Dmitry Torokhov > > I have started moving drivers from the "_simple" interface and I found
> > that I'm missing platform_device_del that would complement
> > platform_device_add. Would you object to having such a function, like
> > we do for other sysfs objects? With it one can write somthing like
> > this:
>
> Greg and myself discussed that, and we decided that it was adding
> unnecessary complexity to the interface.  Maybe Greg's view has
> changed?
>

How do you write error handling path without the _del function if
platform_device_add is not the last call? you can't call
platform_device_unregister() and then platform_device_put(). And I
don't like to take extra references in error path or assign the
pointer to NULL in teh middle of unwinding...

--
Dmitry
