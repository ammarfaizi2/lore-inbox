Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRJUUXw>; Sun, 21 Oct 2001 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276750AbRJUUXn>; Sun, 21 Oct 2001 16:23:43 -0400
Received: from [199.247.156.30] ([199.247.156.30]:26014 "HELO
	whitehorse.blackwire.com") by vger.kernel.org with SMTP
	id <S276745AbRJUUXb>; Sun, 21 Oct 2001 16:23:31 -0400
From: pjordan@whitehorse.blackwire.com
Date: Sun, 21 Oct 2001 11:08:56 -0700
To: linux-kernel@vger.kernel.org
Cc: Peter Jordan <pjordan@whitehorse.blackwire.com>
Subject: arp-reply, src & dest HW addr. same. Breaks netboot.
Message-ID: <20011021110856.A14724@panama>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am working with a powermac G4 (65 of 'em to be exact),
and I am learning in gory detail how they netboot or don't.

When I tell the powermac's Open Firmware to
boot from boot-device enet:0,bootme,

and I want to specify the router address using
default-gateway-ip=192.168.2.1

I am seeing that any time I point this to a linux box, whether it be i386
or powerpc or 2.4.10 or 2.2.19 that the arp-reply packet
looks corrupted to me.

Here is an example:


20:23:42.750602 0:30:65:a8:72:16 ff:ff:ff:ff:ff:ff 0806 64: arp who-has 192.168.2.1 tell 0.0.0.0
                         0001 0800 0604 0001 0030 65a8 7216 0000
                         0000 0000 0000 0000 c0a8 0201 5555 5555
                         5555 5555 5555 5555 5555 5555 5555 3254
                         ff8b
20:23:42.750641 0:30:65:a6:fa:14 0:30:65:a8:72:16 0806 42: arp reply 192.168.2.1 is-at 0:30:65:a6:fa:14 (0:30:65:a6:fa:14)
                         0001 0800 0604 0002 0030 65a6 fa14 c0a8
                         0201 0030 65a6 fa14 c0a8 0201



Note how in the reply, the linux box at 192.168.2.1 sets
the mac address for the source and destination fields to be the same.

I think for this reason the Open Firmware sends five arp who-has packets
and then gives up with the error message "can't get GATEWAY HW address."

What I don't understand is how that packet gets to the OF in the first place.
The header description of tcpdump -e output looks right, but the contents
of the arp packet is wrong.  I guess that is 802.2 or 3 or whatever ??


Anyway, when I point it to a sun box, the arp reply comes out properly
with the src and dest set as they should be, and the Open Firmware,
immediately sends out its DHCP request.


I think this is linux kernel related.

Peter
ps. please CC anyt reply to me
