Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264569AbRFYW4L>; Mon, 25 Jun 2001 18:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264581AbRFYW4C>; Mon, 25 Jun 2001 18:56:02 -0400
Received: from [216.102.46.130] ([216.102.46.130]:63512 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S264569AbRFYWzy>; Mon, 25 Jun 2001 18:55:54 -0400
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Linux and system area networks
In-Reply-To: <mailman.993492125.21454.linux-kernel2news@redhat.com> <200106252230.f5PMUDE26001@devserv.devel.redhat.com>
From: Roland Dreier <roland@topspincom.com>
Date: 25 Jun 2001 15:55:20 -0700
In-Reply-To: Pete Zaitcev's message of "Mon, 25 Jun 2001 18:30:13 -0400"
Message-ID: <52pubs5fvr.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

    Roland> The rough idea is that WSD is a new user space library
    Roland> that looks at sockets calls and decides if they have to go
    Roland> through the usual kernel network stack, or if they can be
    Roland> handed off to a "SAN service provider" which bypasses the
    Roland> network stack and uses hardware reliable transport and
    Roland> possibly RDMA.

    Pete> That can be done in Linux just as easily, using same DLLs
    Pete> (they are called .so for "shared object"). If you look at
    Pete> Ashok Raj's Infi presentation, you may discern "user-level
    Pete> sockets", if you look hard enough. I invite you to try, if
    Pete> errors of others did not teach you anything.

I think you misunderstood the point.  Microsoft is providing this WSD
DLL as a standard part of W2K now.  This means that hardware vendors
just have to write a SAN service provider, and all Winsock-using
applications benefit transparently.  No matter how good your TCP/IP
implementation is, you still lose (especially in latency) compared to
using reliable hardware transport.  Oracle-with-VI and DAFS-vs-NFS
benchmarks show this quite clearly.

Linux has nothing to compare to Winsock Direct.  I agree, one could
put an equivalent in glibc, or one could take advantage of Linux's
relatively low system call latency and put something in the kernel.
The unfortunate consequence of this is that SAN (system area network)
hardware vendors are not going to support Linux very well.

BTW, do you have a pointer to Ashok Raj's presentation?

    Roland> This means that all applications that use Winsock benefit
    Roland> from the advanced network hardware.  Also, it means that
    Roland> Windows is much easier for hardware vendors to support
    Roland> than other OSes.  For example, Alacritech's TCP/IP offload
    Roland> NIC only works under Windows.  Microsoft is also including
    Roland> Infiniband support in Windows XP and Windows 2002.

    Pete> IMHO, Alacritech is about to join scores and scores of
    Pete> vendors who tried that before. Customers understand very
    Pete> soon that a properly written host based stack works much
    Pete> better in the face of a changing environment: Faster CPUs,
    Pete> new CPUs (IA-64), new network protocols (ECN). Besides, it
    Pete> is easy to "accelerate" a bad network stack, but try to
    Pete> outdo a well done stack.

OK, how about an Infiniband network with a TCP/IP gateway at the edge?
Have we thought about how Linux servers should use the gateway to talk
to internet hosts?  Surely there's no point in running TCP/IP inside
the Infiniband network, so there needs to be some concept of "socket
over Infiniband."

Thanks,
  Roland
