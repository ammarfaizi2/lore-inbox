Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265115AbUENCpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUENCpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 22:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUENCpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 22:45:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:50077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265115AbUENCpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 22:45:51 -0400
Date: Thu, 13 May 2004 19:44:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow console drivers to be called early
Message-Id: <20040513194408.0e6ba433.akpm@osdl.org>
In-Reply-To: <200405131547.14062.jbarnes@engr.sgi.com>
References: <200405131547.14062.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> This is a simple patch to allow arches to set early_printk_ok if they've 
>  registered console drivers that support early operation.  I've got an ia64 
>  specific bit and an sn2 specific bit that I can post for reference if 
>  anyone's interested, but they're pretty straightforward, so I'm just posting 
>  this for comments.  The ia64 one just adds a register_early_consoles() 
>  function to the ia64 code that gets called early on in setup_arch.  All it 
>  does is call the init routines of console drivers that are setup to do early 
>  printks.
>
> ...
>    * console_sem protects the console_drivers list, and also
>  @@ -526,7 +527,7 @@
>   			log_level_unknown = 1;
>   	}
>   
>  -	if (!cpu_online(smp_processor_id()) &&
>  +	if (!early_printk_ok && !cpu_online(smp_processor_id()) &&

Is it not possible to mark this cpu as being online?   It sure seems to be.

