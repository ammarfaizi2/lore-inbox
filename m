Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273963AbRIXPyQ>; Mon, 24 Sep 2001 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273964AbRIXPyJ>; Mon, 24 Sep 2001 11:54:09 -0400
Received: from ns.suse.de ([213.95.15.193]:5636 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273963AbRIXPxy>;
	Mon, 24 Sep 2001 11:53:54 -0400
Date: Mon, 24 Sep 2001 17:54:19 +0200
From: Olaf Hering <olh@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010924175419.A30742@suse.de>
In-Reply-To: <20010924040208.A624@localhost.localdomain> <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.21.0109240810300.1593-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 24, 2001 at 08:12:20AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, Marcelo Tosatti wrote:

> 
> 
> On Mon, 24 Sep 2001, Jacek [iso-8859-2] Pop³awski wrote:
> 
> > I just installed 2.4.10, and...
> > 
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > VM: killing process donkey_s
> > __alloc_pages: 0-order allocation failed (gfp=0x1f0/0) from c0126c2e
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > VM: killing process screen
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > VM: killing process bash
> > (...)
> > 
> > I am changing kernels often, but never seen that kind of message. Last kernel I
> > had before 2.4.10 was 2.4.10-pre4.
> > 
> > PS. donkey_s is application which eats a lot of memory, but I have 384MB RAM
> > and 100MB swap.
> 
> Jacek, 
> 
> You had available swap when the VM started to kill processes ? 

I see that too with 2.4.10aa1 on a 4way 2gig ppc power3 box without
swap:

mandarine:~ # w
bash: fork: Cannot allocate memory
mandarine:~ # w
bash: /usr/bin/w: Cannot allocate memory
mandarine:~ # w
  5:50pm  up 13 min,  3 users,  load average: 6.27, 3.30, 1.67
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
root     ttyS0    -                 5:39pm  3.00s  3.19s  1.51s  w 
olaf     pts/0    nectarine.suse.d  5:39pm  9:45  43.90s  0.06s  sh
do_all 
olh      pts/1    nectarine.suse.d  5:48pm  7.00s  0.79s  0.79s  -bash 
mandarine:~ # free
bash: fork: Cannot allocate memory
mandarine:~ # dmesg | tail
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x70/0)
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
VM: killing process cc1
mandarine:~ # free
             total       used       free     shared    buffers
cached
Mem:       2057304    2052932       4372          0      53480
1792468
-/+ buffers/cache:     206984    1850320
Swap:            0          0          0
mandarine:~ # free
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
bash: fork: Cannot allocate memory
mandarine:~ # vmstat
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 3  0  1      0   2744  53944 1794968   0   0   440   343   75   300  14
28  58
mandarine:~ # free
Killed


That did not happen with pre10aa1, at least the OOM kills.
I happend with a bk pull, a build in the background. I seems that it
doesnt release some memory...

Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
