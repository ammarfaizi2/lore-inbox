Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWFLPhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWFLPhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWFLPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:37:32 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18351 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752054AbWFLPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:37:31 -0400
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1150124830.3703.6.camel@amdx2.microgate.com>
References: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>
	 <1150124830.3703.6.camel@amdx2.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 16:53:07 +0100
Message-Id: <1150127588.25462.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-12 am 10:07 -0500, ysgrifennodd Paul Fulghum:
> Chuck:
> 
> Here is a patch to serialize flush_to_ldisc
> with per device granularity. It should fix the
> corruption of the free list that is the probably

>  	spin_unlock_irqrestore(&tty->buf.lock, flags);
> +	clear_bit(TTY_FLUSHING, &tty->flags);

Shouldn't those two be reversed if you want to go with this path. How is
this occuring anyway the flush_to_ldisc path should never re-enter.

