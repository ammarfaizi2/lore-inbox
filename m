Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbQLLAkm>; Mon, 11 Dec 2000 19:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbQLLAkc>; Mon, 11 Dec 2000 19:40:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:58122 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131369AbQLLAkR>; Mon, 11 Dec 2000 19:40:17 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14901.27835.458672.526580@wire.cadcamlab.org>
Date: Mon, 11 Dec 2000 18:09:31 -0600 (CST)
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Pavel Machek <pavel@suse.cz>, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
In-Reply-To: <20001208211908.D599@jaquet.dk>
	<20001209101924.A126@bug.ucw.cz>
	<20001209163740.U6567@cadcamlab.org>
	<20001211213208.B600@jaquet.dk>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rasmus Andersen]
> How about this patch? It moves the offending struct to the __init
> function where it is used and inside an existing #ifdef CONFIG_PCI.

Hmmmm, if you're messing around with the pci device table, why not just
convert it to use new-style PCI init?  This is fairly easy to do (I did
one driver myself, and that *proves* it's easy).  The main points:

 1) convert the device table to a 'struct pci_device_id' and reference
    this struct with a call to MODULE_DEVICE_TABLE(my_struct)
 2) create a 'struct pci_driver' function table, rearranging the driver
    housekeeping functions to fit this table
 3) convert your PCI probe loop inn your init function to use
    pci_module_init(my_pci_driver_struct), which does the looping for
    you

Thanks to Adam Richter's hard work, there are lots of examples of
drivers that have already been converted to this scheme.  I don't
remember if Adam purposely skipped hp100.c or if it was an oversight.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
