Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUHZVOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUHZVOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUHZVM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:12:27 -0400
Received: from 69-56-158-114.theplanet.com ([69.56.158.114]:34777 "HELO
	sevenpoint.net") by vger.kernel.org with SMTP id S269660AbUHZVKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:10:54 -0400
Message-ID: <002901c48bb0$f66ab5f0$6505a8c0@pixl>
From: "Peter Maas" <peter@7pt.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.6.9-rc1-bk2 compile failure
Date: Thu, 26 Aug 2004 16:09:23 -0500
Organization: LPB Communications
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm guessing
static inline unsigned read_seqbegin const seqlock_t *sl)
{
        unsigned ret = sl->sequence;
        smp_rmb();
        return ret;
}

Should Be....

static inline unsigned read_seqbegin(const seqlock_t *sl)
{
        unsigned ret = sl->sequence;
        smp_rmb();
        return ret;
}

Peter maas

----- Original Message ----- 
From: "Peter Maas" <peter@7pt.net>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 26, 2004 4:01 PM
Subject: patch-2.6.9-rc1-bk2 compile failure


> Havent seen this posted to the LKML yet, but someone should have a quick
> answer for me.
> 
> Compile failure on 2.6.9-rc1-bk2
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CPP     arch/i386/kernel/vsyscall.lds.s
>   SYSCALL arch/i386/kernel/vsyscall-int80.so
>   SYSCALL arch/i386/kernel/vsyscall-sysenter.so
>   AS      arch/i386/kernel/vsyscall.o
>   SYSCALL arch/i386/kernel/vsyscall-syms.o
>   LD      arch/i386/kernel/built-in.o
>   CC      arch/i386/lib/delay.o
> In file included from include/linux/time.h:28,
>                  from include/linux/timex.h:186,
>                  from include/linux/sched.h:11,
>                  from arch/i386/lib/delay.c:14:
> include/linux/seqlock.h:76: error: syntax error before "const"
> include/linux/seqlock.h:76: error: syntax error before ')' token
> make[1]: *** [arch/i386/lib/delay.o] Error 1
> make: *** [arch/i386/lib] Error 2

