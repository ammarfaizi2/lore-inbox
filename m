Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSFQRNk>; Mon, 17 Jun 2002 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSFQRNj>; Mon, 17 Jun 2002 13:13:39 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:48305 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S316608AbSFQRNh>; Mon, 17 Jun 2002 13:13:37 -0400
Date: Mon, 17 Jun 2002 10:15:12 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Oliver Neukum <oliver@neukum.name>, Andries.Brouwer@cwi.nl,
       garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Message-id: <3D0E1920.1030507@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200206162202.g5GM2XT02750@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The idea behind using hotplug to solve the problem is that with scsimon, a 
> hotplug insertion event is generated for every SCSI device as it is added.  
> The script is provided with the information the kernel knows (host, channel, 
> pun lun, model and vendor inquiry strings---see www.torque.net/scsimon.html 

Make that http://www.torque.net/scsi/scsimon.html ... that page is linked
from the http://linux-hotplug.sourceforge.net links page, and I'm glad to
see it's been updated recently.


> for details).  The hotplug script then does the remaining processing to 
> extract the ID from the device (by ioctls, sending down SCSI commands etc.) 
> and then binds it into the /dev/volume nodes using the identifier it 
> determines.
> 
> The result is that however you move the device around (between controllers or 
> even change its id), it will always show up as its unique /dev/volume name.
> 
> The key philosophy is that the code to make the policy decision for assigning 
> a unique name isn't cluttering up the kernel, it's in user land where it can 
> be easily customised.  

I think that's a good approach for packaging that naming policy, though I'm
not quite sure where it stands in relation to "driverfs".  As with "usbfs"
it seems to me that there need to be both low-level "topological" and higher
level "logical/policy-driven" names.  And I'd prefer not to see a multiplicity
of approaches for anything except the bus-specific parts (which in this case
is "SCSI" even if the transport may be USB); I think I'm not alone in that.

Also, given what I noted earlier about stable IDs, I think SCSI_HOST should
be a stable string ID, not an integer that can easily get switched around
during system boot.

- Dave


