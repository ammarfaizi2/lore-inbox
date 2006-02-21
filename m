Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932788AbWBUVPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbWBUVPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWBUVPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:15:50 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:24996 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932788AbWBUVPt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:15:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CJDnWHKmTytNbf0G6SztpN9kLdixnS2mO+piF9/S1ZCcEZFg9jrTLhyrlEVvCHtMfHz7PxMYSgs52rCG6Qd9hj+Gp4srCHD1RoWRfu9z7NzgU89ac119sXsc4yXg/30wuUNWsNvkndUOW54EJGfUM+L63cmZKifIBcmqzTz8kJE=
Message-ID: <6bffcb0e0602211315n4ea36c06q@mail.gmail.com>
Date: Tue, 21 Feb 2006 22:15:46 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.15-rt17
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Esben Nielsen" <simlo@phys.au.dk>,
       "Steven Rostedt" <rostedt@goodmis.org>
In-Reply-To: <1140554250.2480.1042.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221155548.GA30146@elte.hu>
	 <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
	 <6bffcb0e0602211053y143d9049g@mail.gmail.com>
	 <1140554250.2480.1042.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/02/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> The stack maximum messages are harmless. They just report a new
> watermark high quite verbose. You can turn them off by disabling
> DEBUG_STACKOVERFLOW.

Sorry, I forgot about this.

>
> skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx
> WARNING: softirq-tasklet/8 changed soft IRQ-flags.
>  [<c0103b33>] dump_stack+0x1b/0x1f (20)
>  [<c0134035>] illegal_API_call+0x41/0x46 (20)
>  [<c0134084>] local_irq_disable+0x1d/0x1f (8)
>  [<f8839bf3>] skge_extirq+0x117/0x138 [skge] (32)
>  [<c0120a73>] __tasklet_action+0xb8/0xfd (28)
>  [<c0120afc>] tasklet_action+0x44/0x4e (28)
>  [<c0120ce8>] ksoftirqd+0x10f/0x19e (32)
>  [<c012dfa6>] kthread+0x7b/0xa9 (36)
>  [<c01010dd>] kernel_thread_helper+0x5/0xb (1037991964)
>
> This one is interesting. It brought my attention to that piece of code
> which is a long standing problem on one of my boxen anyway. Patch
> attached.
>
>         tglx
>

Thanks, problem solved.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
