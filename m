Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319396AbSH3A2p>; Thu, 29 Aug 2002 20:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319510AbSH3A2p>; Thu, 29 Aug 2002 20:28:45 -0400
Received: from imo-m05.mx.aol.com ([64.12.136.8]:2260 "EHLO imo-m05.mx.aol.com")
	by vger.kernel.org with ESMTP id <S319396AbSH3A2n>;
	Thu, 29 Aug 2002 20:28:43 -0400
Message-ID: <3D6E85B1.4040708@netscape.net>
Date: Thu, 29 Aug 2002 20:36:01 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32 port PnP BIOS to the driver model RESEND #1
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net> <20020817190324.GA9320@kroah.com> <3D5ECEFE.4020404@netscape.net> <20020818214745.GA19556@kroah.com> <3D6BF1E6.9010701@netscape.net> <20020828051406.GA26263@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------090707090209080308070703"
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------090707090209080308070703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



greg@kroah.com wrote:

>
>Hi,
>
>I don't have a box with a PnP BIOS (well, I don't think I do...), so
>could you send the relevant portions of the driverfs tree, showing the
>new devices that you add for this bus?
>
Just out of curiosity what architecture are you using, is it one that 
doesn't support PnP BIOS?

Here they are:
/driverfs/device/pnp
/driverfs/device/pnp/01
/driverfs/device/pnp/02
/driverfs/device/pnp/03
etc.
/driverfs/bus/pnp
/driverfs/bus/pnp/devices
etc.
/driverfs/bus/pnp/drivers
etc.

>
>
>Also a few minor comments on the patch:
>    - pnpbios_bus_type should probably be made static, along with
>      alloc_pnpbios_root().
>
alloc_pnpbios_root is now static.  I'm going to leave bus_type as it is 
because I want it open to other files at least for now.

>
>    - You don't check for out of memory in alloc_pnpbios_root() when
>      you call kmalloc().
>
Thanks for pointing it out, fixed it.

>
>    - why are you modifying the set_limit() parameters at the top of
>      your patch?  That doesn't seem relevant to the driverfs
>      changes.
>
The pnpbios driver will not compile without these changes, it was broken 
a few versions back.  I also made some improvements to insert_device.

>
>    - in pnpbios_bus_match(), don't you have to check the value of
>      the call to match_device() to make sure you have a match?
>      That would keep pnpbios_device_probe() from being called for
>      every device like it looks your patch causes.
>
I did some serious restructuring here and in pnpbios_device_probe.  Also 
I made it a bit more like the one used by pci.  Hopefully it's all right 
now.

>
>    - the pnpbios_device_probe() call should return a negative error
>      number if the device does not match, or some error happens.
>      Returning 1 does not mean success.  You also need to save off
>      the device specific info somehow in your structure, so that
>      the pnpbios_device_remove() can remove it.  Or am I just
>      missing something here?
>
pnpbios_device_probe now returns a negative number on failure.  I'm 
creating a more flexible pnpbios specific device data structure that can 
be used instead of pci_dev in my next patch.  I should be able to clean 
some of this up once I do that.  I'll take care of the device specific 
info then.

>
>
>And is there some way you can inline the patch?  It wasn't that big...
>
Yep, I'm getting a new isp and email address soon, then I'll be able to 
use Mutt instead of Mozzila.  It turns out netscape mail doesn't really 
use imap like it appeared to, so it's incompatible.  For now this is the 
only safe way I can send patches.

>
>
>thanks,
>
>greg k-h
>
Thank you for reviewing my patch.  I appreciate it.  If there are any 
other issues please let me know.

thanks,
Adam

--------------090707090209080308070703
Content-Type: application/octet-stream;
 name="pnpbios1-rev1.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pnpbios1-rev1.patch.gz"

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
NBMLU+gbAAA=

--------------090707090209080308070703--
