Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRCNSL6>; Wed, 14 Mar 2001 13:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCNSLi>; Wed, 14 Mar 2001 13:11:38 -0500
Received: from [216.161.55.93] ([216.161.55.93]:33020 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131474AbRCNSLd>;
	Wed, 14 Mar 2001 13:11:33 -0500
Date: Wed, 14 Mar 2001 10:15:26 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010314101526.A15137@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3AAF8A71.1C71D517@faceprint.com> <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu> <20010314082643.A1044@kochanski.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314082643.A1044@kochanski.internal.splhi.com>; from timw@splhi.com on Wed, Mar 14, 2001 at 08:27:10AM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 08:27:10AM -0800, Tim Wright wrote:
> This would currently be massive overkill for Linux, but DYNIX/ptx avoids this
> problem entirely by keeping a device naming database. This became necessary
> when we added support for multi-path fibre-channel connected disks. Most
> device-naming conventions rely on "physical" addresses i.e. this disk at the end
> of this bus connected to this controller in this PCI slot is /dev/sdd. The
> Solaris scheme mentioned above is no different in that respect. Unfortunately,
> it doesn't work with multi-path FC-connected devices.
> 
> Very briefly, devices that are "id-able" i.e. already have a unique id are
> simply entered into the database (SCSI drives have a unique id that you can
> read at autoconf time). For elements that are not "id-able", we establish
> a derived id by recording their relation to "id-able" elements. At boot time,
> we scan (in parallel) the system and compare what we find to the database.
> That way, you get consistent naming for devices, and, at least in the case of
> the SCSI (or FC) drives, the name doesn't change, even if you pull a drive
> from one bus and plug it into a different bus entirely.

This comes up a lot with regards to USB devices too.  One of the
usb-serial drivers (the edgeport driver) did something like this by
looking at the topology of the USB bus and where a specific device was
(it was also helped by unique serial numbers) and allowed the devices to
be assigned device nodes based on the topology and a small user space
program.  I'm going to try to do this for all usb-serial devices in 2.5

I can see a scheme like this being very useful for all USB, FireWire,
scsi, etc type of devices.

And no, I don't think that having some type of device naming "database"
is overkill and will eventually make it into parts of the kernel (the
"database" living outside of the kernel of course...)

greg k-h

-- 
greg@(kroah|wirex).com
