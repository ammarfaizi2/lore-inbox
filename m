Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272239AbRH3O1T>; Thu, 30 Aug 2001 10:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272235AbRH3O1K>; Thu, 30 Aug 2001 10:27:10 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8188 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272239AbRH3O04>;
	Thu, 30 Aug 2001 10:26:56 -0400
Importance: Normal
Subject: Re: softirq & schedule documentation
To: tyrius@nwlink.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFA942F6B2.4A7993BC-ON85256AB8.004DB874@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Thu, 30 Aug 2001 10:27:02 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/30/2001 10:27:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



While porting our MultiQueue scheduler to 2.4.6 (on x86) and above, we had
faced some problems with ksoftirqd too but it turned out to be something
related to what our code was doing rather than ksoftirqd (an attempt was
being made to delete a task from the runqueue when it wasn't on it).

But while debugging the error, we found that the problem was exacerbated by
ksoftirqd trying to call schedule() before all CPU's had a chance to come
up.A few  printk's in the spawn_ksoftirqd()/ksoftirqd() code temporarily
"solved" the problem by introducing a slight delay. You could try the same.
I don't remember the exact code locations in softirq.c that we put the
printks in but it was in the initializing parts.

Are you trying to boot an SMP ?

Shailabh




Hi,
 I'm in the process of trying to track down a problem with the sparc32 port

not booting and believe that the problem lies somewhere in either the
scheduling algorithm or ksoftirqd. Schedule is called by spawn_ksoftirqd,
which then proceeds to loop infinately. I know that, eventually, prev =
current = next = ksoftirqd. current->need_resched gets set to 0 in the
move_rr_back block of schedule(),but at some point in recalculate: it gets
set back to 1.

Is there any sort of documentation on the softirq stuff and the scheduling
algorithm out there that is relevant to 2.4.9? It seems that the only stuff
I've managed to find is based off the 2.2.x kernels.

Thanks,

Jonathan Zimmerman
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



