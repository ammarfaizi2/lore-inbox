Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <973298-32480>; Fri, 15 May 1998 10:48:29 -0400
Received: from dm.cobaltmicro.com ([209.133.34.35]:1157 "EHLO dm.cobaltmicro.com" ident: "davem") by vger.rutgers.edu with ESMTP id <973126-32480>; Fri, 15 May 1998 10:30:46 -0400
Date: Fri, 15 May 1998 07:51:34 -0700
Message-Id: <199805151451.HAA01712@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: cpg@aladdin.de
CC: torvalds@transmeta.com, linux-kernel@vger.rutgers.edu, cpg@aladdin.de
In-reply-to: <199805151156.NAA20899@punt.aladdin.de> (message from Christian Groessler on Fri, 15 May 1998 13:56:07 +0200)
Subject: Re: 2.1.101 warnings on alpha (patch)
References: <199805151156.NAA20899@punt.aladdin.de>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: 	Fri, 15 May 1998 13:56:07 +0200
   From: Christian Groessler <cpg@aladdin.de>

   How does one check whether the host is 64bitty?  Like in the above
   "#if" or is there another (standard) way?

Unfortunately there is no failsafe way.  This is because as a cross
compiler gcc from 32-->64 bit does not get things like:

#if ((~0UL)==0xffffffff)
    ... 32bit version ...
#else
    ... 64bit version ...
#endif

correct at all.  I think it should be in an asm header file
personally, but if you notice the check for 64-bit is often done as:

#if defined(__sparc_v9__) || defined(__alpha__)
#endif

which is pretty unclean and should be fixed up.  But at the moment
there is no other reliable way to check it.

Later,
David S. Miller
davem@dm.cobaltmicro.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
