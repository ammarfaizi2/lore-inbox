Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbWHADBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbWHADBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHADBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:01:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:13129 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030417AbWHADBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:01:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id:from;
        b=BWeQSkgxMr9cy/t8lprw/sxdm14OSLaMW+eXVlYjAfXgavj9ZXL9ieDPE8KtbmnJ6nPa8yRpjrECe1HOZc9JZjZoK+m7+ehc9Cq4uw2Z33pvagPrCxNKb4pZr/0KV3j3k8OJ0cdepgG0tGoNLEw9skl7lckSvn3gxBEBAOFqbZo=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Greg KH <greg@kroah.com>
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Date: Mon, 31 Jul 2006 23:01:09 -0400
User-Agent: KMail/1.9.1
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       andrew.j.wade@gmail.com, linux-kernel@vger.kernel.org
References: <20060727015639.9c89db57.akpm@osdl.org> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060731033757.GA13737@kroah.com>
In-Reply-To: <20060731033757.GA13737@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607312301.12140.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 23:37, Greg KH wrote:
> On Sun, Jul 30, 2006 at 10:27:06PM -0400, Andrew James Wade wrote:
> > On Sunday 30 July 2006 20:03, Greg KH wrote:
> > > Something's really broken with that version of udev then, because the
> > > 094 version I have running here works just fine with these symlinks.
> > 
> > Maybe, but some really odd things were happening in /sys with the
> > patch. I could still follow the bogus symlinks. More than that
> > 
> > /sys/class/mem/mem$ cd ../../class
> > and
> > /sys/class/mem/mem$ cd ../..
> > 
> > _both_ ended up with a $PWD of /sys/class.

Sorry for the false alarm: I didn't note the previous level of symlinks
in /sys/class/mem, and the subsystem symlinks were actually correct.
The strange behaviour of cd was the result of my shell being to clever
for my own good.

...
> 
> If you want to verify this, please apply the patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-virtual.patch
> and let me know if it solves your issue (note that the reference
> counting is not completly correct in that patch, that's why I haven't
> unleashed it on -mm yet.)

Unfortunately not. I hand-applied the one reject like so:

diff -rupN 2.6.18-rc2-mm1/drivers/base/core.c linux/drivers/base/core.c
--- 2.6.18-rc2-mm1/drivers/base/core.c	2006-07-31 22:07:24.000000000 -0400
+++ linux/drivers/base/core.c	2006-07-31 15:57:59.000000000 -0400
@@ -368,7 +368,7 @@ static int device_add_class_symlinks(str
 				  dev->bus_id);
 	if (error)
 		goto out_subsys;
-	if (dev->parent) {
+	if ((dev->parent) && (!dev->virtual)) {
 		error = sysfs_create_link(&dev->kobj, &dev->parent->kobj,
 					  "device");
 		if (error)

but udev (79-0ubuntu34) did not work with the patch applied.

thanks,
Andrew Wade
