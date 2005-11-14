Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVKNXXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVKNXXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKNXXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:23:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46287 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751309AbVKNXXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:23:08 -0500
Date: Mon, 14 Nov 2005 15:23:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] register_ and unregister_memory_notifier should be
 global
Message-Id: <20051114152316.4060d30c.akpm@osdl.org>
In-Reply-To: <20051114193738.GA15494@shadowen.org>
References: <exportbomb.1131997056@pinky>
	<20051114193738.GA15494@shadowen.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> Both register_memory_notifer and unregister_memory_notifier are global
> and declared so in linux.h.  Update the HOTPLUG specific definitions
> to match.  This fixes a compile warning when HOTPLUG is enabled.
> 

There is no linux.h and I can find no .h file which declares
register_memory_notifier().  Please clarify?


> ---
>  memory.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> diff -upN reference/drivers/base/memory.c current/drivers/base/memory.c
> --- reference/drivers/base/memory.c
> +++ current/drivers/base/memory.c
> @@ -50,12 +50,12 @@ static struct kset_hotplug_ops memory_ho
>  
>  static struct notifier_block *memory_chain;
>  
> -static int register_memory_notifier(struct notifier_block *nb)
> +int register_memory_notifier(struct notifier_block *nb)
>  {
>          return notifier_chain_register(&memory_chain, nb);
>  }
>  
> -static void unregister_memory_notifier(struct notifier_block *nb)
> +void unregister_memory_notifier(struct notifier_block *nb)
>  {
>          notifier_chain_unregister(&memory_chain, nb);
>  }
