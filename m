Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272558AbRIFUfh>; Thu, 6 Sep 2001 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272565AbRIFUf1>; Thu, 6 Sep 2001 16:35:27 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:781 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272558AbRIFUfT>; Thu, 6 Sep 2001 16:35:19 -0400
Date: Thu, 6 Sep 2001 22:22:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, Andi Kleen <ak@muc.de>,
        kuznet@ms2.inr.ac.ru
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906222228.I13547@emma1.emma.line.org>
Mail-Followup-To: jamal <hadi@cyberus.ca>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	Andi Kleen <ak@muc.de>, kuznet@ms2.inr.ac.ru
In-Reply-To: <Pine.GSO.4.30.0109051803500.11700-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0109051803500.11700-100000@shell.cyberus.ca>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Sep 2001, jamal wrote:

> --- devinet.c   2001/09/04 19:18:51     1.1
> +++ devinet.c   2001/09/04 19:31:13
> @@ -530,7 +530,7 @@
> 
>         if ((in_dev=__in_dev_get(dev)) != NULL) {
>                 for (ifap=&in_dev->ifa_list; (ifa=*ifap) != NULL;
> ifap=&ifa->ifa_next)
> -                       if (strcmp(ifr.ifr_name, ifa->ifa_label) == 0)
> +                       if ((strcmp(ifr.ifr_name, ifa->ifa_label) == 0) ||
> (sin->sin_addr.s_addr == ifa->ifa_address))
>                                 break;
>         }

Thanks for trying to help, however, that's not going to work this way, sorry.

1. "sin" is cleared a few lines above, so you end up comparing 0.0.0.0
   against "ifa->ifa_address".

2. two interfaces can have the same configured address, your patch might
   end up returning the wrong address. You'd need to write && where you
   wrote ||, and you'd need to save the old address.

See the patch that I sent.

-- 
Matthias Andree
