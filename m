Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSGZIN3>; Fri, 26 Jul 2002 04:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSGZIN3>; Fri, 26 Jul 2002 04:13:29 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:37243 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317360AbSGZIN2>; Fri, 26 Jul 2002 04:13:28 -0400
Date: Fri, 26 Jul 2002 09:16:14 +0100
To: Ben Rafanello <benr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020726081614.GA1219@fib011235813.fsnet.co.uk>
References: <OF9ECAF9FC.61CBF3AC-ON85256BFF.00540683@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9ECAF9FC.61CBF3AC-ON85256BFF.00540683@pok.ibm.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 12:36:45PM -0500, Ben Rafanello wrote:
> After a quick look through the device mapper code, it appears that
> device mapper knows nothing of the metadata format of the
> volumes/partitions/etc. that it is mapping.

This is deliberate, device-mapper maps devices, it does _not_ read 101
metadata formats.

With EVMS you have decided you want to read/write the metadata from
within the kernel.  That's fine, I think the jury's out at the moment
regarding whether the extra overhead of maintaining more kernel code
is offset by avoiding an initrd when placing root on an LV.

What I _do_ object to is that EVMS does not factor out seperate
interfaces/subsystems that can be used by appplications other than
EVMS.  This is why I say you are just embedding an application in the
kernel (as did LVM1), rather than providing a set of generic services.

> This will work well for
> cases where the metadata for the volume/volume group does not have to be
> updated at runtime.  However, it appears that device mapper needs a
> kernel module to handle those cases where the volume metadata must
> be updated during runtime (cases such as RAID 5, Mirroring -
> particularly the fancier forms with features like smart resync
> and hot spot mirroring, bad block relocation, etc.).

If you need to change the mapping all you have to do is suspend the
device, load a new map, and then unsuspend the device.  This can be
done from within the kernel, or from userland via the ioctl interface.

There is a facility enabling targets to notify userland processes of
events.  eg, a mirror has completed its initial sync, a bad block has
occured, etc.

> Thus, to
> support AIX (or any other enterprise level volume manager since
> they all tend to have similar features) would require more than
> "just a little bit of userland code", it would require a significant
> amount of kernel code as well.

No this can all be done from userland.

- Joe
