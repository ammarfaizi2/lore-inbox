Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSGWRFo>; Tue, 23 Jul 2002 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318188AbSGWRFl>; Tue, 23 Jul 2002 13:05:41 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:33797 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S318182AbSGWRFV>; Tue, 23 Jul 2002 13:05:21 -0400
Date: Tue, 23 Jul 2002 11:08:16 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Francois Romieu <romieu@cogenit.fr>
Cc: support <support@promise.com.tw>, Hank <hanky@promise.com.tw>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Message-ID: <20020723110816.A5009@mail.harddata.com>
References: <01b801c22f0b$c02cc360$47cba8c0@promise.com.tw> <01ee01c2312e$22976900$47cba8c0@promise.com.tw> <20020722083548.A27973@fafner.intra.cogenit.fr> <000d01c231e5$10f8ae40$47cba8c0@promise.com.tw> <20020723091915.A29237@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020723091915.A29237@fafner.intra.cogenit.fr>; from romieu@cogenit.fr on Tue, Jul 23, 2002 at 09:19:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 09:19:15AM +0200, Francois Romieu wrote:
> support <support@promise.com.tw> :
> > We think there is no problems,
> 
> After the change, the code is:
> 
> if (speed == XFER_UDMA_2)
>         OUT_BYTE((thold + adj), indexreg);              <- not executed
>         OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);   <- executed, damn it !

I have one more question.  Is it really immaterial on the line above in
which order 'datareg' occurences are used?  Regardless of what
'OUT_BYTE' is now or may become in the future and how these macro are
used?  It looks to me that we are trying to read some byte from
'datareg', clear a bit in it and write it back but looks can be
deceptive.  It may turn out that this does or does not work on a
particular compiler whim.

Maybe it is ok now but beeing explicit in a macro definition does
not really cost anything and may save some future grief.

   Michal
