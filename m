Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265960AbTAYAuM>; Fri, 24 Jan 2003 19:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTAYAuM>; Fri, 24 Jan 2003 19:50:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:4364 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265960AbTAYAuL>;
	Fri, 24 Jan 2003 19:50:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils: using kallsyms when cross-compiling kernel 
In-reply-to: Your message of "24 Jan 2003 16:51:42 -0800."
             <52lm1auk4h.fsf@topspin.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 25 Jan 2003 11:59:11 +1100
Message-ID: <14412.1043456351@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2003 16:51:42 -0800, 
Roland Dreier <roland@topspin.com> wrote:
>Looking further in the code it looks like none of ELF handling stuff
>takes endianness into account.  For example, e_type is also
>byte-swapped from what kallsyms is looking for.
>
>Is my diagnosis correct?  Is there any easy way for me to fix this (at
>least enough so that I can build a PPC kernel on x86 with kkallsyms
>support), or is the only solution to bite the bullet and fix the
>modutils ELF code to be endianness clean?

You are correct.  modutils was never designed to run on one system and
handle modules created for another.  To make it endian safe, all
structures that are read or written from/to disk need a swab routine to
be called after reading and before writing that structure.  You also
have to consider word size differences, e.g. ix86 -> ia64 uses
different word sizes.  Not a trivial task.

Google for kallsyms_i386_ia64.c.  That is a hacked version of kallsyms
that runs on i386 and handles ia64 modules.  Different word size, same
endianess.  It is a starting point to hack a version for i386 -> ppc.

