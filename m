Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSFQTHk>; Mon, 17 Jun 2002 15:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSFQTHi>; Mon, 17 Jun 2002 15:07:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1741 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316955AbSFQTHi>;
	Mon, 17 Jun 2002 15:07:38 -0400
Date: Mon, 17 Jun 2002 12:07:06 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Oliver Neukum <oliver@neukum.name>, David Brownell <david-b@pacbell.net>,
       Andries.Brouwer@cwi.nl, garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
Message-ID: <20020617120706.A16275@eng2.beaverton.ibm.com>
References: <patmans@us.ibm.com> <200206171642.g5HGg5b03044@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200206171642.g5HGg5b03044@localhost.localdomain>; from James.Bottomley@SteelEye.com on Mon, Jun 17, 2002 at 11:42:05AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 11:42:05AM -0500, James Bottomley wrote:

> OK, how about some hardware scenarios:
> 

> Ah, but that's the scsi-3 spec which (finally) cleaned up this unique name 
> business.  However, for SCSI-2 and before, it was an unholy mess, as the two 
> examples above illustrate.  I agree that for all modern devices which are 
> SCSI-3 SPC compliant, then just asking for the WWN page probably works.  The 
> question is what to do about all the legacy hardware out there?
> 
> James

Yes, legacy or broken devices need vendor specific code to get a unique
serial number or uid, but it is not clear to me that putting the code
in user space is better or worse than kernel space. Maybe we need to
see some implementations.

For user space get-id code:

What happens at boot time? Do we now need special stripped copies of user
space get-id commands to boot from scsi (for use with initrd)? Do we just
wait until the system is booted before getting/setting the ID's?

If I build without sg or /proc, should SCSI ID's still be available?

How can I efficiently handle multi-path code without overallocating
N Scsi_Devices (where N is the number of paths to each Scsi_Device)?

For kernel implementations, we could add a special entry in the device_list
or have a new list mapping vendor+product to a get-the-id function.

Module code could be created that contains the functional code to get an
ID, and adds a pointer to the function in device_list or some other list.

User or kernel code could supply a table with a VPD page to use, and an
offset or such within the page to a serial number, and flags for other
special usage such as appending the LUN value to the serial number.

-- Patrick Mansfield
