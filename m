Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263958AbTEFQty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTEFQty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:49:54 -0400
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:22400 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id S263958AbTEFQtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:49:52 -0400
Date: Tue, 6 May 2003 10:01:23 -0700
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org, Yoav Weiss <ml-lkml@unpatched.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030506170123.GA2025@p3.attbi.com>
References: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305061133290.2977-100000@marcellos.corky.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's much simpler than that: Do either

nm vmlinux | grep sys_call_table
  
  or

grep sys_call_table System.map 

extract the address, use the header file to get the syscall number and
the offset.

Of course this all breaks the GPL, but you can get any non-exported
symbol address that way.

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================




On Tue, May 06, 2003 at 11:45:41AM +0300, Yoav Weiss wrote:
> > But how? When some global will not be exported, it would not be listed
> > in /proc/ksyms.
> 
> So what ?
> You just find the right address (in this case by getting the addresses of
> exported syscalls and finding a list in memory, containing them in the
> right order), and cast it to be the syscall table.  If you want it to work
> with a binary-only driver, you can even insmod a small module that does
> that and adds the result to the symbol table for other modules to use.
> 
> We've been doing that for years on closed-source systems like AIX.  The
> above is just one way to locate a struct in memory.  A faster way is to
> find some exported structs which are known to point to the unexported
> symbol from some offset, extract the symbol's address, and "re-export" it.
> 
> In fact, in linux which is opensource, you can probably write a script
> that extracts any unexported symbol from the source code, find a path to
> it from some exported symbol, and automagically create a module that
> re-exports this symbol for your legacy driver to use.
> 
> If you write the script, don't forget to GPL it :)
> 
> 	Yoav Weiss
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
