Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSEIPBN>; Thu, 9 May 2002 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSEIPBM>; Thu, 9 May 2002 11:01:12 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:5588 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313299AbSEIPBK>;
	Thu, 9 May 2002 11:01:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15578.36627.478751.622066@napali.hpl.hp.com>
Date: Thu, 9 May 2002 08:00:35 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, engebret@vnet.ibm.com,
        justincarlson@cmu.edu, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, anton@samba.org, ak@suse.de
Subject: Re: Memory Barrier Definitions
In-Reply-To: <20020509173646.5c1b5baa.rusty@rustcorp.com.au>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 9 May 2002 17:36:46 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> On Wed, 8 May 2002 10:07:08 -0700 David Mosberger
  Rusty> <davidm@napali.hpl.hp.com> wrote:

  >> The ia64 memory ordering model is quite orthogonal to the one
  >> that Linux uses (which is based on the Alpha instructions): Linux
  >> distinguishes between read and write memory barriers.  ia64 uses
  >> an acquire/release model instead.  An acquire orders all *later*
  >> memory accesses and a release orders all *earlier* accesses
  >> (regardless of whether they are reads or writes).  Another
  >> difference is that the acquire/release semantics is attached to
  >> load/store instructions, respectively.  This means that in an
  >> ideal world, ia64 would rarely need to use the memory barrier
  >> instruction.

  Rusty> Hmmm... could you explain more?  You're saying that every
  Rusty> load is an "acquire" and every store a "release"?  Or that
  Rusty> they can be flagged that way, but aren't always?

The latter: loads can have "acquire" semantics and stores can have
"release" semantics.  For example, at the assembly level, ld8.acq
would be an 8-byte load with acquire semantics, st8.rel an 8-byte
store with release semantics.  At the C level, acquire/release
semantics is used for all accesses to "volatile" variables.

One way to think of all this is that using .acq/.rel for *all* memory
accesses will give you a memory model that exactly matches that of a
Pentium III.

  Rusty> Does this means that an "acquire" means "all accesses after
  Rusty> this insn (in the code stream) must occur after this insn (in
  Rusty> time)"?

Yes.

  Rusty> Does that only apply to the address that instruction
  Rusty> touched, or all?

No, the address doesn't matter (data dependencies are always honored).

	--david
