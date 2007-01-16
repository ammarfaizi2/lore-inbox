Return-Path: <linux-kernel-owner+w=401wt.eu-S932118AbXAPKDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXAPKDn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 05:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAPKDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 05:03:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:29706 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbXAPKDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 05:03:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W92PxIi22O/4RNJIb1pvLlReJnVONCpu2IhsKBENP0qNdf+Xy95B3O/rg42llpsjGbMzdePpIu9egnB7bMmjD1Hxmc5S8lulAGksVNg1lzuEr5npFUJeT33yRv74EcZTg83zckKHWWmx6RR15/NFE1PWFZ7PCqvIkvQlNsJNjqs=
Message-ID: <5a2cf1f60701160203j6dc5911fsddcb1e1babc6ae98@mail.gmail.com>
Date: Tue, 16 Jan 2007 11:03:39 +0100
From: "Jerome Lacoste" <jerome.lacoste@gmail.com>
To: "Oliver Neukum" <oneukum@suse.de>
Subject: Re: khubd taking 100% CPU after unproperly removing USB webcam
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200701161046.29262.oneukum@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
	 <200701161046.29262.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/07, Oliver Neukum <oneukum@suse.de> wrote:
> Am Dienstag, 16. Januar 2007 10:10 schrieb Jerome Lacoste:
> > Hi,
> >
> > I unplugged my (second) webcam, forgotting to stop ekiga, and khubd is
> > now taking 100% CPU.
> >
> > - lsusb doesn't return
> > - /etc/init.d/udev restart didn't resolve the problem.
> >
> > Is that a problem one may want to investigate or should I just forget
> > about it (problem being cause by a user error)?
>
> If your are using this driver
> http://mxhaard.free.fr/download.html
>
> then it appears that it most likely hanging here:
>
>         for (n = 0; n < SPCA50X_NUMFRAMES; n++)
>                 if (waitqueue_active(&spca50x->frame[n].wq))
>                         wake_up_interruptible(&spca50x->frame[n].wq);
>         if (waitqueue_active(&spca50x->wq))
>                 wake_up_interruptible(&spca50x->wq);
>         gspca_kill_transfert(spca50x);
>         PDEBUG(3, "Disconnect Kill isoc done");
>         up(&spca50x->lock);
>         while (spca50x->user)
>                 schedule();
>
> This driver's disconnect handling is buggy. As this is an out of tree
> driver, please contact the original author.

OK thanks for your answer.

I also found out that ekiga was still running. I killed it and that
stopped the hang.

Jerome
