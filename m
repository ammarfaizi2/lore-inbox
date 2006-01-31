Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWAaG7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWAaG7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWAaG7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:59:01 -0500
Received: from main.gmane.org ([80.91.229.2]:19137 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030352AbWAaG7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:59:00 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [PATCH] vgacon: Add support for soft scrollback
Date: Tue, 31 Jan 2006 07:58:49 +0100
Message-ID: <drn1r9$mtm$1@sea.gmane.org>
References: <43D492C4.3000801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chaos.mk.cvut.cz
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
In-Reply-To: <43D492C4.3000801@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> The scrollback buffer of the VGA console is located in VGA RAM. This
> RAM is fixed in size and is very small. To make the scrollback buffer
> larger, it must be placed instead in System RAM.
> 
> This patch adds this feature.  The feature and the size of the buffer
> are made as a kernel config option.  Besides consuming kernel memory,
> this feature will slow down the console by approximately 20%.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
> This patch is the result of a discussion on how to capture very long
> oops tracings.  One of the suggestions was to increase the size of
> the scrollback buffer of the VGA console.
> 
> I haven't tested the code rigorously, so let me know of any bugs. I
> also tried to make it behave as close as possible to vgacon with a hard
> scrollback.

[...]

> +static int vgacon_scrolldelta(struct vc_data *c, int lines)
> +{
> +	if (!lines)		/* Turn scrollback off */
> +		c->vc_visible_origin = c->vc_origin;
> +	else {
> +		int margin = c->vc_size_row * 4;
> +		int ul, we, p, st;
> +
> +		printk("vgacon delta: %i\n", lines);

                ^^^^^^
This disables the hard scrollback, as the console is immediately
scrolled back when the mesage gets printed.

Regards,
-- 
Jindrich Makovicka

