Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBIUQ2>; Fri, 9 Feb 2001 15:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBIUQT>; Fri, 9 Feb 2001 15:16:19 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6411 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129031AbRBIUQE>;
	Fri, 9 Feb 2001 15:16:04 -0500
Message-ID: <3A844FFC.D0087A3E@mandrakesoft.com>
Date: Fri, 09 Feb 2001 15:15:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: Dimitromanolakis Apostolos <apdim@ovelix.softnet.tuc.gr>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] drivers/media/radio/radio-maxiradio.c - 2.4.1-ac8
In-Reply-To: <20010206224451.A24412@ensta.fr> <Pine.LNX.4.10.10102072245460.17074-300000@kythira.softlab.tuc.gr> <20010209210806.A1001@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> --- linux-2.4.1-ac8.orig/drivers/media/radio/radio-maxiradio.c  Fri Feb  9 15:55:03 2001
> +++ linux-2.4.1-ac8/drivers/media/radio/radio-maxiradio.c       Fri Feb  9 15:56:55 2001
> @@ -376,9 +376,7 @@
> 
>  int __init maxiradio_radio_init(void)
>  {
> -       int count = pci_register_driver(&maxiradio_driver);
> -
> -       if(count > 0) return 0; else return -ENODEV;
> +       return pci_module_init(&maxiradio_driver);
>  }
> 
>  void __exit maxiradio_radio_exit(void)

Patch looks ok.  Further change:  move pci_enable_device above the
request_region call.  request_region calls pci_resource_start(), which
may not return a proper value if called before pci_enable_device.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
