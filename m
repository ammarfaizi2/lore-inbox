Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWGROat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWGROat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWGROat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:30:49 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:57535
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932226AbWGROat
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:30:49 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
Date: Tue, 18 Jul 2006 16:29:27 +0200
User-Agent: KMail/1.9.1
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de> <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
In-Reply-To: <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607181629.27933.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 July 2006 21:57, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 17 Jul 2006 20:53:30 +0200, Andreas Mohr said:
> > Hi all,
> > 
> 
> >         for (i = 0; i < 4; i++) {
> >                 j = INDEX(i);
> >                 do {
> 
> >                         if (j < (INDEX(i)) && i < 3)
> >                                 list = varray[i + 1]->vec + (INDEX(i + 1));
> >                         goto found;
> >                 } while (j != (INDEX(i)));
> >         }
> > found:
> 
> > Excuse me, but why do we have a while loop here if the last instruction in
> > the while loop is a straight "goto found"?
> 
> Consider if we take the 'goto found' when i==1.  We leave not only the do/while
> but also the for loop.  A 'continue' instead would leave the do/while and then
> drive the i==2 and subsequent 'for' iterations....

No, it would not. A 'continue' instead of the 'goto found' would
compile to nothing.
Try the following example with and without the 'continue'.

#include <stdio.h>
int main(void)
{
        int i, j;
        for (i = 0; i < 2; i++) {
                j = 0;
                do {
                        printf("i==%d, j==%d\n", i, j);
                        j++;
                        /* goto found; */
                        continue;
                } while (j < 2);
        }
}


Continue is equal to:

LOOP {
	/* foo */
	goto continue; /* == continue */
	/* foo */
continue:
} LOOP

-- 
Greetings Michael.
