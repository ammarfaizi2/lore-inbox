Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130920AbRAYVT6>; Thu, 25 Jan 2001 16:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130938AbRAYVTs>; Thu, 25 Jan 2001 16:19:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28430 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130920AbRAYVTj>;
	Thu, 25 Jan 2001 16:19:39 -0500
Message-ID: <3A70985F.E5A0AB7F@mandrakesoft.com>
Date: Thu, 25 Jan 2001 16:19:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Micah Gorrell <angelcode@myrealbox.com>
CC: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        saw@saw.sw.com.sg, Alan@redhat.com
Subject: Re: [PATCH] Re: eepro100 problems in 2.4.0
In-Reply-To: <006601c08711$4bdfb600$9b2f4189@angelw2k> <3A709504.5599E0F7@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Micah Gorrell wrote:
> > Because of the problems we where having we are no longer using the machine
> > with 3 nics.  We are now using a machine with just one and it is going live
> > next week.  We do need kernel 2.4 because of the process limits in 2.2.
> > Does the 'Enable Power Management (EXPERIMENTAL)' option fix the no
> > resources problems?
> 
> Does the attached patch, against 2.4.1-pre10, help matters any?
> diff -u -r1.1.1.9.42.2 eepro100.c
> --- drivers/net/eepro100.c      2001/01/24 15:56:16     1.1.1.9.42.2
> +++ drivers/net/eepro100.c      2001/01/25 21:00:48
> @@ -560,6 +560,9 @@
>         if (speedo_debug > 0  &&  did_version++ == 0)
>                 printk(version);
> 
> +       if (pci_enable_device(pdev))
> +               return -EIO;
> +

Oops, sorry guys.  Thanks to DaveM for correcting me -- my patch has
nothing to do with the "card reports no resources" problem.  My
apologies.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
