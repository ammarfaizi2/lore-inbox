Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbQKIVoo>; Thu, 9 Nov 2000 16:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131299AbQKIVod>; Thu, 9 Nov 2000 16:44:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48392 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131262AbQKIVoY>;
	Thu, 9 Nov 2000 16:44:24 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rick Hohensee <humbubba@smarty.smart.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrectness for fun and profit 
In-Reply-To: Your message of "Thu, 09 Nov 2000 12:15:19 CDT."
             <200011091715.MAA24229@smarty.smart.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 10 Nov 2000 08:44:16 +1100
Message-ID: <10589.973806256@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 100 12:15:19 -0500 (EST), 
Rick Hohensee <humbubba@smarty.smart.net> wrote:
>built the [2.4] kernel I'm using at the
>moment with gcc 2.7.2.3. I'm looking for "subtle run time bugs". OK, I'm
>desparate for entertainment. That's a given. Where should I look?

2.4.0-test10 kernel/module.c

static struct module kernel_module =
{
	size_of_struct:		sizeof(struct module),
	name: 			"",
	uc:	 		{ATOMIC_INIT(1)},
	flags:			MOD_RUNNING,
	syms:			__start___ksymtab,
	ex_table_start:		__start___ex_table,	
	ex_table_end:		__stop___ex_table

gcc 2.7.2.3 miscompiles structures that have internal labeled structure
initializers.  uc gets misaligned, ex_table_start is then misaligned
and the exception table handling fails.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
