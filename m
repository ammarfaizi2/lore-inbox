Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIHad>; Tue, 9 Jan 2001 02:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130392AbRAIHaX>; Tue, 9 Jan 2001 02:30:23 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:12304 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S130356AbRAIHaR>; Tue, 9 Jan 2001 02:30:17 -0500
Date: Tue, 9 Jan 2001 08:30:07 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, linux@advansys.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
Message-ID: <20010109083007.A24914@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	linux@advansys.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010109001443.A20786@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jan 09, 2001 at 12:14:43AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2001 around 00:14:43 -0200, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please consider applying, comments in the patch.
> 
> - Arnaldo
> 
> 
> --- linux-2.4.0-ac4/drivers/scsi/advansys.c	Mon Jan  8 20:39:28 2001
> +++ linux-2.4.0-ac4.acme/drivers/scsi/advansys.c	Tue Jan  9 00:12:03 2001

> -STATIC int
> +STATIC unsigned long
>  DvcEnterCritical(void)
>  {
> -    int    flags;
> +    unsigned long flags;
>  
>      save_flags(flags);
>      cli();
> @@ -9965,7 +9972,7 @@
>  }

Err, according tho wise ppl on this list, this does not work on
MIPSes. The flags thing must stay in the same stackframe.

(I know, not your fault, but since you are patching the driver...)

>  STATIC void
> -DvcLeaveCritical(int flags)
> +DvcLeaveCritical(unsigned long flags)
>  {
>      restore_flags(flags);
>  }

Item.

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
