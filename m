Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbQKISLV>; Thu, 9 Nov 2000 13:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129892AbQKISLL>; Thu, 9 Nov 2000 13:11:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:14861 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129619AbQKISKx>;
	Thu, 9 Nov 2000 13:10:53 -0500
Message-ID: <3A0AE88D.FCA19A5A@mandrakesoft.com>
Date: Thu, 09 Nov 2000 13:10:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven_Snyder@3com.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Porting Linux v2.2.x Ethernet driver to v2.4.x?
In-Reply-To: <88256992.00632296.00@hqoutbound.ops.3com.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven_Snyder@3com.com wrote:
> 
> Hello.
> 
> I am about to modify a Linux v2.2.x-compatible Ethernet driver to allow it to
> work in the new v2.4.x kernel.  Are there any documents which describe the
> differences in the device driver models (particularly PCI and Ethernet) of the 2
> kernel versions?  If so, where can I find them?

Not all in one place.  Read:

Documentation/pci.txt
Documentation/DMA-mapping.txt
Documentation/IO-mapping.txt
and the attached document, regarding netdevice member locking rules.

Your best reference is other PCI ethernet drivers.  grep for
'pci_module_init' in drivers/net/*.c of the most recent 2.4.x kernel,
for a good start.

Also... before you start thinking about gunking-up your driver with all
sorts of backwards-compatibility code...  remember that most 2.4.x
drivers can easily be backported to 2.2.x with a few magic macros and
static inline functions.  I have an example of this sort of thing at
http://gtf.org/garzik/drivers/kcompat24/

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
