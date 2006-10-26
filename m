Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423376AbWJZEQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423376AbWJZEQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 00:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423388AbWJZEQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 00:16:15 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:63402 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423376AbWJZEQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 00:16:14 -0400
Date: Thu, 26 Oct 2006 09:43:41 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] lkdtm: cleanup headers and module_param/MODULE_PARM_DESC
Message-ID: <20061026041341.GA6562@in.ibm.com>
Reply-To: ankita@in.ibm.com
References: <20061023200645.1657b7ab.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023200645.1657b7ab.randy.dunlap@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>  #include <linux/kernel.h>
> +#include <linux/fs.h>
>  #include <linux/module.h>
> +#include <linux/buffer_head.h>
>  #include <linux/kprobes.h>
> -#include <linux/kallsyms.h>
> +#include <linux/list.h>
>  #include <linux/init.h>
> -#include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/hrtimer.h>
>  #include <scsi/scsi_cmnd.h>

Why does the module require fs.h, hrtimer.h, list.h and buffer_head.h? It works fine for me without these header files. I do not get any gcc warning. Moreover, I found that even init.h and interrupt.h are also not required.
  
> +MODULE_PARM_DESC(cpoint_name, " Crash Point, where kernel is to be crashed");
> +module_param(cpoint_type, charp, 0644);
> +MODULE_PARM_DESC(cpoint_type, " Crash Point Type, action to be taken on "\
> +				"hitting the crash point");
> +module_param(cpoint_count, int, 0644);
> +MODULE_PARM_DESC(cpoint_count, " Crash Point Count, number of times the "\
                                                                            ^^not required now!
> +				"crash point is to be hit to trigger action");
>  

Thanks for fixing the typo.
 
> ---
> ~Randy

-- 
Ankita Garg 
Linux Technology Center
