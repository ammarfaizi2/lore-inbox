Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWEWRQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWEWRQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWEWRQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:16:36 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:64784 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S1750986AbWEWRQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:16:35 -0400
In-Reply-To: <1148403642.22855.12.camel@localhost.localdomain>
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OFCEBD2C92.B402353B-ONC1257177.005E2101-C1257177.005EEA9E@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Tue, 23 May 2006 19:10:30 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/23/2006
 07:10:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are only system timer and debug serial unit registered on
irq line 1.
Debug serial unit is used as the console !



                                                                           
             Steven Rostedt                                                
             <rostedt@goodmis.                                             
             org>                                                       To 
             Sent by:                  Yann.LEPROVOST@wavecom.fr           
             linux-kernel-owne                                          cc 
             r@vger.kernel.org         Daniel Walker <dwalker@mvista.com>, 
                                       linux-kernel@vger.kernel.org, Ingo  
                                       Molnar <mingo@elte.hu>, Thomas      
             23/05/2006 19:00          Gleixner <tglx@linutronix.de>       
                                                                   Subject 
                                       Re: Ingo's  realtime_preempt patch  
                                       causes kernel oops                  
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Tue, 2006-05-23 at 18:27 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> I forgot to say that I let SA_SHIRQ as the IRQ line is shared...
> It seems to work correctly...

What shares it?

Reason I ask, is that this irq is now running in true interrupt context,
and that on PREEMPT_RT the spin_locks are mutexes and can schedule. So
if another device is sharing this irq, then its interrupt handler will
be running in interrupt context, and if it grabs a spin_lock than is not
a raw_spinlock_t then you will have a crash.

This won't be a problem if you only turn on Hard irqs as threads and
don't do the PREEMPT_RT.

-- Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


