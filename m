Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTBJOw1>; Mon, 10 Feb 2003 09:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbTBJOw1>; Mon, 10 Feb 2003 09:52:27 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19675 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261518AbTBJOw0>;
	Mon, 10 Feb 2003 09:52:26 -0500
Date: Mon, 10 Feb 2003 20:37:15 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030210203715.A11739@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <3E47AF93.8030807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E47AF93.8030807@mvista.com>; from cminyard@mvista.com on Mon, Feb 10, 2003 at 07:56:35AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 07:56:35AM -0600, Corey Minyard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Suparna Bhattacharya wrote:
> 
> |Yes. It actually saves a formatted compressed dump in memory,
> |and later writes it out to disk as is.
> 
> MCL coredump does funny memory shuffling, too.  It compresses
> pages into a contiguous area of memory, and as it runs into output
> pages that it has not yet compressed, it moves them into pages that
> it has already compressed and keeps track of where everything is

AFAICR, the MCL coredump implementation I'd seen (and used as
a reference to model some of this code for lkcd) seemed to 
save only a kernel dump (not user space pages), so it would 
use the free and user pages as destination for compressed
dump. What you are describing sounds a little different and
closer to what we are doing. I'd be interested in takng a look 
at the implementation you are working with if it actually 
saves the whole memory by making use of pages it has already 
compressed. Could you point me to the code ? 

> located.  That a lot of the complexity of MCL coredump.
> 
> |
> |While the patch I'd posted has been designed so that ideally
> |it should be possible to preserve everything, I'm still not
> |certain if the compression we get is good enough for all cases
> |(e.g a heavily loaded system with lots of non-redundant data)
> |-- we really need to play around with the implementation and
> |tune it. Secondly, for a large memory system, it could take a
> |bit of time to compress all pages, and we might just want to
> |dump potentially more relevant data (e.g kernel pages) for
> |some kind of problems. It was easy enough to do this with some
> |simple heuristics like dumping inuse pages which are nonlru.
> 
> ~From my experience, data is memory is very compressible
> (moreso than the average text file).  Perhaps some pieces are
> not very compressible, but in the whole they are.  Plus you don't

Well, it may just be a matter of how our implementation is tuned. 
MCL compresses a much larger buffer at a time than we do at the 
moment (we did it a page at a time to simplify some of the tracking 
in the dump format), so that could be one factor to consider and
maybe rethink. Its a little early to say, though; I need to 
investigate further. 

> have to have that much compressions for this to work, just enough
> to give you memory to boot the next kernel and save off a dump.

Also has to be enough to not overwrite the current kernel (at 
least the parts that the dump saving code is using or relying on)

> And speed is probably not a big issue here, since this should be a
> very rare occurrance.

Speed is secondary of course, but just good to keep in mind
for very large memory systems.

Regards
Suparna

Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

