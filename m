Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKTU77>; Wed, 20 Nov 2002 15:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSKTU77>; Wed, 20 Nov 2002 15:59:59 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:63225 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262486AbSKTU7y>; Wed, 20 Nov 2002 15:59:54 -0500
Date: Wed, 20 Nov 2002 16:06:59 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Luben Tuikov <luben@splentec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: [PATCH]: jiffies wrap in ll_rw_blk.c
Message-ID: <20021120160659.D2854@redhat.com>
References: <3DDBF413.C06DAF2E@splentec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DDBF413.C06DAF2E@splentec.com>; from luben@splentec.com on Wed, Nov 20, 2002 at 03:44:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erm, you just truncated a long to an int.

		-ben

On Wed, Nov 20, 2002 at 03:44:03PM -0500, Luben Tuikov wrote:
> --- ll_rw_blk.c.old     Wed Nov 20 15:32:50 2002
> +++ ll_rw_blk.c Wed Nov 20 15:33:06 2002
> @@ -2092,7 +2092,7 @@
>                 complete(req->waiting);
>  
>         if (disk) {
> -               unsigned long duration = jiffies - req->start_time;
> +               unsigned long duration = (signed) jiffies - (signed) req->start_time;
>                 switch (rq_data_dir(req)) {
>                     case WRITE:
>                         disk->writes++;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"Do you seek knowledge in time travel?"
