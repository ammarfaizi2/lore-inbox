Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbRFMOdy>; Wed, 13 Jun 2001 10:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbRFMOdo>; Wed, 13 Jun 2001 10:33:44 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:28624 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261782AbRFMOdc>; Wed, 13 Jun 2001 10:33:32 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <10322.992441398@ocs4.ocs-net>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 13 Jun 2001 10:31:22 -0400
In-Reply-To: Keith Owens's message of "Thu, 14 Jun 2001 00:09:58 +1000"
Message-ID: <m2zobcxxhh.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Keith" == Keith Owens <kaos@ocs.com.au> writes:

 Keith> #define my_symbol my_symbol_versioned extern void
 Keith> my_symbol(void);

 Keith> void foo(void) { __asm__("call %0" : : "i" (my_symbol)); }

 Keith> # gcc -o x x.c /tmp/cclWXduj.s: Assembler messages:
 Keith> /tmp/cclWXduj.s:12: Error: suffix or operands invalid for
 Keith> `call'

Try ye' olde STRINGIFY and string concatenation?  Well, at least I try...

     #define my_symbol my_symbol_versioned
     #define STRINGIFY(a) STRINGIFY1(a)
     #define STRINGIFY1(a) #a
     extern void my_symbol(void);

     void foo(void)
     {
         __asm__("call " STRINGIFY(my_symbol) "\n");
     }

     [bpringle@localhost bpringle]$ gcc -o x x.c
     /usr/lib/crt1.o(.text+0x18): undefined reference to `main'
     /tmp/ccIj9Cit.o: In function `foo':
     /tmp/ccIj9Cit.o(.text+0x4): undefined reference to `my_symbol_versioned'
     collect2: ld returned 1 exit status

regards,
Bill Pringlemeir.

