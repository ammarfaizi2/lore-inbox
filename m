Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279632AbRJ0ATh>; Fri, 26 Oct 2001 20:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279633AbRJ0AT1>; Fri, 26 Oct 2001 20:19:27 -0400
Received: from kullstam.ne.mediaone.net ([66.30.137.210]:3973 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S279632AbRJ0ATQ>; Fri, 26 Oct 2001 20:19:16 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: old bug in sym53c8xx still lurks in 2.2.20pre
In-Reply-To: <20011024235950.A25854@mail.harddata.com>
Organization: none
Date: 26 Oct 2001 20:19:32 -0400
In-Reply-To: <20011024235950.A25854@mail.harddata.com>
Message-ID: <m21yjqdje3.fsf@euler.axel.nom>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann <michal@harddata.com> writes:

> Gerard Roudier posted at the beginning of an April a fix to a queue
> handling in that driver which seems to be forgotten.  I was looking
> through 2.2.20pre and found that the bug is still there.
> 
> There are two things about the bug - it may actually hit (some got it
> while running cdparanoia) and if you look closer at the original code
> you will see that it is quite suspicious. :-)
> 
> Here it is again the fix as posted by Gerard re-diffed against
> 2.2.19something sources.  It still applies cleanly to 2.2.20pre11.
> 
> 
> --- linux-2.2.19aa2/drivers/scsi/sym53c8xx.c.symx	Sun Mar 25 09:31:33 2001
> +++ linux-2.2.19aa2/drivers/scsi/sym53c8xx.c	Fri Apr 27 10:39:16 2001
> @@ -10125,14 +10125,13 @@
>  				if (i >= MAX_START*2)
>  					i = 0;
>  			}
> -			assert(k != -1);
> -			if (k != 1) {
> +			if (k != -1) {
>  				np->squeue[k] = np->squeue[i]; /* Idle task */
>  				np->squeueput = k; /* Start queue pointer */
> -				cp->host_status = HS_ABORTED;
> -				cp->scsi_status = S_ILLEGAL;
> -				ncr_complete(np, cp);
>  			}
> +			cp->host_status = HS_ABORTED;
> +			cp->scsi_status = S_ILLEGAL;
> +			ncr_complete(np, cp);
>  		}
>  		break;
>  	/*
> 
> Hm, I should possibly check the latest 2.4s as well.

i just checked 2.4.14-pre2 and this patch is in there.  i didn't check
on older version or when it arrived so it may be in 2.4.X going way
back.

-- 
J o h a n  K u l l s t a m
[kullstam@mediaone.net]
