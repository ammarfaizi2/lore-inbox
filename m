Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262237AbSJJVTb>; Thu, 10 Oct 2002 17:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSJJVTb>; Thu, 10 Oct 2002 17:19:31 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42502
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262237AbSJJVTb>; Thu, 10 Oct 2002 17:19:31 -0400
Subject: Re: 2.5.41 isofs patch to avoid "bad: scheduling while atomic!"
From: Robert Love <rml@tech9.net>
To: Sylvain Pasche <sylvain_pasche@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15781.47072.335973.295982@yahoo.fr>
References: <15781.47072.335973.295982@yahoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Oct 2002 17:25:15 -0400
Message-Id: <1034285116.795.1667.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-10 at 13:24, Sylvain Pasche wrote:


> -       tmpname = (char *) __get_free_page(GFP_KERNEL);
> +       tmpname = (char *) __get_free_page(GFP_KERNEL | GFP_ATOMIC);
>         if (!tmpname)
>                 return -ENOMEM;
>         tmpde = (struct iso_directory_record *) (tmpname+1024);

You just want GFP_ATOMIC, not the OR of both.

I do not see where the lock is in the call path, though.  The
lock_kernel() is not counted.

I also wonder why the __might_sleep was just triggered but the
schedule() check was?  Are you sure this is the culprit?  By the looks
of it, I would think it is somewhere north of __might_sleep in the stack
trace.

	Robert Love

