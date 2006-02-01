Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbWBAOTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbWBAOTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWBAOTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:19:41 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:15338 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161061AbWBAOTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:19:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E5tJtFdz7bMAZovatzTaWwdlZSyWPfVkVc5kLGE/Y2SY4+afwSfmsqLsNeq0Nd4U9gqRmV8uA2bIcUGoOCuaPeqitYoRqiJLapBOzrffLdhhgax3SpxDYwjmv0Hirrp8nYOPcUWCHuRuifCHnAZew+4OElMhQVW3wzCUmiZesig=
Message-ID: <7d40d7190602010619g20be73c5k@mail.gmail.com>
Date: Wed, 1 Feb 2006 15:19:40 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602010849100.15638@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	 <20060127050109.GA23063@kroah.com>
	 <7d40d7190601270230u850604av@mail.gmail.com>
	 <20060130214118.GB26463@kroah.com>
	 <7d40d7190602010537i3f10b722h@mail.gmail.com>
	 <Pine.LNX.4.61.0602010849100.15638@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> At the risk of the obvious....
>
>         struct meminfo meminfo;
>          ioctl(fd, UPDATE_PARAMS, &meminfo);
>
> ... and define UPDATE_PARAMS and other function codes to start
> above those normally used by kernel stuff so that `strace` doesn't
> make up stories.
>
> This is what the ioctl() interface is for. Inside the kernel
> you can use spinlocks (after you got the data from user-space)
> to make the operations atomicc.
>

Well, actually that's more or less what I had done before, and it
worked. I had a group of ioctl commands for configuring my device. The
command number was based on an unusded "magic number", as I was told
when reading Linux Device Drivers 3rd:

#define SCULL_IOCSQUANTUM _IOW(SCULL_IOC_MAGIC,  1, int)
#define SCULL_IOCSQSET        _IOW(SCULL_IOC_MAGIC,  2, int)

This actually works, but it doesnt seem to be "ellegant" code for new
drivers in 2.6. Or at least that's what it says in LDD3, since the
ioctls are system wide, unstructured, and so on.

That's why I was asking for a more ellegant and cleaner configuration
method. It seems that the new filesystem "configfs" is perfect for
that, but I would like to know if netlink sockets can also be used for
that purpose (as I'm writing a kind of network device).

Thank you anyway
Regards

Aritz
