Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310426AbSCSHtd>; Tue, 19 Mar 2002 02:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310428AbSCSHtY>; Tue, 19 Mar 2002 02:49:24 -0500
Received: from [61.149.37.113] ([61.149.37.113]:24332 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S310426AbSCSHtM>;
	Tue, 19 Mar 2002 02:49:12 -0500
Date: Tue, 19 Mar 2002 15:48:53 +0800
From: hugang <gang_hu@soul.com.cn>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: adasi@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] compilation problem
Message-Id: <20020319154853.43fbe03b.gang_hu@soul.com.cn>
In-Reply-To: <3C967FB2.1080706@drugphish.ch>
Organization: soul
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002 01:00:50 +0100
Roberto Nibali <ratz@drugphish.ch> wrote:

> Hi,
> 
> > make[3]: Entering `/home/users/adasi/rpm/BUILD/linux-2.5.7/net/core'
> > egcs -D__KERNEL__ -I/home/users/adasi/rpm/BUILD/linux-2.5.7/include -Wall -W
> > strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
> > ng -fno-common -pipe  -march=i686   -DKBUILD_BASENAME=dev  -c -o dev.o dev.c
> > dev.c: In function `netif_receive_skb':
> > dev.c:1465: void value not ignored as it ought to be
> > Part of .config:
> > <cite>
> > #
> > # Networking options
> > #
> > CONFIG_PACKET=m
> 
> [removed unimportant part]
> 
> > CONFIG_IP_PIMSM_V2=y
> > # CONFIG_ARPD is not set
> > # CONFIG_INET_ECN is not set
> > CONFIG_SYN_COOKIES=y
> 
> You forgot to post the important rest: CONFIG_NET_DIVERT=y
> 
> > How to fix it?
> 
> --- linux-2.5.7/net/core/dev.c	Mon Mar 18 23:17:40 2002
> +++ /usr/src/linux-2.5.7/net/core/dev.c	Tue Mar 19 00:53:10 2002
> @@ -1462,7 +1462,7 @@
> 
>   #ifdef CONFIG_NET_DIVERT
>   	if (skb->dev->divert && skb->dev->divert->divert)
> - 
> 	ret = handle_diverter(skb);
> + 
> 	handle_diverter(skb);
>   #endif /* CONFIG_NET_DIVERT */
>   	 
> 	
>   #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
> 
> 
> I don't know why this has been changed since it doesn't differ much from 
> the 2.4.x code in its invariant (CONFIG_NET_DIVERT) handling. Maybe 
> DaveM had a bad day ;)
> 
> Cheers,
> Roberto Nibali, ratz
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Today I download the latest patch, And I patch it into the 2.5.6 tree, But it do't have that problem.? I chech dev.c , that is right.
-- 
thanks with regards!
hugang.

***********************************
Beijing Soul Technology Co.,Ltd.
Tel:010-68425741/42/43/44
Fax:010-68425745
email:gang_hu@soul.com.cn
web:http://www.soul.com.cn
***********************************
