Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHVRRr>; Thu, 22 Aug 2002 13:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHVRRr>; Thu, 22 Aug 2002 13:17:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64263
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314396AbSHVRRq>; Thu, 22 Aug 2002 13:17:46 -0400
Date: Thu, 22 Aug 2002 10:21:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac6
In-Reply-To: <20020822162705.GA7510@codepoet.org>
Message-ID: <Pine.LNX.4.10.10208221020340.11626-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep with the earlier BAILOUT stubs around it.

On Thu, 22 Aug 2002, Erik Andersen wrote:

> On Thu Aug 22, 2002 at 12:06:56PM -0400, Alan Cox wrote:
> > > Erm Alan, what happened boss ?
> > > Lemme resend that jewel.
> > 
> > I dont think you ever sent me code with that one included
> 
> 
> I believe it was supposed to be this patch I wrote up a while
> back.  Though I can't imagine it needing a config option...
> 
> --- orig/drivers/ide/ide-cd.c	Sat Aug 10 23:40:44 2002
> +++ linux-2.4.19/drivers/ide/ide-cd.c	Sat Aug 10 23:40:44 2002
> @@ -768,6 +768,11 @@
>  			   for other errors. */
>  			*startstop = DRIVER(drive)->error(drive, "cdrom_decode_status", stat);
>  			return 1;
> +		} else if (sense_key == MEDIUM_ERROR) {
> +			/* No point in re-trying a zillion times on a bad 
> +			 * sector...  If we got here the error is not correctable */
> +			ide_dump_status (drive, "media error (bad sector)", stat);
> +			cdrom_end_request(drive, 0);
>  		} else if ((++rq->errors > ERROR_MAX)) {
>  			/* We've racked up too many retries.  Abort. */
>  			cdrom_end_request(drive, 0);
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> 

Andre Hedrick
LAD Storage Consulting Group

