Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVAGQuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVAGQuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVAGQt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:49:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:25025 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261503AbVAGQtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:49:55 -0500
Subject: Re: In last setsid/tty locking changes...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marco Cipullo <cipullo@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501071437.02426.cipullo@libero.it>
References: <200501071437.02426.cipullo@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105110088.17166.341.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 15:45:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 13:37, Marco Cipullo wrote:
> In last setsid/tty locking changes:
> +	down(&tty_sem);
>  	current->signal->tty = NULL;
> +	up(&tty_sem);
>  
>  	/* Block and flush all signals */
>  	sigfillset(&blocked);
> 
> Sorry for the silly question, but why is needed a semaphore to write just one 
> value without read/write nothing else?

Look at the tty init_dev code paths and it might make more sense. It
doesn't just say "protect this write" more importantly it says "don't do
this in parallel with tty setup"

