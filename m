Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263400AbVGAQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbVGAQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbVGAQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:59:19 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:64209 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263400AbVGAQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:59:01 -0400
MIME-Version: 1.0
In-Reply-To: <20050701161534.GJ2243@suse.de>
References: <1DoNSU-0kLq880@fwd18.aul.t-online.de> <20050701161534.GJ2243@suse.de>
Date: Fri,  1 Jul 2005 18:58:47 +0200
To: "Jens Axboe" <axboe@suse.de>
X-UMS: email
X-Mailer: TOI Kommunikationscenter V5-1
Subject: Re: Re: PATCH for ide_floppy
Cc: paul@paulbristow.net, linux-kernel@vger.kernel.org,
       manfred.scherer@siemens.com
From: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1DoOqm-0TquC80@fwd16.aul.t-online.de>
X-ID: ToZGMsZG8eXkQxHML1nPly7LMAY4SK1nf0sKZNzCG7RXEnTRmhNncb@t-dialin.net
X-TOI-MSGID: 127535c6-c567-476d-8089-b590e17758ec
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's not really a performance issue but more a timeout issue.
'IDEFLOPPY_TICKS_DELAY  60' avoids error messages in /var/log/messages
like 'reset ide ...'.
Without the idefloppy_timer_expiry the data transfer to the ide-floppy
is pending a long time between some transfer of data. The floppy LED
indicated this too.
With kernel 2.4.x I've never had this problem.

Manfred Scherer




-----Original Message-----
Date: Fri,  1 Jul 2005 18:15:34 +0200
Subject: Re: PATCH for ide_floppy
From: Jens Axboe <axboe@suse.de>
To: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>

On Fri, Jul 01 2005, Manfred.Scherer.Mhm@t-online.de wrote:
> --- linux-2.6.12/drivers/ide/ide-floppy.c.ORIG  2005-06-17
> 21:48:29.000000000 +0200
> +++ linux-2.6.12/drivers/ide/ide-floppy.c       2005-06-25
> 03:29:45.000000000 +0200
> @@ -125,7 +125,14 @@
>  /*
>   *     Some drives require a longer irq timeout.
>   */
> +#if 0
>  #define IDEFLOPPY_WAIT_CMD             (5 * WAIT_CMD)
> +#endif
> +#if 0
> +#define IDEFLOPPY_WAIT_CMD             200     /* --ms  */
> +#endif
> +#define IDEFLOPPY_WAIT_CMD             WAIT_CMD        /* 2004/12/31
> --ms */
> +
>
>  /*
>   *     After each failed packet command we issue a request sense
> command
> @@ -317,7 +324,13 @@
>         unsigned long flags;
>  } idefloppy_floppy_t;
>
> +#if 0
>  #define IDEFLOPPY_TICKS_DELAY  3       /* default delay for ZIP 100
*/
> +#define IDEFLOPPY_TICKS_DELAY  6       /* default delay for ZIP 100
> --ms 2005/01/01 */
> +#define IDEFLOPPY_TICKS_DELAY  12      /* default delay for ZIP 100
> --ms 2005/01/01 */
> +#endif
> +#define IDEFLOPPY_TICKS_DELAY  60      /* default delay for ZIP 100
> --ms 2005/01/07 */
> +

This seems to be basically what your patch changes, along with the
expiry addition. Neither of which should make any change in performance,
since you should normally not time commands out. Do you normally get
lots of errors or timeouts running that workload?

I don't see how your patch changes anything for a normally running
ide-floppy.

--
Jens Axboe



