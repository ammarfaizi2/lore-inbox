Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbSABGy1>; Wed, 2 Jan 2002 01:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286735AbSABGyS>; Wed, 2 Jan 2002 01:54:18 -0500
Received: from [80.72.64.84] ([80.72.64.84]:5760 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S283003AbSABGyH>; Wed, 2 Jan 2002 01:54:07 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
Date: 02 Jan 2002 08:54:08 +0200
Message-ID: <87ital6y5r.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:

>> The appended patch fix incorrect code, which interferes badly with
>> optimizations in GCC 3.0.4 and GCC 3.1.
>> 
>> The GCC tries to replace the strcpy from a constant string source with
>> a memcpy, since the length is know at compile time.

Tom> Check the linuxppc-dev archives, but this has been discussed before, and
Tom> it came down to a few things.

Well, you may discuss it again, but this time after actually reading
the C standard:

    "6.3.6 Additive operators
      ...  
     
     9 Unless both the pointer operand and the result point to
       elements of the same array object, or the pointer operand
       points one past the last element of an array object and the
       result points to an element of the same array object, the
       behavior is undefined if the result is used as an operand of a
       unary * operator that is actually evaluated."

Tom> 1) gcc shouldn't be making this optimization, and Paulus (who wrote the
Tom> code) disliked this new feature.

Why gcc shouldn't be making some optimization. Because a particular
person doesn't like it or ?  What kind of statement is that anyway ?

Tom> As a subnote, what you sent was sent
Tom> to Linus with a comment about working around a gcc-3.0 bug/feature, and
Tom> was rejected because of this.

It is not a workaround, it is a fix to an invalid code, which gets
triggered by particular optimization.

Tom> 2) We could modify the RELOC macro, and not have this problem.  The
Tom> patch was posted, but not acted upon.

Although all uses of the RELOC macro violate the standard, this kind
of pointer arithmetic is far too common and usually produces the
expected behavior, thus it make sense to optimize the cases where ut
breaks

Tom> 3) We could also try turning off this particular optimization
Tom> (-fno-builtin perhaps) on this file, and not worry about it.

*mutters something about head and sand* ;)

Regards,
-velco

