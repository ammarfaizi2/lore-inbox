Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSGJQlY>; Wed, 10 Jul 2002 12:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSGJQlX>; Wed, 10 Jul 2002 12:41:23 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:31500 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317538AbSGJQlW>;
	Wed, 10 Jul 2002 12:41:22 -0400
Message-ID: <3D2C64AF.6020102@si.rr.com>
Date: Wed, 10 Jul 2002 12:45:35 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.25 : tr_source_route fix
References: <Pine.LNX.4.44.0207101011580.873-100000@localhost.localdomain> <200207101548.g6AFmUg96842@d12relay01.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,
    I have a few questions regarding your patch. I don't see the line 
you are removing from net/netsyms.c in 2.5.25 , and for 
net/llc/llc_mac.c , I also don't see where trdevice.h would be included 
to make the reference to tr_source_route . Thanks.

Regards,
Frank

Arnd Bergmann wrote:


> This declaration is not needed any more, since it now is in the header file. The other
> declaration in net/netsyms.c and net/llc/llc_mac.c should be removed as well.
> replacement patch follows.
> 
> 	Arnd <><
> 
> diff -u -r1.1.1.1 trdevice.h
> --- a/include/linux/trdevice.h	2002/03/13 19:33:11	1.1.1.1
> +++ b/include/linux/trdevice.h	2002/07/10 15:34:28
> @@ -33,6 +33,9 @@
>  				   void *saddr, unsigned len);
>  extern int		tr_rebuild_header(struct sk_buff *skb);
>  extern unsigned short	tr_type_trans(struct sk_buff *skb, struct net_device *dev);
> +extern void		tr_source_route(struct sk_buff *skb, 
> +					struct trh_hdr *trh,
> +					struct net_device *dev);
>  extern struct net_device *init_trdev(struct net_device *dev, int sizeof_priv);
>  extern struct net_device *alloc_trdev(int sizeof_priv);
>  extern int register_trdev(struct net_device *dev);
> diff -u -r1.6 netsyms.c
> --- a/net/netsyms.c	2002/06/25 09:36:58	1.6
> +++ b/net/netsyms.c	2002/07/10 15:34:28
> @@ -444,8 +444,6 @@
>  #endif  /* CONFIG_INET */
>  
>  #if defined(CONFIG_TR) && defined(CONFIG_LLC)
> -extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh,
> -			    struct net_device *dev);
>  EXPORT_SYMBOL(tr_source_route);
>  EXPORT_SYMBOL(tr_type_trans);
>  #endif
> diff -u -r1.3 tr.c
> --- a/net/802/tr.c	2002/05/27 12:33:18	1.3
> +++ b/net/802/tr.c	2002/07/10 15:34:28
> @@ -36,7 +36,6 @@
>  #include <linux/init.h>
>  #include <net/arp.h>
>  
> -static void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh, struct net_device *dev);
>  static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev);
>  static void rif_check_expire(unsigned long dummy);
>  
> @@ -230,7 +229,7 @@
>   *	We try to do source routing... 
>   */
>  
> -static void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
> +void tr_source_route(struct sk_buff *skb,struct trh_hdr *trh,struct net_device *dev) 
>  {
>  	int i, slack;
>  	unsigned int hash;
> diff -u -r1.1 llc_mac.c
> --- a/net/llc/llc_mac.c	2002/06/25 09:37:00	1.1
> +++ b/net/llc/llc_mac.c	2002/07/10 15:34:29
> @@ -25,10 +25,7 @@
>  #include <net/llc_evnt.h>
>  #include <net/llc_c_ev.h>
>  #include <net/llc_s_ev.h>
> -#ifdef CONFIG_TR
> -extern void tr_source_route(struct sk_buff *skb, struct trh_hdr *trh,
> -			    struct net_device *dev);
> -#endif
> +
>  /* function prototypes */
>  static void fix_up_incoming_skb(struct sk_buff *skb);
> 


