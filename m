Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVASGxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVASGxR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVASGxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:53:17 -0500
Received: from mail.joq.us ([67.65.12.105]:28847 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261605AbVASGxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:53:08 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 19 Jan 2005 00:54:41 -0600
In-Reply-To: <41ED08AB.5060308@kolivas.org> (Con Kolivas's message of "Wed,
 19 Jan 2005 00:01:31 +1100")
Message-ID: <87is5tx61a.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> This patch for 2.6.11-rc1 provides a method of providing real time
> scheduling to unprivileged users which increasingly is desired for
> multimedia workloads.

I ran some jack_test3.2 runs with this, using all the default
settings.  The results of three runs differ quite significantly for no
obvious reason.  I can't figure out why the DSP load should vary so
much.  

These may be bogus results.  It looks like a libjack bug sometimes
causes clients to crash when deactivating.  I will investigate more
tomorrow, and come up with a fix.

For comparison, I also made a couple of runs using the realtime-lsm to
grant SCHED_FIFO privileges.  There was some variablility, but nowhere
near as much (and no crashes).  I used schedtool to verify that the
jackd threads actually have the expected scheduler type.

============================================
Unprivileged, realtime threads are SCHED_ISO
============================================

*** Terminated Tue Jan 18 23:54:55 CST 2005 ***
************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    3)          (   14)         (    2)        
XRUN Count  . . . . . . . . . :    10               42               3         
Delay Count (>spare time) . . :     1                0               0         
Delay Count (>1000 usecs) . . :     0                0               0         
Delay Maximum . . . . . . . . : 307419   usecs    6492   usecs   19339   usecs 
Cycle Maximum . . . . . . . . :   858   usecs      866   usecs     860   usecs 
Average DSP Load. . . . . . . :    37.3 %           14.5 %          37.7 %     
Average CPU System Load . . . :    10.2 %            4.5 %          10.0 %     
Average CPU User Load . . . . :    26.6 %           11.4 %          23.8 %     
Average CPU Nice Load . . . . :     0.0 %            0.0 %           0.0 %     
Average CPU I/O Wait Load . . :     2.0 %            0.7 %           0.2 %     
Average CPU IRQ Load  . . . . :     0.8 %            0.7 %           0.7 %     
Average CPU Soft-IRQ Load . . :     0.0 %            0.0 %           0.0 %     
Average Interrupt Rate  . . . :  1730.3 /sec      1695.5 /sec     1694.8 /sec  
Average Context-Switch Rate . : 11523.1 /sec      6151.1 /sec    11672.2 /sec  
*********************************************


==================================================
With CAP_SYS_NICE, realtime threads are SCHED_FIFO
==================================================

*** Terminated Tue Jan 18 23:41:42 CST 2005 ***
************* SUMMARY RESULT ****************
Total seconds ran . . . . . . :   300
Number of clients . . . . . . :    20
Ports per client  . . . . . . :     4
Frames per buffer . . . . . . :    64
*********************************************
Timeout Count . . . . . . . . :(    0)          (    0)        
XRUN Count  . . . . . . . . . :     0                0         
Delay Count (>spare time) . . :     0                0         
Delay Count (>1000 usecs) . . :     0                0         
Delay Maximum . . . . . . . . :   331   usecs      201   usecs 
Cycle Maximum . . . . . . . . :   882   usecs     1017   usecs 
Average DSP Load. . . . . . . :    40.7 %           41.7 %     
Average CPU System Load . . . :    11.1 %           10.9 %     
Average CPU User Load . . . . :    26.7 %           27.7 %     
Average CPU Nice Load . . . . :     0.0 %            0.0 %     
Average CPU I/O Wait Load . . :     0.6 %            1.0 %     
Average CPU IRQ Load  . . . . :     0.7 %            0.7 %     
Average CPU Soft-IRQ Load . . :     0.0 %            0.0 %     
Average Interrupt Rate  . . . :  1708.0 /sec      1697.1 /sec  
Average Context-Switch Rate . : 13297.0 /sec     13314.8 /sec  
*********************************************

-- 
  joq
