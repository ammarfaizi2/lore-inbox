Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbTHWW5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTHWW5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:57:45 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:3978 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262936AbTHWW5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:57:44 -0400
Date: Sat, 23 Aug 2003 19:57:40 -0300
From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
To: linux-kernel@vger.kernel.org
Cc: Frank.Cornelis@elis.ugent.be
Subject: Re: [PATCH] sched: CPU_THRESHOLD
Message-Id: <20030823195740.7133874d.rnsanchez@terra.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello Frank,

> -	*imbalance = (max_load - nr_running) / 2;
> +	*imbalance = (max_load - nr_running) >> 1;

I think it is a good coding practice to keep things human-readable. 
In this code snippet, the division by 2 is quickly understood by most
readers (specially those who didn't write it).  The right shift may
obfuscate the real meaning of this operation, which is a single
division by 2, not a bit-oriented expression.

Assuming that sched.c will be compiled with optimizations enabled, the
compiler will change the human-readable division by a fast machine
right shift operation, whenever possible (gcc surely will).

Thus, we keep the kernel code more readable, and sometimes let the
compiler apply newer (and hopefully faster) optimizations than some
tricks we have known as fastest available.

Regards, and please let me know what do you think about it.

-- 
Ricardo Nabinger Sanchez
GNU/Linux #140696 [http://counter.li.org]
Slackware Linux

