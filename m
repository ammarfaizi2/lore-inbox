Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUEKVhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUEKVhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUEKVex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:34:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:32956 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263665AbUEKVbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:31:21 -0400
Date: Tue, 11 May 2004 14:33:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: dsaxena@plexity.net
Cc: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Watchdog timer for Intel IXP4xx CPUs
Message-Id: <20040511143352.096bc071.akpm@osdl.org>
In-Reply-To: <20040511212235.GA7729@plexity.net>
References: <20040511212235.GA7729@plexity.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena <dsaxena@plexity.net> wrote:
>
> 
> Following patch against 2.6.6 adds a driver for the watchdogs on the
> Intel IXP4xx family of network processors (ARM). Please apply.
> 
> ...
> +
> +	clear_bit(1, &wdt_status);

It'd be nice to enumerate the bits in wdt_status.

> +
> +	case WDIOC_SETTIMEOUT:
> +		ret = get_user(time, (int *)arg);
> +		if (ret)
> +			break;
> +
> +		if (time <= 0 || time > 60) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		heartbeat = time;
> +		wdt_enable();

Missing a break here?

> +	case WDIOC_GETTIMEOUT:
> +		ret = put_user(heartbeat, (int *)arg);
> +		break;
> +
> +	case WDIOC_KEEPALIVE:
> +		wdt_enable();
> +		ret = 0;
> +		break;
> +	}
> +	return ret;


