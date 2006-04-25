Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWDYH6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWDYH6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDYH6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:58:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22232 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751412AbWDYH63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:58:29 -0400
Date: Tue, 25 Apr 2006 00:56:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rdreier@cisco.com, openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8 of 13] ipath - fix a number of RC protocol bugs
Message-Id: <20060425005654.4c08481f.akpm@osdl.org>
In-Reply-To: <fafcc38877ad194f3a7a.1145913784@eng-12.pathscale.com>
References: <patchbomb.1145913776@eng-12.pathscale.com>
	<fafcc38877ad194f3a7a.1145913784@eng-12.pathscale.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bryan O'Sullivan" <bos@pathscale.com> wrote:
>
> +	BUG_ON(qp->timerwait.next != LIST_POISON1);
>  +	list_add_tail(&qp->timerwait, &dev->pending[dev->pending_index]);

Please don't play around with list_head internals like this - some
speedfreak might legitimately choose to remove the list_head poisoning
debug code, or make it Kconfigurable.

One option would be to always do list_del_init() on this thing, then do
BUG_ON(!list_empty()).

