Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVCXOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVCXOoO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVCXOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:44:14 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:8520 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262504AbVCXOoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:44:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VlL0dx2VKHNTWreT3L8MXYwPCfUxtNyjx2D0zyH1tPdmWq1MuFmgBVpTBTHbp0X0doFBO7v73Jbmcz1x9RF/9NU0uO6L9aA6Ba0q1HQXzKQKcNWoJSBP9/8/1Z7pwoyC43UYi4X91njDZj2w4MjN2IVjXwh2GndZSPpM85JuWSk=
Message-ID: <d120d500050324064410985536@mail.gmail.com>
Date: Thu, 24 Mar 2005 09:44:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Cc: Frank Sorenson <frank@tuxrocks.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20050324080048.GA13414@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <200502240110.16521.dtor_core@ameritech.net>
	 <200503170140.49328.dtor_core@ameritech.net>
	 <20050324072550.GL10604@kroah.com>
	 <200503240239.32639.dtor_core@ameritech.net>
	 <20050324080048.GA13414@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 00:00:48 -0800, Greg KH <greg@kroah.com> wrote:
> On Thu, Mar 24, 2005 at 02:39:32AM -0500, Dmitry Torokhov wrote:
> > On Thursday 24 March 2005 02:25, Greg KH wrote:
> > > On Thu, Mar 17, 2005 at 01:40:48AM -0500, Dmitry Torokhov wrote:
> > > > On Wednesday 16 March 2005 16:38, Frank Sorenson wrote:
> > > > > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > > > > and store functions also accept the name of the attribute as a parameter.
> > > > > This lets the functions know what attribute is being accessed, and allows
> > > > > us to create attributes that share show and store functions, so things
> > > > > don't need to be defined at compile time (I feel slightly evil!).
> > > >
> > > > Hrm, can we be a little more explicit and not poke in the sysfs guts right
> > > > in the driver? What do you think about the patch below athat implements
> > > > "attribute arrays"? And I am attaching cumulative i8k patch using these
> > > > arrays so they can be tested.
> > > >
> > > > I am CC-ing Greg to see what he thinks about it.
> > >
> > > Hm, I think it's proably of limited use, right?  What other code would
> > > want this (the i2c sensor code doesn't, as it's naming scheme is
> > > different.)
> > >
> >
> > Looking at their attributes they would benefit from arrays of goups of
> > attributes... They have:
> > ...
> Yeah, but then you break the userspace api that tools are already
> expecting to see :(
>

Yes, although i2c did change inreface somewhat recently - I remember I
had to upgrade sensor package couple of month ago to get sensors
output, so we have some precedent.

Also, even if i2c decides not to use it it does not mean that at some
point nobody else would use attribute arrays and arrays of groups. I
am willing to bet if these would be available they could be used:

/drivers/macintosh/therm_pm72.c
/drivers/usb/misc/cytherm.c

Attributes with a private pointer passed in would be very useful too.

-- 
Dmitry
