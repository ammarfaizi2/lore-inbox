Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288574AbSADJwm>; Fri, 4 Jan 2002 04:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288576AbSADJwc>; Fri, 4 Jan 2002 04:52:32 -0500
Received: from junk.nocrew.org ([212.73.17.42]:18308 "EHLO junk.nocrew.org")
	by vger.kernel.org with ESMTP id <S288562AbSADJwR>;
	Fri, 4 Jan 2002 04:52:17 -0500
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
	<15412.14140.652362.747279@argo.ozlabs.ibm.com>
	<854rm363x5.fsf@junk.nocrew.org>
	<15412.61172.824543.547728@argo.ozlabs.ibm.com>
From: Lars Brinkhoff <lars.spam@nocrew.org>
Organization: nocrew
Date: 04 Jan 2002 10:52:02 +0100
In-Reply-To: <15412.61172.824543.547728@argo.ozlabs.ibm.com>
Message-ID: <857kqy4f5p.fsf@junk.nocrew.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:
> Lars Brinkhoff writes:
> > > [Linux] won't get very far on a PDP-10, I can assure you. :)
> > Any particular reason why?
> As to the question whether such code could be developed, it would
> depend a lot on how gcc did things.  I would expect an int * to be
> just an 18-bit address but a char * to be a byte pointer, i.e. a
> 36-bit word with the byte offset and size in the top 18 bits and the
> word address in the lower 18 bits.

This is true in the classic PDP-10 architecture, but would it
really be worthwhile to run Linux in an 18-bit address space?.

In the extended architecture, an int * is a 30-bit address, and the
byte offset and size is encoded in the top 6 bits.  This would be a
more suitable target for Linux.

> This would mean that casting char * pointers to unsigned long and
> vice-versa wouldn't give the kind of results we expect.  The kernel
> assumes in a lot of places that memory is byte-addressable and that
> casting a pointer to an unsigned long gives you the byte address of
> the first byte of the object that the pointer points to, and that it
> can do arithmetic on those byte addresses.

When a pointer-to-integer conversion is made (or vice versa), GCC
could generate code to convert between a PDP-10 hardware pointer and a
linear byte address.

> Another difficulty would be in relation to the MMU.  IIRC, the KA10
> processor had a simple offset/limit memory management scheme, which
> would not be sufficient for linux, which requires support for paged
> virtual memory. 

Right.

> I have forgotten what the KI10 and KL10 processors did; I recall it
> was more complex but I don't think it amounted to paged virtual
> memory.

The KI10 has limited support for paging, but I don't remember the
details.  KL10 most definitely supports full paged virtual memory.

-- 
Lars Brinkhoff          http://lars.nocrew.org/     Linux, GCC, PDP-10
Brinkhoff Consulting    http://www.brinkhoff.se/    programming
