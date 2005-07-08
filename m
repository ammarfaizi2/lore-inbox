Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVGHXLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVGHXLy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 19:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVGHXJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 19:09:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262959AbVGHXHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 19:07:31 -0400
Date: Fri, 8 Jul 2005 16:08:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, clucas@rotomalug.org, domen@coderock.org
Subject: Re: [patch 1/4] drivers/char/ip2/i2lib.c: replace direct assignment
 with set_current_state()
Message-Id: <20050708160824.10d4b606.akpm@osdl.org>
In-Reply-To: <20050707213138.184888000@homer>
References: <20050707213138.184888000@homer>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> @@ -655,7 +655,7 @@ i2QueueCommands(int type, i2ChanStrPtr p
>  			timeout--;   // So negative values == forever
>  		
>  		if (!in_interrupt()) {

I worry about what this driver is trying to do...

> -			current->state = TASK_INTERRUPTIBLE;
> +			set_current_state(TASK_INTERRUPTIBLE);
>  			schedule_timeout(1);	// short nap 

We do this all over the place.  Adding new schedule_timeout_interruptible()
and schedule_timeout_uninterruptible() would reduce kernel size and neaten
things up.
