Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVCWNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVCWNHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 08:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCWNHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 08:07:17 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:8201 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261587AbVCWNHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 08:07:07 -0500
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [6/9] [RFC] Steps to fixing the driver model locking
References: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 23 Mar 2005 22:06:45 +0900
In-Reply-To: <Pine.LNX.4.50.0503211245530.20647-100000@monsoon.he.net> (Patrick
 Mochel's message of "Mon, 21 Mar 2005 12:48:47 -0800 (PST)")
Message-ID: <8764zicxzu.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@digitalimplant.org> writes:

> +void klist_del(struct klist_node * n)
> +{
> +	struct klist * k = n->n_klist;
> +
> +	spin_lock(&k->k_lock);
> +	klist_dec_and_del(n);
> +	spin_unlock(&k->k_lock);
> +}

Can't we use atomic_dec_and_lock()?

[...]

> +void klist_remove(struct klist_node * n)
> +{
> +	spin_lock(&n->n_klist->k_lock);
> +	klist_dec_and_del(n);
> +	spin_unlock(&n->n_klist->k_lock);
> +	wait_for_completion(&n->n_removed);
> +}

Why isn't those going into drivers/base/?  Personally, klist seems
drivers/base stuff rather than generic stuff...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
