Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWEJLMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWEJLMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWEJLMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:12:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964923AbWEJLMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:12:12 -0400
Date: Wed, 10 May 2006 07:12:05 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] idetape gcc 4.1 warning fix
Message-ID: <20060510111205.GQ14147@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:55:58PM -0700, Daniel Walker wrote:
> Fixes the following warning,
> 
> drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_from_user’:
> drivers/ide/ide-tape.c:2662: warning: ignoring return value of ‘copy_from_user’, declared with attribute warn_unused_result
> drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_to_user’:
> drivers/ide/ide-tape.c:2689: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/ide/ide-tape.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/ide/ide-tape.c
> +++ linux-2.6.16/drivers/ide/ide-tape.c
> @@ -2659,7 +2659,7 @@ static void idetape_copy_stage_from_user
>  		}
>  #endif /* IDETAPE_DEBUG_BUGS */
>  		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
> -		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
> +		WARN_ON(copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count));

WARN_ON is certainly not a good way to hide this warning.
Having a user-triggerable WARN_ON is a bad idea.
Instead you should add some error handling.

	Jakub
