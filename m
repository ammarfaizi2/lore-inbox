Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWJKQ3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWJKQ3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWJKQ2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:28:45 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:44853 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161111AbWJKQ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kfavTFKDwgXC5i6BOSwC5FeP60q13bYctClXbNmW16CcRAbGTaphWMuyjLZxHYeV/IlK4oZEy4USw2G9nbUto+8QM8WXDcvE4qR0dGmVl3dldPundyNvtFAIaR+By7axNDxo2YM7qc6wUbPw65ZiDW3ngVT3+VhmMtzz6ifmi/0=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Thu, 12 Oct 2006 00:28:29 +0800
User-Agent: KMail/1.8.2
Cc: Richard Hughes <hughsient@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <1160491646.6174.36.camel@hughsie-laptop> <20061010161012.GA18847@lists.us.dell.com>
In-Reply-To: <20061010161012.GA18847@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610120028.29617.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 00:10, Matt Domsch wrote:
> On Tue, Oct 10, 2006 at 03:47:26PM +0100, Richard Hughes wrote:
> > On Tue, 2006-10-10 at 22:32 +0800, Yu Luming wrote:
> > > >From my understanding, a cute userspace App shouldn't have this kind
> > >
> > > of logic:
> > >         if (is  DELL )
> > >                 invoke libsmbios
> > >         if (is  foo)
> > >                 invoke libfoo,
> > >         if (is bar)
> > >                 invoke libbar,
> > >         ....
> > >         else
> > >                 operate on /sys/class/backlight/ ,.,..
> >
> > This is what HAL has at the moment[1]. And it's hell to maintain, but
> > works for a lot of users.
>
> This is slightly different.  This shows that there are a number of
> slightly different kernel implementations:
>
> /proc/acpi/toshiba/lcd
> /proc/acpi/asus/brn
> /proc/acpi/pcc/brightness
> /proc/acpi/ibm/brightness
> /proc/acpi/sony/brightness
> /proc/omnibook/lcd
>
> which is indeed nasty. I'd agree all in-kernel solutions should use
> the same kernel<->user interface.  I'd also expect the kernel to have

Yes, we all seem to agree we need to throw away /proc/acpi just after we 
have solid sysfs interface for acpi.

> a generic ACPI driver that exports the _BCL and _BCM method
> implementations via that same interface, so that systems providing
> that will "just work".  drivers/acpi/video.c currently exports this
> via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
> /sys/class/backlight. :-(

Yes, I'm working on acpi video driver transition , and have posted a patch to
user backlight for acpi video driver.
http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2

>
> There's also at least one more userspace option for the sonypi using
> spiictrl.  This is where I expected libsmbios to plug in also, as a
> fallback to the ACPI _BCL/_BCM methods above.

I think spiictrl would be thrown away just after we have solid sysfs support.

Thanks,
Luming
