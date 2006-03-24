Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWCXRor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWCXRor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 12:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCXRor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 12:44:47 -0500
Received: from ruth.realtime.net ([205.238.132.69]:8459 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S1751298AbWCXRoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 12:44:46 -0500
In-Reply-To: <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32140afe2349e8f1726d188eb85c780c@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, hpenner@de.ibm.com,
       Paul Mackerras <paulus@samba.org>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, stk@de.ibm.com,
       benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 06/13] powerpc: cell interrupt controller updates
Date: Fri, 24 Mar 2006 11:43:39 -0600
To: Arnd Bergmann <abergman@de.ibm.com>
X-Mailer: Apple Mail (2.623)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 22, 2006, at 5:00 PM, Arnd Bergmann wrote:
>  static void spider_enable_irq(unsigned int irq)
>  {
> +	int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
>  	void __iomem *cfg = spider_get_irq_config(irq);
>  	irq = spider_get_nr(irq);
>
> -	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
> +	out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
>  	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
>  }
>

I just did a quick read of the code, but my first thought is what if 
some other node id was previously set?  Perhaps you should mask off 
some bits before or'ing in the node id?

milton

