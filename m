Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUEEJzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUEEJzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 05:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUEEJzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 05:55:07 -0400
Received: from firewall.conet.cz ([213.175.54.250]:3265 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S264392AbUEEJy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 05:54:58 -0400
Date: Wed, 5 May 2004 11:54:06 +0200
From: Libor Vanek <libor@conet.cz>
To: Bart Samwel <bart@samwel.tk>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040505095406.GC5767@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki> <4097A94C.8060403@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4097A94C.8060403@samwel.tk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 04:31:40PM +0200, Bart Samwel wrote:
> Libor Vanek wrote:
> >I know that kernel threads work. My question was more like: "I'd
> > like to know, whether writing my module as kernel thread will make
> > it able to read/write files".
> [...]
> >>>I think there are reasons (speed, speed, speed...)  why some things
> >>> should be done kernel-space.
> 
> Using a kernel thread won't improve speed, because to do anything you 
> will have to context-switch to the thread. For the stuff you want to do 
> you are probably better off having a tiny kernel module to intercept the 
> events that you're interested in, notifying a userspace process to do 

OK - how can I "notify" userspace process? Signals are "weak" - I need to send some data (filename etc.) to process. One solution is "on this signal call this syscall and result of this syscall will be data you need" - but I'd prefer to handle this in one "action".

> the real work. Yes, it will be slower than in kernel space, but only 
> slightly. Especially if you use sendfile from the userspace process. And 
> it's also good to remember that Linux is optimized for running user 
> space processes as fast as possible. :)
> 
> --Bart
