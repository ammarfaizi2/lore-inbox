Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281596AbRKVUYT>; Thu, 22 Nov 2001 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKVUYK>; Thu, 22 Nov 2001 15:24:10 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:23057 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281596AbRKVUX7>;
	Thu, 22 Nov 2001 15:23:59 -0500
Date: Thu, 22 Nov 2001 12:23:56 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>,
        "Torvalds; Linus" <torvalds@transmeta.com>
Subject: Re: PATCH: Discard .exitcall.exit for alpha.
Message-ID: <20011122122356.A12874@lucon.org>
In-Reply-To: <20011122004302.A2393@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011122004302.A2393@lucon.org>; from hjl@lucon.org on Thu, Nov 22, 2001 at 12:43:02AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 12:43:02AM -0800, H . J . Lu wrote:
> Hi Linus,
> 
> The upcoming binutils will flag relocations against discarded sections
> as fatal errors. Here is a patch for the alpha linker script. 
> 
> 

Here is another patch. serial_remove_one will be discarded if serial
is not rebuilt as a module.


H.J.
----
--- linux/drivers/char/serial.c.exit	Mon Aug 13 01:15:08 2001
+++ linux/drivers/char/serial.c	Fri Nov 16 17:08:32 2001
@@ -4741,7 +4741,9 @@ MODULE_DEVICE_TABLE(pci, serial_pci_tbl)
 static struct pci_driver serial_pci_driver = {
        name:           "serial",
        probe:          serial_init_one,
+#ifdef MODULE
        remove:	       serial_remove_one,
+#endif
        id_table:       serial_pci_tbl,
 };
 
