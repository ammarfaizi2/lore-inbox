Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTEFIdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTEFIdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:33:20 -0400
Received: from corky.net ([212.150.53.130]:1422 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262451AbTEFIdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:33:19 -0400
Date: Tue, 6 May 2003 11:45:41 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: D.A.Fedorov@inp.nsk.su, <terje.eggestad@scali.com>,
       <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But how? When some global will not be exported, it would not be listed
> in /proc/ksyms.

So what ?
You just find the right address (in this case by getting the addresses of
exported syscalls and finding a list in memory, containing them in the
right order), and cast it to be the syscall table.  If you want it to work
with a binary-only driver, you can even insmod a small module that does
that and adds the result to the symbol table for other modules to use.

We've been doing that for years on closed-source systems like AIX.  The
above is just one way to locate a struct in memory.  A faster way is to
find some exported structs which are known to point to the unexported
symbol from some offset, extract the symbol's address, and "re-export" it.

In fact, in linux which is opensource, you can probably write a script
that extracts any unexported symbol from the source code, find a path to
it from some exported symbol, and automagically create a module that
re-exports this symbol for your legacy driver to use.

If you write the script, don't forget to GPL it :)

	Yoav Weiss

