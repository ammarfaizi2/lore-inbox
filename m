Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264132AbRFNWo6>; Thu, 14 Jun 2001 18:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264141AbRFNWot>; Thu, 14 Jun 2001 18:44:49 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:42064 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S264132AbRFNWod>;
	Thu, 14 Jun 2001 18:44:33 -0400
Date: Thu, 14 Jun 2001 16:42:29 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: threading question (results after thread pooling)
In-Reply-To: <E15Abem-00055Y-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0106141632200.3287-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have implemented thread pooling (with an environment variable
where I can give the number of threads to be created). Results:

1. Linux, no change in the times (not under 2.2.x or 2.4)

2. SGI/Solaris/OSF/1: times decrease when the number of threads matched
the number of processors available. The times were the same as my
previous version or couple of percents better when I exhaggerated the
number of threads to create, say, 128 threads on a 2 CPU.

3. The load on the machines has decreased considerably with the new
solution. I consider this to be the only positive impact I have seen from
this solution.

The solution is basically designed in the following way:

1. Threads are created and they wait on a condition with pthread_cond_wait
2. The main thread sets up the data (which are global) and then signals
that there is work to be done on the same condition variable. The first
thread to get awaken takes the work. the remaining threads keep waiting.
3. Go to 2. until there is work to distribute

I am now pretty much inclined to believe that it is either a) hardware
issue (someone mentioned that SPARCs and MIPSes handle things differently)
or b) Linux for some reason just cant give me what IRIX/Solaris can in
this particular case

Regretfully, the organization I work for prohibits me from releasing the
code I am talking about until the lawyers decide what to do with it. My
hope is to be able to release it for free to anyone interested since this
sequence alignment tool is used a lot :). This kind of defeats the purpose
of my question(s) since without the code it is difficult to talk.

Best regards,
Ognen Duzlevski

On Thu, 14 Jun 2001, Alan Cox wrote:

> > they are done. This should help it (and avoid the pthread_create,
> > pthread_exit). I will implement this and report my results if there is
> > interest.
>
> You should also check up the cache colouring. X86 boxes have relatively poor
> memory performance and most x86 chips have lousy behaviour when data bounces
> between processors or is driven out of cache

-- 
Ognen Duzlevski
Plant Biotechnology Institute
National Research Council of Canada
Bioinformatics team


