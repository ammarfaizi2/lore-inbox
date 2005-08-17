Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVHQOdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVHQOdI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVHQOdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:33:08 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:34940 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751118AbVHQOdH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:33:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s2DaDDS6DAEWh80sb8RXe+FpqcOXOZeyvJ//Zqe7vTDA8Mru7V1mljJkG+ZdAkvPg/0q0q89+cE2mRmDxC6biA/S7L0fItW3wGPh52x1LSYhUW8fLnNMC2lVXLWb0sAsXlRpYAf6yoj9fQmx0Fe0Ees35HeiTe3v+gw44AYG5hk=
Message-ID: <58cb370e05081707335679e8ae@mail.gmail.com>
Date: Wed, 17 Aug 2005 16:33:03 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Don't use a klist for drivers' set-of-devices
Cc: dtor_core@ameritech.net, Patrick Mochel <mochel@digitalimplant.org>,
       Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0508170945580.4862-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d120d5000508161534451ebd7a@mail.gmail.com>
	 <Pine.LNX.4.44L0.0508170945580.4862-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/17/05, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 16 Aug 2005, Dmitry Torokhov wrote:
> 
> > Alan,
> >
> > I am sorry I don't have time to properly review the patch at
> > themoment, just a couple of comments about serio - I would not look at
> > serio for examples of typical use as it was trying very hard to work
> > around the original driver model limitation that prevented drivers to
> > register childern on the same bus from their probe function. I think
> > now that that limitation is lifted serio implemenation can be
> > simplified.
> 
> Okay.  The same comments may apply to the other users of
> device_bind_driver.  Apart from a couple in the USB stack that I can
> handle already, those users are:
> 
>         drivers/pnp/card.c
>         drivers/input/serio/serio.c
>         drivers/input/gameport/gameport.c
> 
> Presumably the gameport code is very similar to the serio code.
> Interestingly, callers of device_release_driver include:
> 
>         drivers/pnp/card.c
>         drivers/input/serio/serio.c
>         drivers/input/gameport/gameport.c
>         drivers/ide/ide-proc.c
>         drivers/ieee1394/nodemgr.c
> 
> It's not obvious (to me) why ide-proc.c and nodemgr.c call one but not the
> other.

ide-proc.c calls device_attach() instead of device_bind_driver()

"driver" interface in ide-proc.c will be scheduled for removal
since proper bind/unbind sysfs interface is available now.

Bartlomiej
