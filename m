Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135389AbRDMDA6>; Thu, 12 Apr 2001 23:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135390AbRDMDAs>; Thu, 12 Apr 2001 23:00:48 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:1450 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135389AbRDMDAe>; Thu, 12 Apr 2001 23:00:34 -0400
Message-ID: <3AD66B62.23620639@mvista.com>
Date: Thu, 12 Apr 2001 19:58:42 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
In-Reply-To: <Pine.LNX.4.10.10104121616070.4564-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> On Fri, 13 Apr 2001, Alan Cox wrote:
> 
> > > Okay but what will be used for a base for hardware that has critical
> > > timing issues due to the rules of the hardware?
> >
> > > #define WAIT_MIN_SLEEP  (2*HZ/100)      /* 20msec - minimum sleep time */
> > >
> > > Give me something for HZ or a rule for getting a known base so I can have
> > > your storage work and not corrupt.
> >
> >
> > The same values would be valid with add_timer and friends regardless. Its just
> > that people who do
> >
> >       while(time_before(jiffies, started+DELAY))
> >       {
> >               if(poll_foo())
> >                       break;
> >       }
> >
> > would need to either use add_timer or we could implement get_jiffies()

Actually we could do the same thing they did for errno, i.e.

#define jiffies get_jiffies()
extern unsigned get_jiffies(void);

> 
> Okay regardless of the call what is it going to be or do we just random
> and go oh-crap data!?!?
> 
> Since HZ!==100 of all archs that have ATA/ATAPI support, it is a mircale
> that FS corruption and system death is not more rampant, except for the
> fact that hardware is quick by a factor of 10+ so that 1000 does not quite
> do as much harm but the associated mean of HZ changes and that is a
> problem with slower hardware.

No, not really.  HZ still defines the units of jiffies and most all the
timing is still related to it.  Its just that interrupts are only "set
up" when a "real" time event is due.

George
