Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270795AbUJUPu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270795AbUJUPu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270723AbUJUPpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:45:42 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:1029 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S263778AbUJUPns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:43:48 -0400
Message-ID: <4177D93B.3030807@stud.feec.vutbr.cz>
Date: Thu, 21 Oct 2004 17:43:55 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu>
In-Reply-To: <20041021132717.GA29153@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------010807050002030502030003"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0031]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807050002030502030003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> 
>  - netconsole fixes from Michal Schmidt
> 

The #ifdef is not right. Patch attached.

Michal

--------------010807050002030502030003
Content-Type: text/x-patch;
 name="netconsole-ifdef.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netconsole-ifdef.diff"

--- linux-2.6.9-rc4-mm1-U9.1/drivers/net/netconsole.c	2004-10-21 17:14:22.000000000 +0200
+++ linux-2.6.9-rc4-mm1-U9.1-mich/drivers/net/netconsole.c	2004-10-21 17:15:09.000000000 +0200
@@ -74,7 +74,7 @@ static void write_msg(struct console *co
 		return;
 
 	local_irq_save(flags);
-#ifdef PREEMPT_REALTIME
+#ifdef CONFIG_PREEMPT_REALTIME
 	/*
 	 * A bit hairy. Netconsole uses mutexes (indirectly) and
 	 * thus must have interrupts enabled:

--------------010807050002030502030003--
