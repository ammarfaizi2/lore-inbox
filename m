Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288220AbSACGbo>; Thu, 3 Jan 2002 01:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288222AbSACGbf>; Thu, 3 Jan 2002 01:31:35 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:12796 "HELO cygnus.com")
	by vger.kernel.org with SMTP id <S288220AbSACGbT>;
	Thu, 3 Jan 2002 01:31:19 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: paulus@samba.org
cc: Momchil Velikov <velco@fadata.bg>, Tom Rini <trini@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix 
Reply-To: law@redhat.com
From: law@redhat.com
In-Reply-To: Your message of Thu, 03 Jan 2002 13:51:33 +1100.
             <15411.50997.394792.638980@argo.ozlabs.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Jan 2002 23:29:04 -0700
Message-ID: <1927.1010039344@porcupine.cygnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > Now the claim is that RELOC is bad because it adds an offset to a
  > pointer, and the offset is usually around 0xc0000000, and thus we are
  > "violating" the C standard.  Thus we are being told that someday this
  > will break and cause a lot of grief.  My contention is that this will
  > only break if a pointer becomes something other than a simple address
  > and pointer arithmetic becomes something other than simple 2's
  > complement addition, subtraction, etc.  If that happens then C will
  > have become useless for implementing a kernel, IMHO.
Well, pointer arithmetic on the HPPA isn't simple 2's complement due to
the way implicit space register selection works.

For example in an unscaled indexed addressing mode like

ldbx  srcreg1(srcreg2), dstreg

Is not equivalent to

ldbx srcreg2(srcreg1), dstreg


ie x + y != y + x for computing an address in a memory operation.

For the same reason computing an address outside of an object into a 
register, then using a displacement in a memory operation to generate an
address that is within the bounds of the object may not work.  ie, you
can't do something like this and expect it to work:

int a[10];
int *z = a - 10;

foo()
{
  return z[10];
}

And before anyone says the PA is unbelievably strange and nobody else would
make the same mistakes -- the mn10300 (for which a linux port does exist)
has the same failings.

jeff

