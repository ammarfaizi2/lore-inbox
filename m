Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbULTQFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbULTQFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbULTQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:05:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31725 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261548AbULTQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:05:04 -0500
Subject: Re: [PATCH] pcxx: replace cli()/sti() with
	spin_lock_irqsave()/spin_unlock_irqrestore()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20041217223426.11143.44338.87156@localhost.localdomain>
References: <20041217223426.11143.44338.87156@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103554747.30268.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:59:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-17 at 22:34, James Nelson wrote:
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(&pcxx_lock, flags);
>  	del_timer_sync(&pcxx_timer);

Not safe if the lock is grabbed by the timer between the lock and the
irqsave as it will spin on another cpu and the timer delete will never
finish.


