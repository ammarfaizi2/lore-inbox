Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVGDJmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVGDJmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 05:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVGDJmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 05:42:36 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:39647 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261599AbVGDJmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:42:32 -0400
MIME-Version: 1.0
In-Reply-To: <58cb370e050701100839b01186@mail.gmail.com>
References: <1DoNSU-0kLq880@fwd18.aul.t-online.de> <20050701161534.GJ2243@suse.de> <1DoOqm-0TquC80@fwd16.aul.t-online.de> <58cb370e050701100839b01186@mail.gmail.com>
Date: Mon,  4 Jul 2005 11:41:49 +0200
To: bzolnier@gmail.com, axboe@suse.de
X-UMS: email
X-Mailer: TOI Kommunikationscenter V5-1
Subject: Re: Re: Re: PATCH for ide_floppy
Cc: paul@paulbristow.net, linux-kernel@vger.kernel.org,
       manfred.scherer@siemens.com
From: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1DpNSX-1jK1Sa0@fwd29.aul.t-online.de>
X-ID: rfh2GgZCwezXc+FU3quCGp9CImyNhpvKSJKY7WDk1RNqHG077o1ckJ@t-dialin.net
X-TOI-MSGID: 6e6d26f2-f0a3-4233-a06f-762b1b54d9b5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, 
#define IDEFLOPPY_TICKS_DELAY  HZ/20
seems to be the solution.

when I've tested some values for IDEFLOPPY_TICKS_DELAY in December 2004,
I cannot found the best value for this. The Kernel version was 2.6.8
from the SuSE9.2 distribution.

I take a look in ide-cd.c and found there the function
cdrom_timer_expiry as
a possibility to handle timeout issues smoother. I tried this function
as 
idefloppy_timer_expiry in ide-floppy.c in combination with
IDEFLOPPY_TICKS_DELAY  60
as a best result for all cases. It seems to reach out to change
IDEFLOPPY_TICKS_DELAY
as suggested from you, idefloppy_timer_expiry is not really necessary.  


-----Original Message-----
Date: Fri,  1 Jul 2005 19:08:58 +0200
Subject: Re: Re: PATCH for ide_floppy
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>

On 7/1/05, Manfred.Scherer.Mhm@t-online.de
<Manfred.Scherer.Mhm@t-online.de> wrote:
> it's not really a performance issue but more a timeout issue.
> 'IDEFLOPPY_TICKS_DELAY  60' avoids error messages in /var/log/messages
> like 'reset ide ...'.
> Without the idefloppy_timer_expiry the data transfer to the ide-floppy
> is pending a long time between some transfer of data. The floppy LED
> indicated this too.
> With kernel 2.4.x I've never had this problem.

This seems related to 2.4 -> 2.6 HZ change.

> > @@ -317,7 +324,13 @@
> >         unsigned long flags;
> >  } idefloppy_floppy_t;
> >
> > +#if 0
> >  #define IDEFLOPPY_TICKS_DELAY  3       /* default delay for ZIP 100
> */
> > +#define IDEFLOPPY_TICKS_DELAY  6       /* default delay for ZIP 100
> > --ms 2005/01/01 */
> > +#define IDEFLOPPY_TICKS_DELAY  12      /* default delay for ZIP 100
> > --ms 2005/01/01 */
> > +#endif
> > +#define IDEFLOPPY_TICKS_DELAY  60      /* default delay for ZIP 100
> > --ms 2005/01/07 */
> > +

"ticks" delay should be expressed using HZ

#define IDEFLOPPY_TICKS_DELAY  HZ/20

for 50msec delay (N.B. the comment in the code about default delay
being 50msec also seems wrong - it was more like ~33msec in 2.4)

Could you please test if this fixes your problems?

Bartlomiej


