Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSC2II6>; Fri, 29 Mar 2002 03:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313387AbSC2IIt>; Fri, 29 Mar 2002 03:08:49 -0500
Received: from poplar.cs.washington.edu ([128.95.2.24]:9746 "EHLO
	poplar.cs.washington.edu") by vger.kernel.org with ESMTP
	id <S313390AbSC2IIn>; Fri, 29 Mar 2002 03:08:43 -0500
Date: Fri, 29 Mar 2002 00:08:18 -0800
From: Neil Spring <nspring@cs.washington.edu>
To: Marek Zawadzki <mzawadzk@cs.stevens-tech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP hashing function
Message-ID: <20020329080757.GA32052@cs.washington.edu>
In-Reply-To: <Pine.NEB.4.33.0203281945150.16010-100000@girardin.cs.stevens-tech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 08:11:27PM -0500, Marek Zawadzki wrote:
> Hello,

Hello.   Please leave the mailing list you're posting to
in the To: field of your message.

> In a transport protocol I'm implementing, I've adapted this TCP hashing
> function:
> 
>  static __inline__ int dcp_hashfn(__u32 laddr, __u16 lport,
>                                   __u32 faddr, __u16 fport)
>  {
>          int h = ((laddr ^ lport) ^ (faddr ^ fport));
>          h ^= h>>16;
>          h ^= h>>8;
>          /* make it always < size : */
>          return h & (MY_HTABLE_SIZE - 1);   /* MY_HT... = 128 */
>  }
> 
> Although I am treating it as a blackbox and it works fine for me, my
> professor pointed the following about this function:

If you're a student, you should probably try to figure
this out for yourself; it's the only way to learn.  

> [...]
> If both IP addresses have the same upper 16 bits (like 155.246.10.5 and
> 155.246.120.30), then the 1st 4-way XOR will put 16 bits of zero in h.
> Then "h ^= h>>16" will preserve the upper 16 bits as zero.  Then
> "h ^= h>>8" will preserve the upper 24 bits!
> [...]

This comment makes an assumption about the architecture
of the machine, and the way IP addresses are stored
into __u32s.

Consider the following code fragment:
  printf("%x %x\n",
         inet_addr("1.0.0.0"),
         inet_addr("0.0.0.1"));

-neil
