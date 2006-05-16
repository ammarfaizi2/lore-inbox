Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWEPTtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWEPTtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWEPTtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:49:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:14220 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWEPTtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:49:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mAqtPNSU4dgCVh6FhaBjmq21MuPLeO09DEIlTRbLPWvaVhtimUnZFosNke3HQPPdaxm9K6v4R254k/B2SyRTiFEJ4UjM2INc0t2XL62CyHF+WoztmcYHdqeJvburShNzUVmxKzAUoAEa9z79VuyRYqYKs4eur6VwC9vOplCZdxY=
Message-ID: <9a8748490605161249t33e6343bj4a4610d0b2958f03@mail.gmail.com>
Date: Tue, 16 May 2006 21:49:07 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: fritzsch <fritzsch@cip.physik.uni-muenchen.de>
Subject: Re: running only 1 process on 1 cpu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147807902.6647.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147807902.6647.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/06, fritzsch <fritzsch@cip.physik.uni-muenchen.de> wrote:
> Hallo,
> i have one process, which i want to run on a cpu (> CPU0). The special
> thing here is, that this process is very time critical and  should NOT
> be interrupted by anything (cpusets/cpus_allowed would not be enough).
> (the process is not doing any system calls and is communicating to the
> world by shared memory).
> so i wanted to run the process on a CPU1, when all irqs are disabled and
> so the process could not be interrupted.
>
>
> I tried very simple to
>
> (1) migrate all processes to CPU0 by cpu_set_allowed
> (2) gave my process (running on CPU1) the highest priority
> (3) run schedule and make sure that the irqs are disables
> (disable_irqs())
> ...
>

Some ideas :

- Play with CPU affinity : "man sched_setaffinity" / "man sched_getaffinity" [1]
- Try a RealTime patched kernel (Ingo's -rt patchset) and set the
processes nice level to least nice & RT priority to the max [2]
- Implement the code as a kernel module if it really is that time critical


[1] http://www.linuxjournal.com/article/6799
[2] http://www.captain.at/howto-linux-real-time-patch.php

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
