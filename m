Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSCSABV>; Mon, 18 Mar 2002 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCSABM>; Mon, 18 Mar 2002 19:01:12 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:43466 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S293132AbSCSABG> convert rfc822-to-8bit; Mon, 18 Mar 2002 19:01:06 -0500
Message-ID: <3C967FB2.1080706@drugphish.ch>
Date: Tue, 19 Mar 2002 01:00:50 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7] compilation problem
In-Reply-To: <006301c1ceca$87937c70$0201a8c0@WITEK>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Witek Krêcicki wrote:
> make[3]: Entering `/home/users/adasi/rpm/BUILD/linux-2.5.7/net/core'
> egcs -D__KERNEL__ -I/home/users/adasi/rpm/BUILD/linux-2.5.7/include -Wall -W
> strict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasi
> ng -fno-common -pipe  -march=i686   -DKBUILD_BASENAME=dev  -c -o dev.o dev.c
> dev.c: In function `netif_receive_skb':
> dev.c:1465: void value not ignored as it ought to be
> Part of .config:
> <cite>
> #
> # Networking options
> #
> CONFIG_PACKET=m

[removed unimportant part]

> CONFIG_IP_PIMSM_V2=y
> # CONFIG_ARPD is not set
> # CONFIG_INET_ECN is not set
> CONFIG_SYN_COOKIES=y

You forgot to post the important rest: CONFIG_NET_DIVERT=y

> How to fix it?

--- linux-2.5.7/net/core/dev.c	Mon Mar 18 23:17:40 2002
+++ /usr/src/linux-2.5.7/net/core/dev.c	Tue Mar 19 00:53:10 2002
@@ -1462,7 +1462,7 @@

  #ifdef CONFIG_NET_DIVERT
  	if (skb->dev->divert && skb->dev->divert->divert)
- 
	ret = handle_diverter(skb);
+ 
	handle_diverter(skb);
  #endif /* CONFIG_NET_DIVERT */
  	 
	
  #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)


I don't know why this has been changed since it doesn't differ much from 
the 2.4.x code in its invariant (CONFIG_NET_DIVERT) handling. Maybe 
DaveM had a bad day ;)

Cheers,
Roberto Nibali, ratz

