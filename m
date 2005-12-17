Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVLQUjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVLQUjQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbVLQUjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:39:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964956AbVLQUjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:39:01 -0500
Date: Sat, 17 Dec 2005 12:38:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 04/13]  [RFC] ipath LLD core, part 1
Message-Id: <20051217123838.7732c201.akpm@osdl.org>
In-Reply-To: <200512161548.20XjmmxDHjOZRXcz@cisco.com>
References: <200512161548.lRw6KI369ooIXS9o@cisco.com>
	<200512161548.20XjmmxDHjOZRXcz@cisco.com>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rolandd@cisco.com> wrote:
>
> +	if ((ret = copy_from_user(&rpkt, p, sizeof rpkt))) {
> +		_IPATH_DBG("Failed to copy in pkt struct (%d)\n", ret);
> +		return ret;
> +	}

The driver does this quite a lot.  copy_from_user() will return the number
of bytes remaining to copy.  So I think we'll be wanting `return -EFAULT;'
in lots of places rather than this.
