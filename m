Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVCVAtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVCVAtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVCVAs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:48:28 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:54824 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262228AbVCVArg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:47:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CYvvNL5hMPs5wBv9a8RV9qUfz9M7efbd4opOZ6xMH150Kdw5iBaT++WQZSKWkQvCnPqxOFgTV1hc+zOP+XETTDfMbLfBG2JWLi2Lpsc7OnakFE/e1H0XSLPlhp4ovC3xOPlTzqLpQDO9gdNNAIs5ApU5EFlfe/Noe5wMGTcyMIg=
Message-ID: <9e4733910503211647478c73bb@mail.gmail.com>
Date: Mon, 21 Mar 2005 19:47:31 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: current linus bk, error mounting root
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20050322003807.GA10180@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <20050321154131.30616ed0.akpm@osdl.org>
	 <9e473391050321155735fc506d@mail.gmail.com>
	 <20050321161925.76c37a7f.akpm@osdl.org>
	 <20050322003807.GA10180@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 16:38:08 -0800, Greg KH <greg@kroah.com> wrote:
> On Mon, Mar 21, 2005 at 04:19:25PM -0800, Andrew Morton wrote:
> >
> > (Adds lots of cc's.  I trust that's OK).
> >
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > >
> > > No, I think Jens wants all of the distributions to fix it. I have
> > > filed a bug with Fedora on it.
> > >
> > > Something changed in the timing for loading drivers during boot. You
> > > used to be able to do:
> > > modprobe ata_piix
> > > mount /dev/sda1
> 
> You can't do that on any udev based system reliably.  That has _never_
> been true.  You might just have been getting lucky in the past.
> 

mkinitrd in Fedora needs to be modified to wait for the device. 
Maybe something like a nash command like wait /dev/sda1.

> > > Now you have to do this:
> > > modprobe ata_piix
> > > sleep 1
> > > mount /dev/sda1
> 
> That's still racy.  Rely on the /etc/dev.d/ notifier to be able to tell
> you when you can mount your device, that is what it is there for.
> 
> This is a udev issue, not a kernel issue, there's nothing we can do in
> the kernel about it (well, except for the obvious thing of giving udev
> lots of hints and making it easier for it to work properly and faster,
> which we have been doing over the past months.)
> 
> > > I suspect the problem is that udev doesn't get a chance to run anymore.
> > > The sleep 1 allows it to run and it creates /dev/sda1.
> > > Build ata_piix in and the problem goes away too.
> > >
> > > Jens is right that this is a user space issue, but how many people are
> > > going to find this out the hard way when their root drives stop
> > > mounting. Since no one is complaining I have to assume that most
> > > kernel developers have their root device drivers built into the
> > > kernel. I was loading mine as a module since for a long time Redhat
> > > was not shipping kernels with SATA built in.
> >
> > I don't agree that this is a userspace issue.  It's just not sane for a
> > driver to be in an unusable state for an arbitrary length of time after
> > modprobe returns.
> 
> It is a userspace issue.  If you have a static /dev there are no
> problems, right?  If you use udev, you need to wait for the device node
> to show up, it will not be there right after modprobe returns.
> 
> thanks,
> 
> greg k-h
> 


-- 
Jon Smirl
jonsmirl@gmail.com
