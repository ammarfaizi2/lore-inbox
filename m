Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932738AbWCVVSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWCVVSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWCVVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:18:03 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:35369 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932738AbWCVVSC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:18:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bf8a5AUzY6WguTWf4zjQo4Yti54N63lAPvMdFWwPGhFutFXMy4l2Fqb6QnVvyG/CeVMHX/a2dupGp3mn5iTBuWyqLJS/gKD49apOgZgH/UXnitvw3H+OnulNdJhRHyMcktpQD99ObSyhSi5pfUC/1fcPABysJXokB7JQRLliqmM=
Message-ID: <d120d5000603221318n7b4d664eh3cafc9260f6e12e@mail.gmail.com>
Date: Wed, 22 Mar 2006 16:18:01 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Greg KH" <greg@kroah.com>
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
Cc: "Corey Minyard" <minyard@acm.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Yani Ioannou" <yani.ioannou@gmail.com>
In-Reply-To: <20060322210820.GA12518@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322204501.GA21213@i2.minyard.local>
	 <20060322210820.GA12518@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Greg KH <greg@kroah.com> wrote:
> On Wed, Mar 22, 2006 at 02:45:01PM -0600, Corey Minyard wrote:
> > Ok, one more try.  Russell, I assume you mean to use
> > platform_device_alloc(), which seems to do what you suggested.
> > And I assume the driver_data is the way to store whatever you
> > need, instead of using the container_of() macro.
> >
> > Arjun, Russell, thanks for the info.
> >
> > Now the patch...
> >
> > Arjun van de Ven pointed out that the changeover to the driver model
> > in the IPMI driver had some bugs in it dealing with the release
> > function and cleanup.  Then Russell King pointed out that you can't
> > put release functions in the same module as the unregistering code.
>
> Yes you can, you just have to properly set up the module attribute
> owners and it will work just fine.
>

No, not really. You can only do that if _all_ sysfs attributes for the
object are handled in your driver which is rarely the case (dev,
/power/* attributes, etc).

--
Dmitry
