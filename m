Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSBOSdJ>; Fri, 15 Feb 2002 13:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSBOSc7>; Fri, 15 Feb 2002 13:32:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:24594 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290587AbSBOScr>; Fri, 15 Feb 2002 13:32:47 -0500
Date: Fri, 15 Feb 2002 15:23:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
In-Reply-To: <3C69A196.B7325DC2@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202151515020.23069-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Feb 2002, Andrew Morton wrote:

> Second version of this patch, incorporating Suparna's
> suggested simplification (the low-water mark was
> unnecessary).
> 
> This patch is working well here.  Hopefully it'll pop up
> in an rmap kernel soon.
> 
> Bill Irwin has been doing some fairly extensive tuning
> and testing of this.  Hopefully he'll come out with some
> numbers soon.
> 
> I include the original description...

It seems the real gain (in latency) is caused by the FIFO behaviour.

That is, removing this hunk (against __get_request_wait())

-               if (q->rq[rw].count < batch_requests)
+               if (q->rq[rw].count == 0)
                        schedule();

Would not make _much_ difference latency-wise. I'm I right or missing
something ?

Anyway, I would like to have the patch cleaned up for 2.4.19-pre (remove
the instrumentation stuff _and_ make it clear on the documentation that
READA requests are not being used in practice).

Thanks a lot for that, Andrew.


