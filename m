Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLAGax>; Fri, 1 Dec 2000 01:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQLAGan>; Fri, 1 Dec 2000 01:30:43 -0500
Received: from mail.inconnect.com ([209.140.64.7]:31967 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129345AbQLAGae>; Fri, 1 Dec 2000 01:30:34 -0500
Date: Thu, 30 Nov 2000 23:00:07 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>, <andreas.bombe@munich.netsurf.de>
Subject: Re: test12-pre3 (FireWire issue)
In-Reply-To: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com>
Message-ID: <Pine.SOL.4.30.0011302253590.28037-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds said once upon a time (Tue, 28 Nov 2000):

>  - pre3:
>     - Andreas Bombe: ieee1394 cleanups and fixes

Linus, Andreas,

I've been using this same config since FireWire was merged, just tried out
test12-pre3 and got an unresolved symbol problem with raw1394.o

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_RAWIO=m
# CONFIG_IEEE1394_VERBOSEDEBUG is not set


make bzImage; make modules; make modules_install

modules_install bombs out with:

cd /lib/modules/2.4.0-test12; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.0-test12; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-test12/kernel/drivers/ieee1394/raw1394.o
depmod: 	free_tlabel
depmod: 	fill_iso_packet
depmod: 	hpsb_register_highlevel
depmod: 	highlevel_lock
depmod: 	hpsb_unregister_highlevel
depmod: 	hpsb_send_packet
depmod: 	highlevel_read
depmod: 	hpsb_make_lockpacket
depmod: 	alloc_hpsb_packet
depmod: 	highlevel_write
depmod: 	hpsb_dec_host_usage
depmod: 	hpsb_reset_bus
depmod: 	hpsb_generation
depmod: 	hpsb_unlisten_channel
depmod: 	hpsb_make_readbpacket
depmod: 	hpsb_listen_channel
depmod: 	free_hpsb_packet
depmod: 	hpsb_make_readqpacket
depmod: 	hpsb_make_writebpacket
depmod: 	hpsb_inc_host_usage
depmod: 	hpsb_make_writeqpacket
[root@thud linux]#


Dax Kelson
Guru Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
