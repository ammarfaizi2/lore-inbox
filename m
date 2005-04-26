Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDZQf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDZQf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVDZQeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:34:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:57485 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261677AbVDZQ2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:28:07 -0400
Date: Tue, 26 Apr 2005 21:57:51 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't oops when unregistering unknown kprobes
Message-ID: <20050426162751.GD32766@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050426162203.GE27406@gilgamesh.home.res>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426162203.GE27406@gilgamesh.home.res>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -107,6 +107,13 @@ rm_kprobe:
>  void unregister_kprobe(struct kprobe *p)
>  {
>  	unsigned long flags;
> +
> +	if (!get_kprobe(p)) {
> +		printk(KERN_WARNING "Warning: Attempt to unregister "
> +					"unknown kprobe (addr:0x%lx)\n",
> +					(unsigned long) p);
> +		return;
> +	}

This is wrong. You should call get_kprobe() with spin_lock().
 

-Prasanna

-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
