Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbRBNMBP>; Wed, 14 Feb 2001 07:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNMBF>; Wed, 14 Feb 2001 07:01:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:48706 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129057AbRBNMAx>; Wed, 14 Feb 2001 07:00:53 -0500
Date: Wed, 14 Feb 2001 06:00:51 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au
Subject: Re: [PATCH] network driver updates
In-Reply-To: <3A8A7159.AF0E6180@colorfullife.com>
Message-ID: <Pine.LNX.3.96.1010214055806.12910U-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Manfred Spraul wrote:
> * something is wrong in the vortex initialization: I don't have such a
> card, but the driver didn't return an error message on insmod. I'm not
> sure if
> my fix is correct.

> @@ -2661,9 +2661,12 @@
>  
>         rc = pci_module_init(&vortex_driver);
>         if (rc < 0) {
> -               rc = vortex_eisa_init();
> -               if (rc > 0)
> +               int rc2;
> +               rc2 = vortex_eisa_init();
> +               if (rc2 > 0) {
>                         vortex_have_eisa = 1;
> +                       rc = 0;
> +               }
>         } else {
>                 vortex_have_pci = 1;
>         }

IMHO vortex should be trying to initialize EISA regardless of the
results of the PCI probe... Andrew?

	Jeff





