Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280710AbRKBOVw>; Fri, 2 Nov 2001 09:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280709AbRKBOVm>; Fri, 2 Nov 2001 09:21:42 -0500
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:60198 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S280711AbRKBOVX>; Fri, 2 Nov 2001 09:21:23 -0500
Date: Fri, 2 Nov 2001 07:20:36 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011102072036.D17792@watson.ibm.com>
In-Reply-To: <20011031151243.E1105@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0110311544330.1484-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.40.0110311544330.1484-100000@blue1.dev.mcafeelabs.com>; from Davide Libenzi on Wed, Oct 31, 2001 at 03:53:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Davide Libenzi <davidel@xmailserver.org> [20011031 18;53]:"
> On Wed, 31 Oct 2001, Mike Kravetz wrote:
> 
> > I'm going to try and merge your 'cache warmth' replacement for
> > PROC_CHANGE_PENALTY into the LSE MQ scheduler, as well as enable
> > the code to prevent task stealing during IPI delivery.  This
> > should still be significantly different than your design because
> > MQ will still attempt to make global decisions.  Results should
> > be interesting.
> 
> I'm currently evaluating different weights for that.
> Right now I'm using :
> 
>     if (p->cpu_jtime > jiffies)
>         weight += p->cpu_jtime - jiffies;
> 
> that might be too much.
> Solutions :
> 
> 1)
>     if (p->cpu_jtime > jiffies)
>         weight += (p->cpu_jtime - jiffies) >> 1;
> 
> 2)
>     int wtable[];
> 
>     if (p->cpu_jtime > jiffies)
>         weight += wtable[p->cpu_jtime - jiffies];
> 
> Speed will like 1).
> Other optimization is jiffies that is volatile and forces gcc to always
> reload it.
> 
> static inline int goodness(struct task_struct * p, struct mm_struct
> *this_mm, unsigned long jiff)
> 
> might be better, with jiffies taken out of the goodness loop.
> Mike I suggest you to use the LatSched patch to 1) know how really is
> performing the scheduler 2) understand if certain test gives certain
> results due wierd distributions.
> 

One more. Throughout our MQ evaluation, it was also true that 
the overall performance particularly for large thread counts was
very sensitive to the goodness function, that why a na_goodness_local 
was introduced.

-- Hubertus
