Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbRL2GWP>; Sat, 29 Dec 2001 01:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287142AbRL2GWF>; Sat, 29 Dec 2001 01:22:05 -0500
Received: from svr3.applink.net ([206.50.88.3]:24595 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S287141AbRL2GV5>;
	Sat, 29 Dec 2001 01:21:57 -0500
Message-Id: <200112290621.fBT6LeSr007977@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Andrew Morton <akpm@zip.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
Date: Sat, 29 Dec 2001 00:17:57 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200112290321.fBT3GCSs007627@svr3.applink.net> <3C2D3DBB.6ADE1CC5@zip.com.au>
In-Reply-To: <3C2D3DBB.6ADE1CC5@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 December 2001 21:51, you wrote:
> Timothy Covell wrote:
> > lockup
> > ...
> > sbp2
> > ...
> > SMP
> > ...
>
> --- linux-2.4.17-pre8/drivers/ieee1394/sbp2.c	Mon Dec 10 13:46:20 2001
> +++ linux-akpm/drivers/ieee1394/sbp2.c	Wed Dec 12 20:50:16 2001
> @@ -2773,7 +2773,9 @@ static void sbp2scsi_complete_command(st
>  	/*
>  	 * Tell scsi stack that we're done with this command
>  	 */
> +	spin_lock_irq(&io_request_lock);
>  	done (SCpnt);
> +	spin_unlock_irq(&io_request_lock);
>
>  	return;
>  }
>
> 

That did the trick. I'm writing this on 2.4.16-ctx4 with this patch on SMP.
It's amazing what a little spin lock will do.  Thanks!

(Even if I had realized that this was fixed on 2.4.17, I had other issues
with 2.4.17 which prevented me from wanting to run it.)

timothy.covell@ashavan.org.
