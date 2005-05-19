Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVESQJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVESQJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVESQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:09:04 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:26842 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262554AbVESQIm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:08:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mwdXhue1HxV9WYgSMoOFqSKigmxbCiQJY4qhWaatsMHuIE0pY40CzglMdrZijwLBq2dIfOY9v5Scp3y9wmAsjqrxZQAP/qS81ceLrOfemd3omBkaxEU+cFK8ZQNhsNIm4ezZ8DsPL2r7DpHZTpKxuapy79B82ZnN6pRRvv1pJeA=
Message-ID: <377362e105051909085cea3357@mail.gmail.com>
Date: Fri, 20 May 2005 01:08:38 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505192123.24784.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <377362e10505181142252ec930@mail.gmail.com>
	 <377362e105051902467cae323e@mail.gmail.com>
	 <377362e105051903462a4d8949@mail.gmail.com>
	 <200505192123.24784.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several tests, I found the default value is the best also to me.
 Thanks Con for nice advises and hints on scheduler.   It's fun to
see/modify kernel source files.  But I think kernel isn't my higher
priority.

regards,

On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Thu, 19 May 2005 08:46 pm, Tetsuji "Maverick" Rai wrote:
> > I've done a temporary minor hacking, which tells kernel only the half
> > value of nice in all processes.  Actually idle percentage was lowered,
> > but the response of the main application became slower (as a matter of
> > course.)
> >
> > I'm not sure which is better..if possible I want to take advantages of
> > each one :)   Am I expecting too much?
> 
> Yes you are. Hyperthreading (currently depending on workload) only gives you
> on average 15-25% more cpu with multiple threads. You can't get something for
> nothing. Either the nice 0 task runs slower because a low priority task is
> bound to the sibling, or it runs at the same speed and the low priority task
> runs for less. If you want the nice 19 task to use more cpu run it at nice 0
> - because this is effectively what you are trying to do. If you want more cpu
> you need extra true physical cpus, not logical cores.
> 
> Your code does not do what you think it is doing either. If you want to change
> the bias between nice levels across logical cores search the code for where
> the value of sd->per_cpu_gain is set. It is currently set to 25% and you want
> to increase it (although as I said you will derive no real world benefit as
> your nice 0 task will just slow down).
> 
> Cheers,
> Con
> 


-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
