Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbRABLBg>; Tue, 2 Jan 2001 06:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbRABLB1>; Tue, 2 Jan 2001 06:01:27 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19211 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130382AbRABLBK>;
	Tue, 2 Jan 2001 06:01:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: start___kallsyms missing from i386 vmlinux.lds ? 
In-Reply-To: Your message of "Tue, 02 Jan 2001 04:39:39 CDT."
             <3A51A1DB.74540C02@yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Jan 2001 21:30:33 +1100
Message-ID: <27530.978431433@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2001 04:39:39 -0500, 
Paul Gortmaker <p_gortmaker@yahoo.com> wrote:
>Keith Owens wrote:
>> kernel/module.c defines
>> extern const char __start___kallsyms[] __attribute__ ((weak));
>> extern const char __stop___kallsyms[] __attribute__ ((weak));
>> 
>> The symbols are weak and do not need to be defined.  If gcc is not
>> honouring __attribute__ ((weak)) then you have a broken or obsolete
>> version of gcc.  You need at least gcc 2.91.66 for kernel 2.4.
>
>Yep, saw the weak part - just noted while scanning test11 diff
>that they were defined like the above patch for arch/sparc* and
>wondered if the inconsistency was intentional.

Some sparc users have a slightly older version of gcc, built shortly
before 'weak' support was added, which required those symbols to be
defined.  Dave Miller thought the compiler problem was widespread
enough to justify changing the source to suit the compiler instead of
forcing sparc users to upgrade.  I suspect that super-h has the same
problem of old compilers, I noticed that somebody added the symbols to
sh/vmlinux.lds.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
