Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319357AbSHNVmu>; Wed, 14 Aug 2002 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319358AbSHNVmu>; Wed, 14 Aug 2002 17:42:50 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:40964 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S319357AbSHNVmt>; Wed, 14 Aug 2002 17:42:49 -0400
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem : can't make pipe non-blocking on 2.5.X
References: <20020814181902.GA24047@bougret.hpl.hp.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 15 Aug 2002 06:46:18 +0900
In-Reply-To: <20020814181902.GA24047@bougret.hpl.hp.com>
Message-ID: <87lm79ru51.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes <jt@bougret.hpl.hp.com> writes:

> 	Hi,
> 
> 	I've got the following problem : I can't make a pipe
> non-blocking with 2.5.25.
> 	The various man pages don't mention anything
> about it (actually, the "fifo" man page say that non-blocking mode
> should succeed). And it seems to work fine on 2.4.20.
> 	Sorry if this has already been reported and fixed, but I
> quicly searched the changelog and archive and found nothing.
> 
> 	So, who should I complain to ?
> 

[...]

>   err = fcntl(trigger_pipe[0], F_GETFL, &flags);

F_GETFL should be,
    flags = fcntl(trigger_pipe[0], F_GETFL, 0);

>   fprintf(stderr, "GET FLAGS : %d - %X\n", err, flags);
>   if(err >= 0)
>     {
>       flags |= O_NONBLOCK;
>       err = fcntl(trigger_pipe[0], F_SETFL, flags);
>       fprintf(stderr, "SET FLAGS : %d - %d\n", err, errno);
>     }
>   return(0);
> }
> ------------- Output 2.5.25 ----------------
> GET FLAGS : 0 - 40045F18
> SET FLAGS : -1 - 22
> ------------- Output 2.4.20-pre2 -----------
> GET FLAGS : 0 - 40043F18
> SET FLAGS : 0 - 0
> --------------------------------------------

Looks like effect of different implement of O_DIRECT(0x40000).
Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
