Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265155AbUEZFXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUEZFXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 01:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUEZFXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 01:23:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:22733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265155AbUEZFXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 01:23:41 -0400
Date: Tue, 25 May 2004 22:22:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: greg@kroah.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device runtime suspend/resume fixes
Message-Id: <20040525222258.5a4e9148.akpm@osdl.org>
In-Reply-To: <20040526001103.GA4845@slurryseal.ddns.mvista.com>
References: <20040526001103.GA4845@slurryseal.ddns.mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Todd Poynor <tpoynor@mvista.com> wrote:
>
> --- linux-2.6.6-orig/drivers/base/power/runtime.c	2004-05-10 11:22:58.000000000 -0700
>  +++ linux-2.6.6-pm/drivers/base/power/runtime.c	2004-05-25 16:07:57.254838016 -0700
>  @@ -12,9 +12,14 @@
>   
>   static void runtime_resume(struct device * dev)
>   {
>  +	int error;
>  +
>   	if (!dev->power.power_state)
>   		return;
>  -	resume_device(dev);
>  +	if (!(error = resume_device(dev)))
>  +		dev->power.power_state = 0;
>  +
>  +	return error;
>   }

err, this function needs a bit of work in the return value department...
