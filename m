Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbUBWB2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUBWB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:28:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:36233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261772AbUBWB2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:28:11 -0500
Date: Sun, 22 Feb 2004 17:28:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] runtime PM deadlock
Message-Id: <20040222172849.76633696.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402221908540.13861@mars.home.zaxl.net>
References: <Pine.LNX.4.58.0402221908540.13861@mars.home.zaxl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Atanasov <alex@ssi.bg> wrote:
>
> 	Hello,
> 
> 	echo -n 3 > /sys/.../power/state; echo -n 2 > /sys/.../power/state
> 
> 	dpm_runtime_suspend holds dpm_sem and calls
> dpm_runtime_resume which deadlocks, instead
> directly call runtime_resume.
> 
> -- 
> have fun,
> alex
> 
> ===== drivers/base/power/runtime.c 1.2 vs edited =====
> --- 1.2/drivers/base/power/runtime.c	Wed Aug 20 09:23:32 2003
> +++ edited/drivers/base/power/runtime.c	Sun Feb 22 18:26:42 2004
> @@ -51,7 +51,7 @@
>  		goto Done;
> 
>  	if (dev->power.power_state)
> -		dpm_runtime_resume(dev);
> +		runtime_resume(dev);
> 
>  	if (!(error = suspend_device(dev,state)))
>  		dev->power.power_state = state;

heh, that's been there since day one.   Thanks.

