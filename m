Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263401AbVGARMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbVGARMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 13:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbVGARMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 13:12:33 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:15142 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263406AbVGARI7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 13:08:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TRqzy4hjDdYmEpgAnvO4r8YZhW4zOtSlBR7w81OjYvkZhtCMb55F50V8VhX3+zGmmRjjpD1NyQOn28Isln0MExnQBLY7dymF68UN9BzBUtqeMuWJcZpMHWyygi3a+UoV+4FaHYDcAbaR6iH8dR9s58U+RDL1RxsXXtl5l7CMLVM=
Message-ID: <58cb370e050701100839b01186@mail.gmail.com>
Date: Fri, 1 Jul 2005 19:08:58 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Manfred.Scherer.Mhm@t-online.de" <Manfred.Scherer.Mhm@t-online.de>
Subject: Re: Re: PATCH for ide_floppy
Cc: Jens Axboe <axboe@suse.de>, paul@paulbristow.net,
       linux-kernel@vger.kernel.org, manfred.scherer@siemens.com
In-Reply-To: <1DoOqm-0TquC80@fwd16.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1DoNSU-0kLq880@fwd18.aul.t-online.de>
	 <20050701161534.GJ2243@suse.de> <1DoOqm-0TquC80@fwd16.aul.t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
