Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSKTUoB>; Wed, 20 Nov 2002 15:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSKTUoB>; Wed, 20 Nov 2002 15:44:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2948 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261561AbSKTUoA>; Wed, 20 Nov 2002 15:44:00 -0500
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luben Tuikov <luben@splentec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <3DDBF413.C06DAF2E@splentec.com>
References: <3DDBF413.C06DAF2E@splentec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 21:19:33 +0000
Message-Id: <1037827173.3267.78.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 20:44, Luben Tuikov wrote:
> --- ll_rw_blk.c.old     Wed Nov 20 15:32:50 2002
> +++ ll_rw_blk.c Wed Nov 20 15:33:06 2002
> @@ -2092,7 +2092,7 @@
>                 complete(req->waiting);
>  
>         if (disk) {
> -               unsigned long duration = jiffies - req->start_time;
> +               unsigned long duration = (signed) jiffies - (signed) req->start_time;
>                 switch (rq_data_dir(req)) {

It was right before. Your patch breaks it. Think about it in unsigned
maths

              0x00000002 - 0xFFFFFFFF = 0x00000003

Alan

