Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVH1HFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVH1HFp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 03:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVH1HFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 03:05:45 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:14233 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbVH1HFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 03:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tnU3/PVV9HISIjck6L2C3MzLLEmGDCbUV30S+hcyMruh0tSCX53PnKpH9dMQ8XdGixdC0XrfyEc5KzeikmYZfyAAhQhH9HOoTJUuZqhklV8EOlVPF7e6JgVy2lvH/RCjvW/0Be9fpb3CW5H1Vbloj3mWTERQ1t4VapRImQZM3C0=
Message-ID: <1e33f571050828000537648e5b@mail.gmail.com>
Date: Sun, 28 Aug 2005 12:35:42 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: "Sat." <walking.to.remember@gmail.com>
Subject: Re: when or where can the case occur in "linux kernel development " about "kernel preemption"?
Cc: Christopher Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <6b5347dc050827085727df49c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6b5347dc05082609206ff7a305@mail.gmail.com>
	 <430F45F8.8020505@nortel.com>
	 <6b5347dc050827085727df49c8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/05, Sat. <walking.to.remember@gmail.com> wrote:
> 2005/8/27, Christopher Friesen <cfriesen@nortel.com>:
> > Sat. wrote:
> > > the case about kernel preemption as follow :
> > >
> > > the book said "when a process that has a higher priority than the
> > > currenty running process is awakened ".
> > >
> > > but I can think about when such case can occur , could you give me an example ?
> >
> > There may be others, but one common case is when a hardware interrupt
> > causes the higher priority process to become runnable.  Some examples of
> > this would be a network packet arriving, or the expiry of a hardware timer.
> >
> > Chris
> >
> 
> unfortunately, I cannot agree with you , normally ,when the kernel
> runs in interrupt context , the schedule() should not be invoked
> ------my views .
> 

Its not actually the interrupt handler which calls the schedule()
function, rather interrupt handler just perform the minimal task, like
copying the data from network card buffer to kernel buffer in case of
packet arriving on system. Its the other function which actually
interrut handler schedules for later invocation and this later
invocation is done in process context and so the function scheduled
for later invocation can wake the waiting processes and can call
schedule() function if needed.

I hope I am not wrong ;-)
-Gaurav

> then,could anyone  give me a definite example about network like above
> or anything else to eluminate  this , ok?
> 
> thanks !
> 
> --
> Sat.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
