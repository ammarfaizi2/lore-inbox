Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVK3RXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVK3RXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 12:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbVK3RXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 12:23:14 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:20845 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751455AbVK3RXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 12:23:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=onaxoHjI1HLQp8D6ohtbAiYgieR9qhsp+RJXfBN9s8zSN9r1oyNSNoqeNmRVNWb/+SYBH9IRsmlBquYlVgdhFeoyPeNB35pzC9Sw5SJaxzfgDVc9NBkw5ek2oHj9KRv4zS5+lS5ikDrG+HnIkQNjA/txTbaIE849UGEwB5NSuvc=
Message-ID: <121a28810511300923h24ebe39y@mail.gmail.com>
Date: Wed, 30 Nov 2005 18:23:12 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] race condition in procfs
Cc: vserver@list.linux-vserver.org, linux-kernel@vger.kernel.org
In-Reply-To: <1133367951.6635.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <121a28810511290525m1bdf12e0n@mail.gmail.com>
	 <121a28810511290604m68c56398t@mail.gmail.com>
	 <1133274524.6328.56.camel@localhost.localdomain>
	 <121a28810511290639g79617c85h@mail.gmail.com>
	 <Pine.LNX.4.58.0511290945380.7838@gandalf.stny.rr.com>
	 <121a28810511300641pca9596fl@mail.gmail.com>
	 <1133363652.25340.17.camel@localhost.localdomain>
	 <121a28810511300729p6983c9a2x@mail.gmail.com>
	 <1133367951.6635.12.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/30, Steven Rostedt <rostedt@goodmis.org>:
> (Andrew, this will be the last email that I include you on.  I'm taking
> you off unless you want to stay on this thread, and say so.  I figure
> that you get enough spam without having to read through this. I'll
> obviously add you back if this results in a patch.)

(removed Andrew from the CC as well)

>
> On Wed, 2005-11-30 at 16:29 +0100, Grzegorz Nosek wrote:
> > 2005/11/30, Steven Rostedt <rostedt@goodmis.org>:
> > >
> > > OK, Remove your patches, run the system where you can capture the log,
> > > and provide a full output of the oops.  Make sure you have
> > > CONFIG_KALLSYMS set.
> > >
> >
> > OK, attached an oops from netconsole.
> >
>
> The oops happened at address a01b50eb.  Could you go into the compiled
> directory run gdb on vmlinux and type li *0xa01b50eb and show what you
> get.
>

OK, will send it as soon as I get my hands on it (I'm building a new
kernel at the moment with full debug info). In the meantime, if you
have a copy of fs/proc/array.o handy, have a look at do_task_stat
dissassembly and search for movzbl (%eax), %eax. Regardless of my
kernel config, architecture or whatever, the oops is in that
instruction (clearly a NULL pointer dereference). From some previous
debug build I found out (via objdump -dl) that it's apparently at the
entry point of the get_task_stat inline function.

Best regards,
 Grzegorz Nosek
