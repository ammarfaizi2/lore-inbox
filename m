Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263799AbRFMOjy>; Wed, 13 Jun 2001 10:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263948AbRFMOjo>; Wed, 13 Jun 2001 10:39:44 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:65523 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263799AbRFMOj0>;
	Wed, 13 Jun 2001 10:39:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Bill Pringlemeir <bpringle@sympatico.ca>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "13 Jun 2001 10:31:22 -0400."
             <m2zobcxxhh.fsf@sympatico.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:39:09 +1000
Message-ID: <10690.992443149@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2001 10:31:22 -0400, 
Bill Pringlemeir <bpringle@sympatico.ca> wrote:
>Try ye' olde STRINGIFY and string concatenation?  Well, at least I try...
>
>     #define my_symbol my_symbol_versioned
>     #define STRINGIFY(a) STRINGIFY1(a)
>     #define STRINGIFY1(a) #a
>     extern void my_symbol(void);
>
>     void foo(void)
>     {
>         __asm__("call " STRINGIFY(my_symbol) "\n");
>     }
>
>     [bpringle@localhost bpringle]$ gcc -o x x.c
>     /usr/lib/crt1.o(.text+0x18): undefined reference to `main'
>     /tmp/ccIj9Cit.o: In function `foo':
>     /tmp/ccIj9Cit.o(.text+0x4): undefined reference to `my_symbol_versioned'

Only at the cost of polluting every .h file that calls a symbol from
__asm__.  The whole pre-processor kludge for symbol versions goes away
in 2.5 so live with _novers for now.

