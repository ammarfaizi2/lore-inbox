Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTKKAxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbTKKAxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:53:03 -0500
Received: from waste.org ([209.173.204.2]:53924 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263294AbTKKAxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:53:01 -0500
Date: Mon, 10 Nov 2003 18:52:33 -0600
From: Matt Mackall <mpm@selenic.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: lkcd-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com
Subject: Re: LKCD Network dump over netpoll patch (2.6.0-test9)
Message-ID: <20031111005233.GV13246@waste.org>
References: <20031110140742.GJ1409@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110140742.GJ1409@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 07:37:42PM +0530, Prasanna S Panchamukhi wrote:
> Hi,
> 

Hi.

> +		put_unaligned(htonl(reply.nr), (u32 *) (tmp_membuf + 1));
> +		put_unaligned(htonl(reply.code), (u32 *) (tmp_membuf + 5));
> +		put_unaligned(htonl(reply.info), (u32 *) (tmp_membuf + 9));
> +
> +		memcpy((tmp_membuf + HEADER_LEN), buff + offset, 1024);
> +		netpoll_send_udp(np, tmp_membuf, (1024 + HEADER_LEN));

There's quite a few instances of this header business, it could really
stand to be in its own netdump_send(nr, code, info, data) function.

> -			dump_ndev->poll_controller(dump_ndev);
> +			netpoll_poll(&net_dev->np);
>  			zap_completion_queue();
...
> +void zap_completion_queue(void);

Instead of this (missing netpoll_, btw), how about we call
zap_completion_queue inside of netpoll_poll?

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
