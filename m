Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291312AbSBQX1O>; Sun, 17 Feb 2002 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSBQX1E>; Sun, 17 Feb 2002 18:27:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13575 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291312AbSBQX0x>;
	Sun, 17 Feb 2002 18:26:53 -0500
Message-ID: <3C703C36.A7579B72@mandrakesoft.com>
Date: Sun, 17 Feb 2002 18:26:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: linux-kernel@vger.kernel.org, khc@pm.waw.pl, davem@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (1/3)
In-Reply-To: <20020217193051.C14629@se1.cogenit.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> 
> [1/3]:
> - struct if_settings in struct ifreq becomes struct if_settings *

mostly ok... I'm wondering how this specific item (shown below in the
patch portion quoted) affects binary compatibility...  how does this
affect userland if ifru_settings is suddenly a pointer?

	Jeff


> --- linux-2.5.5-pre1-kh/include/linux/if.h      Sun Feb 17 17:39:24 2002
> +++ linux-2.5.5-pre1-ma_pomme/include/linux/if.h        Sun Feb 17 17:42:10 > @@ -95,10 +96,13 @@ struct ifmap
>  struct if_settings
>  {
>         unsigned int type;      /* Type of physical device or protocol */
> -       unsigned int data_length; /* device/protocol data length */
> -       void * data;            /* pointer to data, ignored if length = 0 */
> +       union {
> +               /* {atm/eth/dsl}_settings anyone ? */
> +               struct hdlc_settings ifsu_hdlc;
> +       } ifs_ifsu;
>  };
> 
> +#define ifs_hdlc       ifs_ifsu.ifsu_hdlc
> 
>  /*
>   * Interface request structure used for socket
> @@ -129,7 +133,7 @@ struct ifreq
>                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
>                 char    ifru_newname[IFNAMSIZ];
>                 char *  ifru_data;
> -               struct  if_settings ifru_settings;
> +               struct  if_settings *ifru_settings;
>         } ifr_ifru;
>  };
>
