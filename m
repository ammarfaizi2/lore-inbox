Return-Path: <linux-kernel-owner+w=401wt.eu-S932272AbXADFZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXADFZv (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 00:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbXADFZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 00:25:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:44644 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbXADFZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 00:25:49 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: stelian@popies.net
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 4 Jan 2007 00:24:29 -0500
User-Agent: KMail/1.9.5
Cc: "Andrew Morton" <akpm@osdl.org>, "Ismail Donmez" <ismail@pardus.org.tr>,
       "Andrea Gelmini" <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
In-Reply-To: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701040024.29793.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 07:51, stelian@popies.net wrote:
> >> > Will sony_acpi ever make it to the mainline? Its very useful for new

> > Nope, not as it is.  Useful != supportable.
> >
> > 1. It must not create any files under /proc/acpi
> >     This is creating a machine-specific API, which
> >     is exactly what we don't want  Nobody can maintain
> >     50 machine specific APIs.
> >
> >     These objects must appear generic and under sysfs
> >     as if acpi were not involved in providing them.
> >
> > 2. its source code shall not live in drivers/acpi
> >     it is not part of the ACPI implementation after all --
> >     it is a platform specific driver.
> 
>...
> 
> I don't really care much about sony_acpi (since I'm not maintaining it
> anymore, even if I still answer support requests about it), but this is
> just silly. This has been going on for more than one and a half year now.
> 
> Meanwhile (at least from what I've seen), the ACPI subsystem still doesn't
> provide this "generic" API which platform specific driver need to
> implement. drivers/acpi/{hotkey.c,video.c} are just rudimentary, and there
> is no indication that this is going forward:

You are right.  And the reason is that platform specific drivers are not part of ACPI.
They must either be vendor documented/supplied or reverse-engineered.
Vendors have not been forthcoming with documentation or code to support
Linux laptops, and our happy team here at Intel is not allowed to be in
the reverse enginering business.

So I concur that hotkey.c is a failed experiment, and I'm going to delete it.
There is more different than common on these boxes, so it makes no sense.

video.c, however, is standard, and stays for those machines that actually
do follow the public specification.

> In March 2005 you (Len) said:
> 
> > The goal is to DELETE ibm, toshiba, and asus drivers -- or at least the
> video.c handles the standard compliant machines.> duplicated functions in them.
> >
> > platform specific drivers make it harder, not easier, to support more
> > hardware -- there are a zillion vendors out there, implementing special
> > drivers for each of them is a strategy of last resort.

Still true, though it is clear we'll never be able to delete platform specific parts --
just the parts that duplicate the generic standard functions..
 
> > I'd like to keep this driver out-of-tree
> > until we prove that we can't enhance the
> > generic code to handle this hardware
> > without the addition of a new driver.
> 
> How long is this going to take ?

How about 2.6.21?
What needs to happen is
1. a maintainer for sony_acpi.c needs to step forward
    I can't do this, I'm not allowed to be in the reverse engineering business.

2. /proc/acpi/sony API needs to be deleted

3. source needs to move out of drivers/acpi, and into drivers/misc along with msi.

Luming has a sony laptop and can help with this, but
he can't be the permanent maintainer any more than I can, for the same reason.
If we can get past #1, then I recommend we apply the patch series in -mm to
the acpi-test tree and go from there.

-Len
