Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTAYAmd>; Fri, 24 Jan 2003 19:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTAYAmd>; Fri, 24 Jan 2003 19:42:33 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:65124 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S265939AbTAYAmd>; Fri, 24 Jan 2003 19:42:33 -0500
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: modutils: using kallsyms when cross-compiling kernel
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 24 Jan 2003 16:51:42 -0800
Message-ID: <52lm1auk4h.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Jan 2003 00:51:44.0991 (UTC) FILETIME=[EECD46F0:01C2C40B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm trying to run kallsyms on x86 while cross-compiling a kernel
for PowerPC.  I'd like to use the kksymoops patch for 2.4, and the
build process tries to call kallsyms.  I had no problem building a
version of kallsyms (from modutils 2.4.22) that runs on x86 and is
targeted to PPC.

However, kallsyms seems to have endianness problems.  Specifically,
when it runs on my kernel, the test of MATCH_MACHINE(f->header.e_machine)
in obj_load.c fails because EM_PPC is 0x14, but f->header.e_machine has
0x1400 in it.

Looking further in the code it looks like none of ELF handling stuff
takes endianness into account.  For example, e_type is also
byte-swapped from what kallsyms is looking for.

Is my diagnosis correct?  Is there any easy way for me to fix this (at
least enough so that I can build a PPC kernel on x86 with kkallsyms
support), or is the only solution to bite the bullet and fix the
modutils ELF code to be endianness clean?

Thanks,
  Roland
