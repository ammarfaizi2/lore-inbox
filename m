Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUK3AgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUK3AgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUK3AgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:36:08 -0500
Received: from lakermmtao12.cox.net ([68.230.240.27]:7677 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261904AbUK3AfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:35:25 -0500
In-Reply-To: <cofv73$us3$1@terminus.zytor.com>
References: <19865.1101395592@redhat.com> <cofv73$us3$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A697CF5A-4267-11D9-8DB8-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Mon, 29 Nov 2004 19:34:52 -0500
To: hpa@zytor.com (H. Peter Anvin)
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2004, at 15:01, H. Peter Anvin wrote:
> Most people seem to have suggested include/linux-abi for this; I would
> personally prefer include/linux-abi/arch for the second.

It seems like there are two ways to adjust the headers.  We could move
the private headers to a new directory (include/kernel?), or we could 
move
the public headers to a new directory (include/linux-abi?).  I am 
willing to
work on some simple and trivial patches to begin doing either one, if we
can reach an agreement as to which one is preferrable (and what to call
the new directory.)

>>      (a) Transfer this stuff into a file of the same name in the new
>> 	 directory. So, for example, the syscall number list from
>> 	 include/asm-i386/unistd.h will be transferred to
>> 	 include/user-i386/unistd.h.
> I'm not sure you can do such a 1:1 mapping.  In fact, there are cases
> where you definitely don't want to, because the current structure
> doesn't make much sense.

I think that the initial trivial patches would probably preserve a 1:1
mapping, just for compatibility.  On the other hand, future patches 
might
rearrange things to make more logical sense.

>>      (d) stdint types should be used where possible.
>>
>> 		[include/user-i386/termios.h]
>> 		struct winsize {
>> 			uint16_t ws_row;
>> 			uint16_t ws_col;
>> 			uint16_t ws_xpixel;
>> 			uint16_t ws_ypixel;
>> 		};
> Good, except your "struct winsize" is bad; you're stepping on
> namespace which belongs to userspace.  Since we can't use typedefs on
> struct tags, I suggest:
>
> struct __kstruct_winsize {
>        /* ... */
> };
>
> .. and userspace can do:
>
> #define __kstruct_winsize winsize

My initial suggestion would be to leave the types as-is, primarily for
the reasons in Linus' earlier email, but also for simplicity and to
prevent inadvertent breakage.

>>  (3) Remove all #if(n)def __KERNEL__ clauses.
>>
>>  (4) Remove the -D__KERNEL__ from the master kernel Makefile.
>
> Bad!  There is code in the kernel which can compile in userspace for
> testing.  This is highly valuable and should be kept.

I would propose that if we decide to move the public headers instead of
the internal kernel headers, we autogenerate headers for installation
that have a #warning wrapper if __KERNEL__ isn't defined.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


