Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131123AbQKVWpI>; Wed, 22 Nov 2000 17:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130599AbQKVWo6>; Wed, 22 Nov 2000 17:44:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58630 "EHLO
        havoc.gtf.org") by vger.kernel.org with ESMTP id <S131461AbQKVWor>;
        Wed, 22 Nov 2000 17:44:47 -0500
Message-ID: <3A1C454E.FC4787CE@mandrakesoft.com>
Date: Wed, 22 Nov 2000 17:14:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
In-Reply-To: <200011222201.OAA29131@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
>         Just to avoid duplication of effort, I am posting this preliminary
> patch which adds PCI MODULE_DEVICE_TABLE declarations to the three PCI
> drivers in linux-2.4.0-test11/drivers/block.  In response to input from
> Christoph Hellwig, I have reduced my threshhold on using named initializers
> to three entries, although I think that may be going to far, as I would
> really like to keep the number of files that initialize the pci_device_id
> arrays this way low so that changing struct pci_device_id remains feasible.

*This* is the over-engineering attitude I was talking about.  The only
reason why you are preferring named initializers is because
pci_device_id MIGHT be changed.  And if it is changed, it makes the
changeover just tad easier.  For that, you ugly up the code and make it
more difficult to maintain.

_I_ am one of the people that works on maintaining these random PCI
drivers that no one gives a shit about.  And if applied, your patches
make my job just a little bit harder.

We -discourage- these kind of crap design decisions in the Linux kernel.

Don't over-engineer.



> --- linux-2.4.0-test11/drivers/block/DAC960.c   Thu Oct 26 23:35:47 2000
> +++ linux/drivers/block/DAC960.c        Wed Nov 22 12:42:23 2000

ok


> --- linux-2.4.0-test11/drivers/block/cciss.c    Thu Oct 26 23:35:47 2000
> +++ linux/drivers/block/cciss.c Wed Nov 22 12:29:27 2000
> @@ -50,6 +50,17 @@
>  /* Embedded module documentation macros - see modules.h */
>  MODULE_AUTHOR("Charles M. White III - Compaq Computer Corporation");
>  MODULE_DESCRIPTION("Driver for Compaq Smart Array Controller 5300");
> +static struct pci_device_id cciss_pci_tbl[] __initdata = {
> +       {
> +         vendor: PCI_VENDOR_ID_COMPAQ,
> +         device: PCI_DEVICE_ID_COMPAQ_CISS,
> +         subvendor: PCI_ANY_ID,
> +         subdevice: PCI_ANY_ID,
> +       },
> +       { }                     /* Terminating entry */
> +};
> +MODULE_DEVICE_TABLE(pci, cciss_pci_tbl);

hell no


> --- linux-2.4.0-test11/drivers/block/cpqarray.c Thu Nov 16 11:30:29 2000
> +++ linux/drivers/block/cpqarray.c      Wed Nov 22 12:34:53 2000

ok

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
