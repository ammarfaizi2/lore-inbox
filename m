Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbRLFJCs>; Thu, 6 Dec 2001 04:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285061AbRLFJCh>; Thu, 6 Dec 2001 04:02:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55306 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285060AbRLFJC0>; Thu, 6 Dec 2001 04:02:26 -0500
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 6 Dec 2001 09:10:43 +0000 (GMT)
Cc: akpm@zip.com.au (Andrew Morton), mingo@elte.hu,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16Bo4c-00031f-00@wagner> from "Rusty Russell" at Dec 06, 2001 01:15:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BuYF-000105-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The deadlock you're referring to is, I assume, del_timer_sync() called
> inside the timer itself?  Can you think of any other dangerous cases?

Any case where the timer handler and the calling code both want the same
lock. So for example timer based I/O completion polling will deadlock
against request code doing a del_timer_sync
