Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRKHOM0>; Thu, 8 Nov 2001 09:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279614AbRKHOMR>; Thu, 8 Nov 2001 09:12:17 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:51982 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276424AbRKHOMF>;
	Thu, 8 Nov 2001 09:12:05 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "BALBIR SINGH" <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More dependencies on CONFIG_SMP 
In-Reply-To: Your message of "Thu, 08 Nov 2001 18:49:27 +0530."
             <3BEA865F.4040909@wipro.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Nov 2001 01:11:53 +1100
Message-ID: <21304.1005228713@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Nov 2001 18:49:27 +0530, 
"BALBIR SINGH" <balbir.singh@wipro.com> wrote:
>Looking at arch/i386/config.in
>
>if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
>   define_bool CONFIG_HAVE_DEC_LOCK y
>fi
>endmenu
>
>and arch/i386/lib/Makefile
>
>.obj-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
>
>We need to have SMP set inorder to use dec_and_lock. The file fs/dcache.c
>in function dput uses a function atomic_dec_and_lock function, which is
>defined in dec_and_lock.c.

There is a #define for atomic_dec_and_lock when compiling for UP.  I
suspect that you have been bitten by the broken makefiles, otherwise
everybody would be reporting problems with 2.4.14.  Before you send any
more patches (and before your existing patches are used), please follow
the steps in http://www.tux.org/lkml/#s8-8.

If you still get problems after that, mail the error messages and your
.config instead of sending patches to "fix" bugs which nobody else is
seeing.  You should include the errors you are getting, otherwise we
cannot tell if the patch makes sense or not.

