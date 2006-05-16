Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWEPQwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEPQwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWEPQwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:52:34 -0400
Received: from over.ny.us.ibm.com ([32.97.182.150]:23720 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S932123AbWEPQwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:52:33 -0400
Subject: Re: [PATCH] Register sysfs file for hotpluged new node
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com>
References: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 07:55:12 -0700
Message-Id: <1147791312.6623.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 21:23 +0900, Yasunori Goto wrote:
> +int arch_register_node(int num){
> +       int p_node;
> +       struct node *parent = NULL;
> +
> +       if (!node_online(num))
> +               return 0;
> +       p_node = parent_node(num);
> +
> +       if (p_node != num)
> +               parent = &node_devices[p_node].node;
> +
> +       return register_node(&node_devices[num].node, num, parent);
> +}
> +
> +void arch_unregister_node(int num)
> +{
> +       unregister_node(&node_devices[num].node);
> +}
...
> +int arch_register_node(int i)
> +{
> +       int error = 0;
> +
> +       if (node_online(i)){
> +               int p_node = parent_node(i);
> +               struct node *parent = NULL;
> +
> +               if (p_node != i)
> +                       parent = &node_devices[p_node];
> +               error = register_node(&node_devices[i], i, parent);
> +       }
> +
> +       return error;
> +} 

While you're at it, can you consolidate these two functions?  I don't
see too much of a reason for keeping them separate.  You can probably
also kill the 'struct i386_node' since it is just a 'struct node'
wrapper anyway.  

I promise not to complain if you fix the i386 function's braces, too. ;)

-- Dave

