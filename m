Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWAFH2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWAFH2F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWAFH2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:28:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932654AbWAFH2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:28:03 -0500
Date: Thu, 5 Jan 2006 23:27:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(percpu_data) and removes dependance
 against NR_CPUS
Message-Id: <20060105232736.12c5c8d8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601060816330.22809@yvahk01.tjqt.qr>
References: <1135251766.3557.13.camel@pmac.infradead.org>
	<20060105021929.498f45ef.akpm@osdl.org>
	<43BD2406.2040007@cosmosbay.com>
	<Pine.LNX.4.61.0601060816330.22809@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> 
> 
> --- linux-2.6.15/include/linux/percpu.h	2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.15-edum/include/linux/percpu.h	2006-01-05 14:45:48.000000000 +0100
> @@ -18,8 +18,7 @@
>  #ifdef CONFIG_SMP
>  
>  struct percpu_data {
> -	void *ptrs[NR_CPUS];
> -	void *blkp;
> +	void *ptrs[1]; /* real size depends on highest_possible_processor_id() */
>  };
>  
>  /* 
> 
> 
> I think we can use *ptrs[0] here.
> 

We can.  In fact with the gcc-2.95 abandonment I think we can use ptrs[].

But it doesn't matter.
