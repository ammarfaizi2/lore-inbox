Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbVJRQXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbVJRQXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVJRQXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:23:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64508 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751002AbVJRQXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:23:34 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051018064259.GA21236@elte.hu>
References: <20051017160536.GA2107@elte.hu>
	 <Pine.LNX.4.10.10510171417220.24518-101000@godzilla.mvista.com>
	 <20051018064259.GA21236@elte.hu>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 09:23:30 -0700
Message-Id: <1129652611.13672.12.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 08:42 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I found this latency ~5 minutes after boot up, no load . It looks like 
> > vgacon_scroll() has a memset like operation which can grow.
> 
> do you have PRINTK_IGNORE_LOGLEVEL enabled? If yes then much of the 
> printk code will run with interrupts disabled - hence non-preemptable.  
> PRINTK_IGNORE_LOGLEVEL is a debugging feature for developers. I have 
> added an extra explanation to the Kconfig, see below.

I was just running a "make defconfig" and I enabled latency tracing .
PRINTK_IGNORE_LOGLEVEL defaults to off (doesn't it?), and I didn't make
any changes to it . Unless it get switched on by something else .. 

It looks like the logic might be reversed in release_console_sem() .

Daniel

