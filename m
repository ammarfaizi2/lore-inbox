Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSFQQwU>; Mon, 17 Jun 2002 12:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSFQQwT>; Mon, 17 Jun 2002 12:52:19 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:46584 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S315423AbSFQQwS>; Mon, 17 Jun 2002 12:52:18 -0400
Date: Mon, 17 Jun 2002 09:53:53 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Oliver Neukum <oliver@neukum.name>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Message-id: <3D0E1421.2070001@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <oliver@neukum.name>
 <200206171454.g5HEsu802593@localhost.localdomain>
 <20020617090958.A19843@eng2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any SCSI device can return an ID (i.e. INQUIRY VPD page 0x80 or 0x83),
> so the logic need not be in sd. I don't know how removable media should
> be handled (not a SCSI device being added/removed from the system), for
> tape this is probably not an issue.
> ...
> 
>>Here, the usb-storage driver does know about the real device (and already has 
>>a huge exception table), so it has enough knowledge to probe for an identifier.
>  
> usb-storage could emulate VPD page 0x83 to return the GID, and that could
> then be used by the mid-layer or a user level program to extract an ID.

Except that as I recall, that's not practical for all devices; they may not
have built in IDs.  Hence there need to be topology-based IDs available.

Which is why I had pointed out usb_make_path() ... which returns a stable
controller ID for the "CBTU tuple".  It isn't going to get re-assigned by
changing the bus probe sequence or driver load order.  Even PCI has better
IDs available than those simple numbers (pci_device.slot_name).

If the driverfs names for all devices are supposed to be using stable IDs
(ones that don't change unless at least the hardware gets re-configured)
where possible, then those driverfs names will be better answers for the
"what is this device's topological ID" than those purely numeric CBTU tuples.

(And they won't address the volume/media/... ID level problems, which are
of course a separate issue.)

- Dave



