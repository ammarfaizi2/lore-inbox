Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130780AbRCEXhq>; Mon, 5 Mar 2001 18:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130778AbRCEXhh>; Mon, 5 Mar 2001 18:37:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:20702 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130777AbRCEXhW>;
	Mon, 5 Mar 2001 18:37:22 -0500
Message-ID: <3AA4232D.B0175ADC@mandrakesoft.com>
Date: Mon, 05 Mar 2001 18:37:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: glouis@dynamicro.on.ca
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: 3c509 2.4.2-ac12 compilation fails
In-Reply-To: <20010305181408.A1075@athame.dynamicro.on.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Louis wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.2ac12/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -march=i686    -c -o 3c509.o 3c509.c
> 3c509.c: In function 'el3_probe':
> 3c509.c:330: structure has no member named 'name'

hrm, I wonder if a patch got dropped before I sent it to Alan.  It not
only compiles locally, but works on my router at home :)  

> --- drivers/net/3c509.c~        Mon Mar  5 17:41:37 2001
> +++ drivers/net/3c509.c Mon Mar  5 17:52:57 2001
> @@ -326,8 +326,8 @@
>                                 return -EBUSY;
>                         irq = idev->irq_resource[0].start;
>                         if (el3_debug > 3)
> -                               printk ("ISAPnP reports %s at i/o 0x%x, irq %d\n",
> -                                       el3_isapnp_adapters[i].name, ioaddr, irq);
> +                               printk ("ISAPnP reports %d at i/o 0x%x, irq %d\n",
> +                                       el3_isapnp_adapters[i].card_device, ioaddr, 

That should be s/name/driver_data/...

/me begins to download and merge ac12...

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
