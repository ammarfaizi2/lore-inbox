Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268633AbUJPRL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268633AbUJPRL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268799AbUJPRL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:11:26 -0400
Received: from relay.pair.com ([209.68.1.20]:64015 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268633AbUJPRLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:11:24 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <4171563B.6030503@cybsft.com>
Date: Sat, 16 Oct 2004 12:11:23 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
In-Reply-To: <20041016153344.GA16766@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -U4 PREEMPT_REALTIME patch:
> 
>    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4
> 
> this is a fixes-only release, and it is still experimental code.
> 

This fixes a compile problem on UP with CONFIG_LATENCY_TRACE enabled.

--- linux-2.6.9-rc4-mm1/kernel/latency.c.orig   2004-10-16 
12:02:39.539487008 -0500
+++ linux-2.6.9-rc4-mm1/kernel/latency.c        2004-10-16 
12:03:44.536344303 -0500
@@ -602,7 +602,8 @@
  /*
   * On UP, NMI tracing is quite simple:
   */
-void notrace nmi_trace(unsigned long eip, unsigned long parent_eip)
+void notrace nmi_trace(unsigned long eip, unsigned long parent_eip,
+                       unsigned long flags)
  {
         __trace(eip, parent_eip);
  }
