Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270011AbUJNJ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270011AbUJNJ13 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270013AbUJNJ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:27:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:47543 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270011AbUJNJ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:27:15 -0400
X-Authenticated: #4399952
Date: Thu, 14 Oct 2004 11:42:40 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014114240.5eae07e5@mango.fruits.de>
In-Reply-To: <20041014091953.GA21635@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014105711.654efc56@mango.fruits.de>
	<20041014091953.GA21635@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 11:19:53 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> In -U0 this is not possible because 'ps -C' does not handle kernel
> threads with a space in their name. So there you'd need some wacky thing
> like:
> 
>    chrt -f 60 -p `ps ax -o pid= -o comm= | grep "IRQ 1$" | cut -dI -f1`
>    chrt -f 60 -p `ps ax -o pid= -o comm= | grep "IRQ 8$" | cut -dI -f1`
> 
> (someone should fix procps - or does it intentionally break with
> whitespace command-strings?)

Hi,

thanks for the infos.

btw: i use:

chrt -f -p 99 `pidof "IRQ 5"`

for example (chrt commandline parsing is kinda braindead). It seems to work: 

~$ ps -cmL `pidof "IRQ 5"`
  PID   LWP CLS PRI TTY      STAT   TIME COMMAND
  110     - -     - ?        -      0:00 [IRQ 5]
    -   110 FF  139 -        S<     0:00 -

flo
