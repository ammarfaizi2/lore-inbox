Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130322AbQK3Qz5>; Thu, 30 Nov 2000 11:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130380AbQK3Qzr>; Thu, 30 Nov 2000 11:55:47 -0500
Received: from uu194-7-68-2.unknown.uunet.be ([194.7.68.2]:28408 "EHLO
        bartok.iverlek.kotnet.org") by vger.kernel.org with ESMTP
        id <S130322AbQK3Qpc>; Thu, 30 Nov 2000 11:45:32 -0500
Date: Thu, 30 Nov 2000 17:11:37 +0100
From: Arnaud Installe <ainstalle@filepool.com>
To: Ray Bryant <raybry@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high load & poor interactivity on fast thread creation
Message-ID: <20001130171137.A1851@bartok.filepool.com>
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org> <3A266895.F522A0E2@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A266895.F522A0E2@austin.ibm.com>; from raybry@austin.ibm.com on Thu, Nov 30, 2000 at 08:47:49AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 08:47:49AM -0600, Ray Bryant wrote:
> The IBM implementations of the Java language use native threads --
> the result is that every time you do a Java thread creation, you
> end up with a new cloned process.  Now this should be pretty fast,

Well, I think the problem is that it is *too* fast.  :-/  What I think
happens is that a lot of threads get created at the same time, and they
all run a bit of initialization code.  This way a lot of processes are in
the running state, so that the load average gets *very* high, which makes
the system very unresponsive.

Could this be correct ?  Also, I haven't seen this happen with NT.  Could
it be that Java on NT uses user-mode threading and creates threads much
more slowly, resulting in a lower load ?

> so I am surprised that it stalls like that.  It is possible this
> is a scheduler effect.  Do you have a program example you can
> share with us?

So I suppose it is a scheduler effect.  Can this be solved on the kernel
side (a /proc/sys setting perhaps ?), or should a check be built-in into
the software that no more than a certain number of threads are created per
time unit ?

> Also, it is a little old now (by Internet standards) but you 
> might take a look at this paper we did at the beginning of 
> the year: 
>  
> http://www-4.ibm.com/software/developer/library/java2/index.html

I've already read this one.  I'll have to re-read it to freshen up my
memory.

							Arnaud

-- 
Arnaud Installe						<ainstalle@filepool.com>

Absence is to love what wind is to fire.  It extinguishes the small,
it enkindles the great.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
