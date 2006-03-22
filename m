Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932799AbWCVVj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbWCVVj0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932802AbWCVVj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:39:26 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:47950 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932799AbWCVVjZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:39:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hWxA5cGI8N6jq1nAwN/sDpjRK/gzy39NlUqoUd32ER1fDz8Y4piWary7FnORnW7CD0yZllvddCyb0iqw6CfdV9MmctlHP+BuYWx+rCn75a2LjW1vBWcFuS2yjyRVjcL058noRFdcN1RHnBRWo3B96/G4+Dw2UoK9F0TIODNLNQs=
Message-ID: <d120d5000603221339l4e244b8fu95964d843d8c06a0@mail.gmail.com>
Date: Wed, 22 Mar 2006 16:39:24 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Corey Minyard" <minyard@acm.org>
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
Cc: "Greg KH" <greg@kroah.com>, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Yani Ioannou" <yani.ioannou@gmail.com>
In-Reply-To: <4421C33C.9030408@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322204501.GA21213@i2.minyard.local>
	 <20060322210820.GA12518@kroah.com>
	 <d120d5000603221318n7b4d664eh3cafc9260f6e12e@mail.gmail.com>
	 <4421C33C.9030408@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Corey Minyard <minyard@acm.org> wrote:
> Dmitry Torokhov wrote:
>
> >On 3/22/06, Greg KH <greg@kroah.com> wrote:
> >
> >
> >>On Wed, Mar 22, 2006 at 02:45:01PM -0600, Corey Minyard wrote:
> >>
> >>
> >>>Ok, one more try.  Russell, I assume you mean to use
> >>>platform_device_alloc(), which seems to do what you suggested.
> >>>And I assume the driver_data is the way to store whatever you
> >>>need, instead of using the container_of() macro.
> >>>
> >>>Arjun, Russell, thanks for the info.
> >>>
> >>>Now the patch...
> >>>
> >>>Arjun van de Ven pointed out that the changeover to the driver model
> >>>in the IPMI driver had some bugs in it dealing with the release
> >>>function and cleanup.  Then Russell King pointed out that you can't
> >>>put release functions in the same module as the unregistering code.
> >>>
> >>>
> >>Yes you can, you just have to properly set up the module attribute
> >>owners and it will work just fine.
> >>
> >>
> >>
> >
> >No, not really. You can only do that if _all_ sysfs attributes for the
> >object are handled in your driver which is rarely the case (dev,
> >/power/* attributes, etc).
> >
> >
> I don't see an owner field in the device structure.  So you are
> saying that if the same module owns the device_driver structure,
> it is safe, but if not it is not safe.
>

Owner field is in attribute structure. So if all attributes are
implemented in your module then you are guaranteed that when you get
into module's cleanup routine there are no more references to these
attributes and therefore to your object.

--
Dmitry
