Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTIWV5q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 17:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbTIWV5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 17:57:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:35522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261925AbTIWV5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 17:57:45 -0400
Date: Tue, 23 Sep 2003 14:37:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: zanussi@comcast.net, Ruth.Ivimey-Cook@ivimey.org, j.grootheest@euronext.nl,
       willy@w.ods.org, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-Id: <20030923143754.6b9efbc9.akpm@osdl.org>
In-Reply-To: <20030923175320.GD1269@velociraptor.random>
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org>
	<3F708576.4080203@comcast.net>
	<20030923175320.GD1269@velociraptor.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> I don't think we can merge this in 2.4 but it looks good for 2.6.

I think so: doing it via a __setup parameter is much smarter than requiring
a rebuild.

> +static int __init log_buf_len_setup(char *str)
> +{
> +	unsigned long size = simple_strtoul(str, &str, 0);
> +
> +	if (size & (size-1))
> +		printk("log_buf_len: invalid size - needs a power of two\n");

You need to either panic or return here.


