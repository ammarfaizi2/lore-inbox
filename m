Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288402AbSACXzU>; Thu, 3 Jan 2002 18:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288403AbSACXzL>; Thu, 3 Jan 2002 18:55:11 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:21772 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288402AbSACXzD>;
	Thu, 3 Jan 2002 18:55:03 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15412.61172.824543.547728@argo.ozlabs.ibm.com>
Date: Fri, 4 Jan 2002 10:53:24 +1100 (EST)
To: Lars Brinkhoff <lars.spam@nocrew.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <854rm363x5.fsf@junk.nocrew.org>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3F8@IIS000>
	<15412.14140.652362.747279@argo.ozlabs.ibm.com>
	<854rm363x5.fsf@junk.nocrew.org>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Brinkhoff writes:

> > [Linux] won't get very far on a PDP-10, I can assure you. :)
> 
> Any particular reason why?

For a start, there isn't an arch/pdp10 directory.  The kernel's
approach to portability is to have code tailored to each architecture,
and we don't have such code for a pdp10.

As to the question whether such code could be developed, it would
depend a lot on how gcc did things.  I would expect an int * to be
just an 18-bit address but a char * to be a byte pointer, i.e. a
36-bit word with the byte offset and size in the top 18 bits and the
word address in the lower 18 bits.  This would mean that casting
char * pointers to unsigned long and vice-versa wouldn't give the kind
of results we expect.  The kernel assumes in a lot of places that
memory is byte-addressable and that casting a pointer to an unsigned
long gives you the byte address of the first byte of the object that
the pointer points to, and that it can do arithmetic on those byte
addresses.

Another difficulty would be in relation to the MMU.  IIRC, the KA10
processor had a simple offset/limit memory management scheme, which
would not be sufficient for linux, which requires support for paged
virtual memory.  I have forgotten what the KI10 and KL10 processors
did; I recall it was more complex but I don't think it amounted to
paged virtual memory.

Paul.
