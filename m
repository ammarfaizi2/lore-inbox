Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFJSdd>; Mon, 10 Jun 2002 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSFJSdc>; Mon, 10 Jun 2002 14:33:32 -0400
Received: from pc2-redb4-0-cust125.bre.cable.ntl.com ([213.107.133.125]:32754
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S315721AbSFJSda>; Mon, 10 Jun 2002 14:33:30 -0400
Date: Mon, 10 Jun 2002 19:33:21 +0100
From: Mark Zealey <mark@zealos.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Message-ID: <20020610183321.GA21687@itsolve.co.uk>
In-Reply-To: <52d6v19r9n.fsf@topspin.com> <20020608.222903.122223122.davem@redhat.com> <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020609.212705.00004924.davem@redhat.com> <20020610110740.B30336@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.19-pre8-ac1 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 11:07:40AM -0700, William Jhun wrote:

> On Sun, Jun 09, 2002 at 09:27:05PM -0700, David S. Miller wrote:
> >    From: Paul Mackerras <paulus@samba.org>
> >    Date: Sun, 9 Jun 2002 19:51:58 +1000 (EST)
> > 
> >    This is the problem scenario.  Suppose we are doing DMA to a buffer B
> >    and also independently accessing a variable X which is not part of B.
> >    Suppose that X and the beginning of B are both in cache line C.
> >    
> > I see what the problem is.  Hmmm...
> > 
> > I'm trying to specify this such that knowledge of cachelines and
> > whatnot don't escape the arch specific code, ho hum...  Looks like
> > that isn't possible.
> 
> Perhaps provide macros in asm/pci.h that will:
> 
> - Take a buffer size and add an appropriate amount (one cache line for
>   alignment and the remainder to fill out the last cache line) to be
>   used for kmalloc(), etc, eg:
> 
> #define DMA_SIZE_ROUNDUP(size) \
>    ((size + 2*SMP_CACHE_BYTES - 1) & ~(SMP_CACHE_BYTES - 1))
> 
> - Take a buffer address (as returned from kmalloc() with the modified
>   size from above) and round it up to a cacheline boundary, eg:
> 
> #define DMA_BUFFER_ALIGN(ptr) \
>    (((unsigned long)ptr + SMP_CACHE_BYTES - 1) & ~(SMP_CACHE_BYTES - 1))
> 
> These two, in conjunction, would provide a buffer that's aligned on a
> cacheline boundary and ends on a cacheline boundary. Kind of ugly, but
> would be sufficient and would hide the cacheline size specifics.
> Cache-coherent platforms would just returned the original argument.

Why not just make some dmalloc() macro in pci.h which will do the nessecory
magic resizing and alignments? seems a lot easier to do...

-- 

Mark Zealey
mark@zealos.org; mark@itsolve.co.uk
