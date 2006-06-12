Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWFLLG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWFLLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWFLLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:06:56 -0400
Received: from smtp2.versatel.nl ([62.58.50.89]:23685 "EHLO smtp2.versatel.nl")
	by vger.kernel.org with ESMTP id S1751859AbWFLLGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:06:55 -0400
Message-ID: <20060612110636.22459.qmail@www.wolff-online.nl>
References: <20060612095008.21733.qmail@www.wolff-online.nl>
            <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org>
In-Reply-To: <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org>
From: Carl@www.wolff-online.nl, Wolff@www.wolff-online.nl
To: Felix Oxley <lkml@oxley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Good performance (hard realtime ??) on 2.6.16 patched with
  patch-2.6.16-rt29 from Ingo Molnar
Date: Mon, 12 Jun 2006 13:06:36 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley writes: 

> Could you explain to me, in nice easy steps, how you got the  measurement?
1) for details see: http://tapas.affenbande.org/?page_id=6. 

2) Sending box and sending process
* periodically sends udp message using broadcast adress 192.168.2.255
* this process at RT priority FIFO (using chrt tool)
* put IRQ of network card to RT 99 FIFO prio
* box is idle (to create sort of 'stable') reference timing 

3) receiving box
* blocking read on udp socket
* put to RT FIFO 99 (chrt tool)
* process cannot be swapped out (mlockall call)
* while [1] do make -j100 && make clean; done;
* put softiqr-net-rx to RT FIFO 99 (using chrt)
* watchdog/0 not RT (i'm not sure this is mandatory)
* put IRQ of network card to RT FIFO prio 99
* Time measurement the cpu clock using gettimeofday calls 

> Specifically what triggered the 'start' of your time slice?
on sending box: usleep with 20000 interval (20 millisecond)
on receiving box: blocking read on udp socket 

> BTW, where you using hi resolution timers?
No, only usleep (maye it uses highres timers in the libs/kernel) 

> You say the max latency was 512usecs. What were the mean and mode?
Not measured... 

> (Regarding Hard Real Time, my understanding is that that depends on a  
> _guarantee_ that the system will always be able to produce the  'result' 
> within the required interval. Ingo's -rt patches may give  exceedingly 
> good responsiveness but they offer no guarantees, so they  cannot be 
> considered Hard Real Time)
Correct. In my case the repsonsiveness is acceptable in a real time control 
system where sporadic deadline misses are acceptable. 

Thanks
Carl. 

