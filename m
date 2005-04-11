Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVDKQ6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVDKQ6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVDKQzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:55:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31474 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261859AbVDKQw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:52:57 -0400
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20050409044449.GA2857@elte.hu>
References: <1112991311.11000.37.camel@mindpipe>
	 <1112992701.26296.16.camel@dhcp153.mvista.com>
	 <20050409044449.GA2857@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113238370.30553.15.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 09:52:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 21:44, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I submitted a fix for this a while ago, I think ..
> > interruptible_sleep_on()'s are broken .. 
> 
> sleep_on() is a fundamentally broken interface, it only works on UP - 
> but there it _does_ rely on the behavior your patch removes. (i.e.  
> disabled interrupts until we hit schedule())
> 
> the PREEMPT_RT kernel makes the limitations of sleep_on() even more 
> apparent. The patch only removes the warning, it doesnt remove the race.  
> To remove the race, sleep_on() usage should be converted to something 
> else. (e.g. one of the wait_event() variants)

I know they aren't suppose to be used any more. However, there are 100+
of these calls in the kernel right now ..

Daniel

