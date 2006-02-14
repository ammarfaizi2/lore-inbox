Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWBNFXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWBNFXl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWBNFXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:23:40 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:10508 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030461AbWBNFXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:23:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=E66FTru50kRJehDhXsBjVDziayw92Pb9lpo71GTJrwrmg4abNjE6sd86X7mkeWO/E8BicUK43/HguwdVDXNPPCKSR21oWTcChLrK5iw11H/nzegAO/m/Q+8tlGL2huKCPITlkpGulpWA+yswCDG7rR1G2DeuJBwm34vTtFfXybs=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Device enumeration (was Re: CD writing in future Linux (stirring up a hornets' nest))
Date: Tue, 14 Feb 2006 00:23:15 -0500
User-Agent: KMail/1.8.3
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <43D7C1DF.1070606@gmx.de> <20060213175046.GA20952@kroah.com> <20060213195322.GB89006@dspnet.fr.eu.org>
In-Reply-To: <20060213195322.GB89006@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140023.15771.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 14:53, Olivier Galibert wrote:
> Problem: finding and talking to all the devices which have capability
> <x>, as long as the system administrator allows.
... 
> At that point, we get several answers:
...
> 4- sysfs has all the information you need, just read it
...
> Answer 4 would be very nice if it was correct.  sysfs is pretty much
> mandatory at that point, and modulo some fixable incompleteness
> provides all the capability information and model names and everything
> needed to find the useful devices.  What it does not provide is the
> mapping between a device as found in sysfs, and a device node you can
> open to talk to the device. You get the major/minor, which allows you 
> to create a temporary device node iff you're root.  Or you can scan
> all the nodes in /dev to find the one to open, which is kinda
> ridiculous and inefficient.  Or you have to go back to udev/hal to ask
> for the sysfs node/device node path mapping, and then why use sysfs in
> the first place.
     They're providing different things. Enumerating devices (as the kernel
sees them) is sysfs's business. Providing device nodes is not the kernel's
business, and should not be. (The kernel doesn't know the appropriate
permissions). And while it can be used to enumerate devices, that's not
really the function of /dev. It's providing the device nodes with the
appropriate permissions, and hopefully with names that are meaningful
to the users. So you really need both sysfs and /dev. The difficulty is
the mapping between sysfs and /dev. That mapping should not live in sysfs,
/dev is none of the kernel's business and sysfs is the kernel's playground.

     The mapping could be provided via symlinks, like so:

/dev/rdev/block/hdb/hdb1 -> /dev/hdb1
/dev/rdev/block/hdb -> /dev/hdb
/dev/rdev/block/hda/hda2 -> /dev/hda2
/dev/rdev/block/hda/hda1 -> /dev/hda1
/dev/rdev/block/hda -> /dev/hda
...

But I don't know if there is much point in doing so as udev already
provides that information.

Andrew Wade
