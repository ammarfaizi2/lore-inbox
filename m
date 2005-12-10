Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVLJHwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVLJHwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVLJHwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:52:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932769AbVLJHwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:52:42 -0500
Date: Fri, 9 Dec 2005 23:52:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 14/17] s390: introduce struct channel_subsystem.
Message-Id: <20051209235225.3936c1a0.akpm@osdl.org>
In-Reply-To: <20051209152846.GO6532@skybase.boeblingen.de.ibm.com>
References: <20051209152846.GO6532@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> +	/* Setup css structure. */
>  +	for (i = 0; i <= __MAX_CSSID; i++) {
>  +		css[i] = kmalloc(sizeof(struct channel_subsystem), GFP_KERNEL);
>  +		if (!css[i]) {
>  +			ret = -ENOMEM;
>  +			goto out_bus;
>  +		}
>  +		setup_css(i);
>  +		ret = device_register(&css[i]->device);
>  +		if (ret)
>  +			goto out_free;
>  +	}
>   	css_init_done = 1;
>   
>   	ctl_set_bit(6, 28);
>   
>   	for_each_subchannel(__init_channel_subsystem, NULL);
>   	return 0;
>  +out_free:
>  +	kfree(css[i]);
>   out_bus:
>  +	while (i > 0) {
>  +		i--;
>  +		device_unregister(&css[i]->device);
>  +	}

I spy a memory leak.
