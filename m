Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291684AbSBNOVm>; Thu, 14 Feb 2002 09:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291679AbSBNOV0>; Thu, 14 Feb 2002 09:21:26 -0500
Received: from elin.scali.no ([62.70.89.10]:26888 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S291684AbSBNOVK>;
	Thu, 14 Feb 2002 09:21:10 -0500
Message-ID: <3C6BC796.CC8FB660@scali.com>
Date: Thu, 14 Feb 2002 15:20:06 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rickard Westman <rwestman@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Using kernel_fpu_begin() in device driver - feasible or not?
In-Reply-To: <E16bMEO-0008Up-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > 1. Would it be sufficient to just bracket all fpu-using code code by
> > kernel_fpu_begin()/kernel_fpu_end()?  If not, what problems could I
> > run into?
> 
> You can do that providing you dont
> 
> > 2. Would it be OK to go to sleep inside such a region, or should I
> > take care to avoid that?
> 
> You can't sleep in such a region - there is nowhere left to store the
> FPU context
> 
> > 3. Perhaps I should call init_fpu() at some point as well?  If so,
> > should it be done before or after kernel_fpu_begin()?
> 
> After
> 
> > 4. Is there any difference between doing this in the context of a user
> > process (implementation of an ioctl) compared to doing it in a
> > daemonized kernel thread (created by a loadable kernel module)?
> 
> The kernel thread is actually easier, you can happily corrupt its user
> FPU context by sleeping since you are the only FPU user for the thread.
> Not nice, not portable but should work fine on x86 without any of the
> above for the moment.
> 
> You should probably also test the FPU is present and handle it accordingly
> with polite messages not an oops 8)

So are kernel_fpu_begin()/kernel_fpu_end() (and also init_fpu()) necessary in a kernel thread at all
? Does kernel_fpu_begin()/kernel_fpu_end() take care of SSE and MMX registers too (I'm aware of the
extra "emms" needed in the MMX case) ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
