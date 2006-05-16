Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWEPOxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEPOxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWEPOxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:53:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:37807 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751170AbWEPOxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:53:06 -0400
Subject: Re: [PATCH] Register sysfs file for hotpluged new node
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com>
References: <20060516210608.A3E5.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 07:51:31 -0700
Message-Id: <1147791091.6623.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 21:23 +0900, Yasunori Goto wrote:
> +       /*
> +        * register this node to sysfs.
> +        * this is depends on topology. So each arch has its own.
> +        */
> +       if (new_pgdat){
> +               ret = arch_register_node(nid);
> +               BUG_ON(ret);
> +       } 

Please don't do BUG_ON()s for things like this.  Memory hotplug _should_
handle failures from top to bottom and not screw you over.  It isn't a
crime or a bug to be out of memory.  

Have you run this past the ppc maintainers?

-- Dave

