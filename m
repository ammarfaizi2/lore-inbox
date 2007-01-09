Return-Path: <linux-kernel-owner+w=401wt.eu-S932144AbXAIPJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbXAIPJk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXAIPJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:09:40 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:32990 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbXAIPJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:09:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tkqrkLbhHjuyNx45t1oI0fVksxn89/KUUPQbPi2co6L16fe3KYxKCBIImu+izQnIKhb3c+KBHqzjLugCySPzQPvC36g9c2heAak4B2vso3gIrZvPCAKx8fM7N2EsOz3Iw+U8Jg4UzRWYZ/ntZL73h6d9ua2N/PgijTRbf05ynS8=
Message-ID: <3877989d0701090709n32f57048o495274849cbbf127@mail.gmail.com>
Date: Tue, 9 Jan 2007 23:09:38 +0800
From: "Luming Yu" <luming.yu@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 1/5] video sysfs support - take 2: Add dev argument for backlight_device_register.
Cc: "Andrew Morton" <akpm@osdl.org>, "Pavel Machek" <pavel@ucw.cz>,
       len.brown@intel.com, "Matt Domsch" <Matt_Domsch@dell.com>,
       "Alessandro Guido" <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       "Richard Hughes" <hughsient@gmail.com>
In-Reply-To: <1167492935.5626.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611080033.56035.luming.yu@gmail.com>
	 <1167492935.5626.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Wed, 2006-11-08 at 00:33 +0800, Yu Luming wrote:
> > This patch set adds generic abstract layer support for acpi video driver to have
> > generic user interface to control backlight and output switch control by leveraging
> > the existing backlight sysfs class driver, and by adding a new video output sysfs
> > class driver.
> >
> > Patch 1/5:  adds dev argument for backlight_device_register to link the class device
> > to real device object. The platform specific driver should find a way to get the real
> > device object for their video device.
> >
> > signed-off-by: Luming Yu <Luming.yu@intel.com>
> > ---
> >  drivers/acpi/asus_acpi.c            |    2 +-
> >  drivers/acpi/ibm_acpi.c             |    2 +-
> >  drivers/acpi/toshiba_acpi.c         |    3 ++-
> >  drivers/video/backlight/backlight.c |    7 +++++--
> >  include/linux/backlight.h           |    2 +-
> >  5 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> > index 27597c5..1d97cdf 100644
> > --- a/drivers/video/backlight/backlight.c
> > +++ b/drivers/video/backlight/backlight.c
> > @@ -190,8 +190,10 @@ static int fb_notifier_callback(struct n
> >   * Creates and registers new backlight class_device. Returns either an
> >   * ERR_PTR() or a pointer to the newly allocated device.
> >   */
> > -struct backlight_device *backlight_device_register(const char *name, void *devdata,
> > -                                                struct backlight_properties *bp)
> > +struct backlight_device *backlight_device_register(const char *name,
> > +     struct device *dev,
> > +     void *devdata,
> > +     struct backlight_properties *bp)
> >  {
> >       int i, rc;
> >       struct backlight_device *new_bd;
>
> This patch breaks several platforms. If you're going to add parameters
> to a function like backlight_device_register, you could at least grep
> the tree and update all the users :-(.

yes, you are right.  I just noticed that there are so many users when I sent
out that patch. And all these users were disabled when I was testing patch.
I'm sorry for that.

>
> To top it off, someone noticed some of the failures and fixed them but
> nobody thought to fix the drivers in drivers/video/backlight itself and
> a mac reference seems to have escaped too.

If my memory serves me well,  there is a patch for mac in mm.
Not sure other drivers in video/backlight. But I should have sent it
to some place.
Need to check.

>
> I'll send a patch to to Andrew to clean up this mess...
>
thank you!
