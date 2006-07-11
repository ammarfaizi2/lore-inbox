Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWGKK2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWGKK2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWGKK2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:28:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750958AbWGKK2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:28:30 -0400
Date: Tue, 11 Jul 2006 03:28:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: rdunlap@xenotime.net, mreuther@umich.edu, linux-kernel@vger.kernel.org,
       zap@homelink.ru
Subject: Re: [PATCH] backlight: lcd: Remove dependency from the framebuffer
 layer
Message-Id: <20060711032817.94c78ae0.akpm@osdl.org>
In-Reply-To: <44B34D68.3080602@gmail.com>
References: <200607100833.00461.mreuther@umich.edu>
	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>
	<44B27931.30609@gmail.com>
	<200607102327.38426.mreuther@umich.edu>
	<20060710215253.1fcaab57.rdunlap@xenotime.net>
	<44B34D68.3080602@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 15:04:08 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> +#if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
> +			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))

Peeking at CONFIG_FB_MODULE like this is considered sinful.

<tries to remember why>

Because someone might build a CONFIG_FB=n, CONFIG_FB_MODULE=n kernel, then
later build the fbdev module for that kernel only to find that the
backlight driver doesn't know that the fbdev module is available.

Or something like that.  It's pretty contrived, and I really doubt that
anyone's going to try to cobble together a kernel like that.

Or maybe there's a better reason...
