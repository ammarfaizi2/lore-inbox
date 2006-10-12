Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWJLVDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWJLVDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWJLVDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:03:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750836AbWJLVDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:03:36 -0400
Date: Thu, 12 Oct 2006 14:03:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>,
       okuji@enbug.org
Subject: Re: [patch 2/7] fault-injection capabilities infrastructure
Message-Id: <20061012140323.613c2b50.akpm@osdl.org>
In-Reply-To: <452df21c.77a917b6.3845.2dc5@mx.google.com>
References: <20061012074305.047696736@gmail.com>
	<452df21c.77a917b6.3845.2dc5@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:07 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> From: Akinobu Mita <akinobu.mita@gmail.com>
> 
> This patch provides base functions for implement fault-injection
> capabilities.
> 
> - Lightweight random simulator is taken from crasher module for SUSE kernel

heh, another one.

Please switch over to carta_random32() for now.  Later we'll probably be
removing carta_random32() and adding random32(), but I can take care of
that.


> +#define failure_probability(attr)	(attr)->probability
> +#define failure_interval(attr)		(attr)->interval
> +#define max_failures(attr)		(attr)->times
> +#define current_space(attr)		(attr)->space
> +#define atomic_dec_not_zero(v)		atomic_add_unless((v), -1, 0)

Please remove these macros and simply open-code these operations at each
callsite.

