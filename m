Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbVKIRYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbVKIRYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbVKIRYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:24:48 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:33764 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030558AbVKIRYp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:24:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c0hlND2YFM7hadED3AUSkDkLssEIRUNGtFkZTcAg4DklkwuXCLlwVIeU6cxKvf6hGv/nhEPH9HkcLEUIChzMUi97BAAaPgIDEsHYqSYDMV28MOvM+QEtjOwi1Snj4IQVV0paZIwo2b0jHPVm3Zm1hjnKdppnXEbdWqx9xoHA2oc=
Message-ID: <7d40d7190511090924k6ef493dbn@mail.gmail.com>
Date: Wed, 9 Nov 2005 18:24:44 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Stopping Kernel Threads at module unload time
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511091158350.10894@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190511090749j3de0e473x@mail.gmail.com>
	 <Pine.LNX.4.61.0511091110190.10303@chaos.analogic.com>
	 <7d40d7190511090856x24fd68f5g@mail.gmail.com>
	 <Pine.LNX.4.61.0511091158350.10894@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Now, if I call kthread_stop() in module unload time, does that code
> > run in user process context just like system calls do? That is
> > important, because if it cannot sleep, it would deadlock.
> >
>
> Not relevent. You have apparently made up your mind that you
> need to do it "your" way. Fine.

No, no, that is not MY way. That is the 2.6 way.
 (see http://lwn.net/Articles/64444/).

With the old API (kernel_thread) there was no way (at least, direct
way) to bind a thread to a cpu, which i actually need. And this is not
MY own approach , it is used throught the kernel:

* migration thread at sched.c:
           http://lxr.linux.no/source/kernel/sched.c#L4196

* ksoftirqd thread at softirq.c:
           http://lxr.linux.no/source/kernel/softirq.c#L350

* worker thread used in workqueues:
           http://lxr.linux.no/source/kernel/workqueue.c#L182

...and so on

All these threads are standard and well debugged, and all use the API
which I was talking about. Of course, as they are included in the
official kernel sources, none of them is stopped at module unload
time.

Thus, all I want to know is why kthread_stop() cant be called at
module unload time, if the cleanup code can sleep and if there is a
workaround for that.

I hope my questions are clearer now.
Thanks for your help

Aritz
