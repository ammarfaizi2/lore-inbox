Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSDJNQC>; Wed, 10 Apr 2002 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312582AbSDJNQB>; Wed, 10 Apr 2002 09:16:01 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:60341 "EHLO ibm.com")
	by vger.kernel.org with ESMTP id <S312560AbSDJNP7>;
	Wed, 10 Apr 2002 09:15:59 -0400
Date: Wed, 10 Apr 2002 08:19:29 -0600
From: sullivan <sullivan@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Event logging vs enhancing printk
Message-ID: <20020410081929.Q7333@austin.ibm.com>
In-Reply-To: <OF58E93BB4.1862769F-ON85256B97.0047811A@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 07:07:46PM -0500, Mike Sullivan wrote:
> >> Right - what I'm proposing would be a generic equivalent of the
> >> local staging buffer and sprintf - basically just a little wrapper
> >> that does this for you, keeping a per task buffer somewhere.
> >
> > That still doesn't solve the race with the interrupt handlers, you'd
> > need a buffer for each irq handler and one the softirq too to make
> > printk buffered and coeherent coherent across newlines (doable but even
> > more tricky and in turn less robust and less self contained).
> 
> I was envisaging a larger buffer where the current location pointer
> simply taken by the interrupt handler, and the remaining section of
> that buffer was used for the "inner printk". Which is really just
> like a stack, so it makes more sense to just allocate this off the
> stack really .... I think this would work? We might need to flush
> on a certain size limit (128 chars, maybe?) to stop any risk of
> stack overflow.
> 
> > Some other code may omit it by mistake, leading to the other cpus
> > blackholed and data lost after the buffer on the other cpus overflowed
> > so at least we should put a timer that spawns an huge warning if a cpu
> > doesn't flush the buffer in a rasonable amount of time so we can catch
> > those places.
> 
> It seems that 99.9% of these cases are just assembling a line of output
> a few characters at a time. There might be a few odd miscreants around,
> but not enough to worry about - I think it's overkill to do the runtime
> timer check, but we could always run like this to test it, or try to
> work some sort of automated code inspection (though that sounds hard to
> do 100% reliably).

As an alternative to building a buffer and flushing, maybe it would be better ifin the case of evlog records of this type could be marked with a continuation flag. During post processing there should be enough information on the invocation location to the record to allow the recombination and viewing of the full record.

In general I think the event notification features offered by evlog offer a good platform upon which to build some very useful sysadmin tools.

> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> Thanks.
> Mike Sullivan
> IBM Linux Technology Center
> (512)838-0539 or t/l  678-0539
