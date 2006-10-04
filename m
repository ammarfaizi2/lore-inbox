Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWJDAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWJDAar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbWJDAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:30:47 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:35442 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030536AbWJDAaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:30:46 -0400
Subject: Re: hrtimers bug message on 2.6.18-rt4
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: john stultz <johnstul@us.ibm.com>
Cc: Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1159811130.5873.5.camel@localhost.localdomain>
References: <45214EDC.6060706@redhat.com>
	 <1159811130.5873.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 17:30:45 -0700
Message-Id: <1159921845.1979.9.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 10:45 -0700, john stultz wrote:
> On Mon, 2006-10-02 at 12:39 -0500, Clark Williams wrote:
> > I was debugging a PI mutex stress test when I got the following message
> > on my Athlon64x2 (running 2.6.18-rt4):
> > 
> > BUG: time warp detected!
> > prev > now, 101878c199393108 > 101878c081eaca2b:
> > = 4685981405 delta, on CPU#0
> >  [<c0104c3c>] show_trace+0x2c/0x30
> >  [<c0104dcb>] dump_stack+0x2b/0x30
> >  [<c012ec89>] getnstimeofday+0x249/0x270
> 
> Could you send me your dmesg and .config?
> 


This is likely a different issue but, I can generate this messages, like
the following,

BUG: time warp detected!
prev > now, 1018dd8f5e9e5c1f > 0000001748787c3e:
= 1159920411885297633 delta, on CPU#1
 [<c010473b>] show_trace_log_lvl+0x1eb/0x1f0
 [<c0104efb>] show_trace+0x1b/0x20
 [<c0105004>] dump_stack+0x24/0x30
 [<c012b030>] do_gettimeofday+0x1a0/0x1d0
 [<c0125024>] sys_gettimeofday+0x24/0x90
 [<c0103567>] syscall_call+0x7/0xb
 [<b7f9b410>] 0xb7f9b410


With ltpstess . It has a settimeofday test which can trigger it. It gets
called with wild values.

Daniel

