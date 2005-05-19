Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVESLVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVESLVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 07:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVESLVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 07:21:20 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:40644 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262263AbVESLVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 07:21:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Date: Thu, 19 May 2005 21:23:24 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <377362e10505181142252ec930@mail.gmail.com> <377362e105051902467cae323e@mail.gmail.com> <377362e105051903462a4d8949@mail.gmail.com>
In-Reply-To: <377362e105051903462a4d8949@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505192123.24784.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 08:46 pm, Tetsuji "Maverick" Rai wrote:
> I've done a temporary minor hacking, which tells kernel only the half
> value of nice in all processes.  Actually idle percentage was lowered,
> but the response of the main application became slower (as a matter of
> course.)
>
> I'm not sure which is better..if possible I want to take advantages of
> each one :)   Am I expecting too much?

Yes you are. Hyperthreading (currently depending on workload) only gives you 
on average 15-25% more cpu with multiple threads. You can't get something for 
nothing. Either the nice 0 task runs slower because a low priority task is 
bound to the sibling, or it runs at the same speed and the low priority task 
runs for less. If you want the nice 19 task to use more cpu run it at nice 0 
- because this is effectively what you are trying to do. If you want more cpu 
you need extra true physical cpus, not logical cores.

Your code does not do what you think it is doing either. If you want to change 
the bias between nice levels across logical cores search the code for where 
the value of sd->per_cpu_gain is set. It is currently set to 25% and you want 
to increase it (although as I said you will derive no real world benefit as 
your nice 0 task will just slow down).

Cheers,
Con
