Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTG2QFd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTG2QFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:05:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:46798 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270040AbTG2QE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:04:58 -0400
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@muc.de>, Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>,
       lse-tech-admin@lists.sourceforge.net, Mala Anand <manand@us.ibm.com>,
       torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF5C1F4A86.410B2792-ON87256D72.0058341E@us.ibm.com>
From: Mala Anand <manand@us.ibm.com>
Date: Tue, 29 Jul 2003 11:04:24 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 6.0.1 [IBM]|June 10, 2003) at
 07/29/2003 10:04:26
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>Are the balances you're doing on wakeup global or node-local?
The test is not done on NUMA systems.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




                                                                                                                                               
                      "Martin J. Bligh"                                                                                                        
                      <mbligh@aracnet.com>             To:       Mala Anand/Austin/IBM@IBMUS, Erich Focht <efocht@hpce.nec.com>, linux-kernel  
                      Sent by:                          <linux-kernel@vger.kernel.org>, LSE <lse-tech@lists.sourceforge.net>                   
                      lse-tech-admin@lists.sour        cc:       Andi Kleen <ak@muc.de>, torvalds@osdl.org                                     
                      ceforge.net                      Subject:  Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case                   
                                                                                                                                               
                                                                                                                                               
                      07/29/2003 09:29 AM                                                                                                      
                                                                                                                                               
                                                                                                                                               




>>> If you want data supporting my assumptions: Ted Ts'o's talk at OLS
>>> shows the necessity to rebalance ASAP (even in try_to_wake_up).
>
>> If this is the patch I am thinking of, it was the (attached) one I sent
> them,
>> which did a light "push" rebalance at try_to_wake_up.  Calling
> load_balance
>> at try_to_wake_up seems very heavy-weight.  This patch only looks for an
> idle
>> cpu (within the same node) to wake up on before task activation, only if
> the
>> task_rq(p)->nr_running is too long.  So, yes, I do believe this can be
>> important, but I think it's only called for when we have an idle cpu.
>
> The patch that you sent to Rajan didn't yield any improvement on
> specjappserver so we did not include that  in the ols paper. What
> is described in the ols paper is "calling load-balance" from
> try-to-wake-up. Both calling load-balance from try-to-wakeup and
> the "light push" rebalance at try_to_wake_up are already done in
> Andrea's 0(1) scheduler patch.

Are the balances you're doing on wakeup global or node-local?

M.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech



