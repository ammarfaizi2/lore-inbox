Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWGHQUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWGHQUJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWGHQUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:20:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40335 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964890AbWGHQUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ta9T9tuWZYkOpvftSVzGjdsfGOGIdLlNReQr4Mu0tWTIhpkZGhFlowHhFbIxb/BnuWH3bW/68tYg2ZtErQtpNDIX63RNBRrYfFPvZ7EREzeaa9k3QxILmokx0TsfsiljJyBWCXEXtp/gArk6/9sdO6rtTlz0H/jZ8SD+QQhVtMU=
Message-ID: <9e4733910607080920t51957e28sa131f86876219891@mail.gmail.com>
Date: Sat, 8 Jul 2006 12:20:06 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Opinions on removing /proc/tty?
Cc: "Mike Galbraith" <efault@gmx.de>, "Greg KH" <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152370102.27368.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com>
	 <1152344452.7922.11.camel@Homer.TheSimpsons.net>
	 <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
	 <1152370102.27368.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Sad, 2006-07-08 am 10:12 -0400, ysgrifennodd Jon Smirl:
> > > ps uses /proc/tty/drivers, so some coordination would be needed.
> >
> > Greg, I just looked at the source for ps and it has a bunch of fixed
> > code for turning major/minor into /dev/name.  Isn't that something
> > udevinfo should be doing? But looking at the help for udevinfo I don't
> > see any way to turn a major/minor into /dev/name. The altermative
> > seems to be search /dev looking for the right device node.
>
> ps has some historical baggage in this area that probably ought to go,
> but /proc/tty is used by various installers and management type apps so
> shouldn't be going anywhere in a hurry.
>
> Some of the stuff in there would be better in sysfs had sysfs been
> around at the time. Other stuff like firmware loading in the serial
> drivers would really benefit from a move to sysfs and hotplug events too

Then /proc/tty should take the same path as /proc/bus/usb. Make it
mountable and announce that it will disappear in two years.
Distributions will need to add a line to rc.sysinit like usb does, but
adding that line gives you a clue that /proc/tty is disappearing.

from rc.sysinit:
mount -n -t usbfs /proc/bus/usb /proc/bus/usb

I'll put together a patch making it mountable. Is there any specific
info that needs to be added to sysfs?

-- 
Jon Smirl
jonsmirl@gmail.com
