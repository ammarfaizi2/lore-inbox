Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288019AbSABXj0>; Wed, 2 Jan 2002 18:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288018AbSABXh4>; Wed, 2 Jan 2002 18:37:56 -0500
Received: from [217.9.226.246] ([217.9.226.246]:58752 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288009AbSABXhg>; Wed, 2 Jan 2002 18:37:36 -0500
To: paulus@samba.org
Cc: Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
	<15411.36909.387949.863222@argo.ozlabs.ibm.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <15411.36909.387949.863222@argo.ozlabs.ibm.com>
Date: 03 Jan 2002 01:37:45 +0200
Message-ID: <87zo3wtjcm.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Mackerras <paulus@samba.org> writes:

Paul> Momchil Velikov writes:
>> Well, you may discuss it again, but this time after actually reading
>> the C standard:
>> 
>> "6.3.6 Additive operators
>> ...  
>> 
>> 9 Unless both the pointer operand and the result point to
>> elements of the same array object, or the pointer operand
>> points one past the last element of an array object and the
>> result points to an element of the same array object, the
>> behavior is undefined if the result is used as an operand of a
>> unary * operator that is actually evaluated."

Paul> One of the reasons why C is a good language for the kernel is that its
Paul> memory model is a good match to the memory organization used by the
Paul> processors that linux runs on.  Thus, for these processors, adding an
Paul> offset to a pointer is in fact simply an arithmetic addition.  Combine
Paul> that with the fact that the kernel is far more aware of how stuff is
Paul> laid out in its virtual memory space than most C programs, and you can
Paul> see that it is reasonable for the kernel to do pointer arithmetic
Paul> which might be undefined according to the strict letter of the law,
Paul> but which in fact works correctly on the class of processors that
Paul> Linux runs on, for all reasonable compiler implementations.

Paul> The rules in the C standard are designed to allow a program to run
Paul> consistently on a wide variety of machine architectures, including
Paul> things like the DEC PDP-10 which weren't directly byte-addressable.
Paul> (Yes the PDP-10 had "byte pointers" but they were a different kind of
Paul> object from an ordinary pointer.)  The Linux kernel runs on a more
Paul> restricted range of machines and IMHO we are entitled to assume things
Paul> because of that.

>> Why gcc shouldn't be making some optimization. Because a particular
>> person doesn't like it or ?  What kind of statement is that anyway ?

Paul> This is the kernel.  If I say strcpy I want the compiler to call a
Paul> function called strcpy, not to try to second-guess me and do something
Paul> different.  If I want memcpy I'll write "memcpy".

This is C. If you use ``strcpy'', an identifier reserved by the
standard, it means that you want to move some bytes from here to there
and please let the compiler decide how to do that.  Much in the same
way as when you assign structures and compiler uses ``memcpy'' or
maybe it doesn't if it wouldn't be a win.

>> Although all uses of the RELOC macro violate the standard, this kind
>> of pointer arithmetic is far too common and usually produces the
>> expected behavior, thus it make sense to optimize the cases where ut
>> breaks

Paul> If the gcc maintainers think they are entitled to change the memory
Paul> model so as to break pointer arithmetic that "violates" the standard,
Paul> then we will have to use a different compiler.

Where do you see changes in pointer arithmetic ? Or in the "memory
model" (whatever that means) ?

I'd dare to state that _very_ few people would join the quest for
writing the kernel in something other than C.

Paul> As for the original problem, my preferred solution at the moment is to
Paul> add an label in arch/ppc/lib/string.S so that string_copy() is the
Paul> same function as strcpy(), and use string_copy instead of strcpy in
Paul> prom.c.
