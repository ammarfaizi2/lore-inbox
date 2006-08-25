Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWHYCwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWHYCwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 22:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWHYCwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 22:52:54 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:62420 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751630AbWHYCwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 22:52:53 -0400
Date: Fri, 25 Aug 2006 11:52:20 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG[[PATCH] register_one_node compile fix.
Cc: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060825105755.55b15220.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060825105755.55b15220.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20060825115024.076F.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.
Thanks.

Acked-by: Yasunori Goto <y-goto@jp.fujitsu.com>

> register_one_node()'s should be defined under CONFIG_NUMA=n.
> fixes following bug.
> --
>   CC	  init/version.o
>   LD	  init/built-in.o
>   LD	  .tmp_vmlinux1
> mm/built-in.o: In function `add_memory':
> : undefined reference to `register_one_node'
> --
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Index: linux-2.6.18-rc4/include/linux/node.h
> ===================================================================
> --- linux-2.6.18-rc4.orig/include/linux/node.h
> +++ linux-2.6.18-rc4/include/linux/node.h
> @@ -30,12 +30,20 @@ extern struct node node_devices[];
>  
>  extern int register_node(struct node *, int, struct node *);
>  extern void unregister_node(struct node *node);
> +#ifdef CONFIG_NUMA
>  extern int register_one_node(int nid);
>  extern void unregister_one_node(int nid);
> -#ifdef CONFIG_NUMA
>  extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  #else
> +static inline int register_one_node(int nid)
> +{
> +	return 0;
> +}
> +static inline int unregister_one_node(int nid)
> +{
> +	return 0;
> +}
>  static inline int register_cpu_under_node(unsigned int cpu, unsigned int nid)
>  {
>  	return 0;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Yasunori Goto 


