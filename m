Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDQW55>; Tue, 17 Apr 2001 18:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132709AbRDQW5r>; Tue, 17 Apr 2001 18:57:47 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33179 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132580AbRDQW5d>;
	Tue, 17 Apr 2001 18:57:33 -0400
Message-ID: <3ADCCA57.2A354359@mandrakesoft.com>
Date: Tue, 17 Apr 2001 18:57:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: i386 cleanups
In-Reply-To: <20010417232614.A4377@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> These are tiny cleanups you might like. sizes are "logically"
> long. No, it does not matter on i386.
> 
> processor.h makes INIT_TSS look much more readable. [Please tell me
> applied or rejected]
> 
>                                                         Pavel
> 
> Index: include/asm-i386/posix_types.h
> ===================================================================
> RCS file: /home/cvs/Repository/linux/include/asm-i386/posix_types.h,v
> retrieving revision 1.1.1.1
> diff -u -u -r1.1.1.1 posix_types.h
> --- include/asm-i386/posix_types.h      2000/09/04 16:50:33     1.1.1.1
> +++ include/asm-i386/posix_types.h      2001/02/13 13:49:18
> @@ -16,9 +16,9 @@
>  typedef unsigned short __kernel_ipc_pid_t;
>  typedef unsigned short __kernel_uid_t;
>  typedef unsigned short __kernel_gid_t;
> -typedef unsigned int   __kernel_size_t;
> -typedef int            __kernel_ssize_t;
> -typedef int            __kernel_ptrdiff_t;
> +typedef unsigned long  __kernel_size_t;
> +typedef long           __kernel_ssize_t;
> +typedef long           __kernel_ptrdiff_t;

If it doesn't matter on i386 why bother?


>  #define INIT_TSS  {                                            \
> -       0,0, /* back_link, __blh */                             \
> -       sizeof(init_stack) + (long) &init_stack, /* esp0 */     \
> -       __KERNEL_DS, 0, /* ss0 */                               \
> -       0,0,0,0,0,0, /* stack1, stack2 */                       \
> -       0, /* cr3 */                                            \
> -       0,0, /* eip,eflags */                                   \
> -       0,0,0,0, /* eax,ecx,edx,ebx */                          \
> -       0,0,0,0, /* esp,ebp,esi,edi */                          \
> -       0,0,0,0,0,0, /* es,cs,ss */                             \
> -       0,0,0,0,0,0, /* ds,fs,gs */                             \
> -       __LDT(0),0, /* ldt */                                   \
> -       0, INVALID_IO_BITMAP_OFFSET, /* tace, bitmap */         \
> -       {~0, } /* ioperm */                                     \
> +       esp0: sizeof(init_stack) + (long) &init_stack,          \
> +       ss0: __KERNEL_DS,                                       \
> +       ldt: __LDT(0),                                          \
> +       bitmap: INVALID_IO_BITMAP_OFFSET,                       \
> +       ioperm: {~0, }                                          \

IIRC certain key structures cannot be taken to gcc's style of struct
initialization, and IIRC this is one of them.  Maybe that's a egcs-1.1.2
bug.  Have you looked at the assembly output to make sure things are
100% ok after this change?

Regards,
Jeff, who wonders if there is a way to upgrade human memory as easily as
computer memory...


-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
