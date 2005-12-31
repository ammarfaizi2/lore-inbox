Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVLaLXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVLaLXu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLaLXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:23:50 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:3564 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVLaLXt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:23:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p8rPh8AhsGp4X1jyhx1TOAgZ9IhCtjXydFjpjGe3Umu9alAeEnuBjQnPqXDLrx62aBTyo+0s6jjeSgM18uttHUlgAdeQVdEJZ7AE+XAjA06x6OsKV+Nv2LvNzoA2UfC85VjN/hYqPgqjvRglPdw4kbdT8JS580U+OiN4Sylz2qI=
Message-ID: <9a8748490512310323m61a4b812ua853f927c5e447db@mail.gmail.com>
Date: Sat, 31 Dec 2005 12:23:48 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B5D3ED.3080504@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43B53EAB.3070800@ns666.com>
	 <200512302356.59749.s0348365@sms.ed.ac.uk>
	 <43B5CEB8.9070801@ns666.com>
	 <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <43B5D3ED.3080504@ns666.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
> Alistair John Strachan wrote:
> > On Saturday 31 December 2005 00:20, Mark v Wolher wrote:
> > [snip]
> >
> >>>This is good news -- you stand a better chance of achieving the stability
> >>>you require by eliminating variables. VMWare and NVIDIA are useful
> >>>softwares, and I would not deny that, but they are closed source and thus
> >>>any conflicts resulting from their use are not necessary LKML material
> >>>(however, if the interaction is generic and is as a result of a kernel
> >>>bug, then the maintainer would very much like to hear it).
> >>
> >>Okay, i have something interesting now, i only had the nvidia module
> >>loaded so my x-configuration starts up as usual. (not saying the nvidia
> >>module is flawless, i'm sure it still contains bugs)
> >>But here is the crash info, this time it was mozilla, i think this
> >>speaks more hehe :
> >>
The fact that it happens to be mozilla that crashes this time says
*nothing at all* as long as you have binary only modules loaded that
may have messed up the kernel without any way for us to debug that.


> >>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 061f0c08.
> >>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 06b96000.
> >>Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 18000bf8.
> >>Dec 31 00:55:28 localhost kernel: ------------[ cut here ]------------
> >>Dec 31 00:55:28 localhost kernel: kernel BUG at mm/mmap.c:2214!
> >>Dec 31 00:55:28 localhost kernel: invalid operand: 0000 [#1]
> >>Dec 31 00:55:28 localhost kernel: SMP
> >>Dec 31 00:55:28 localhost kernel: Modules linked in: nvidia
> >
> >
> > Steady and sure progress. Now, the trace below doesn't explicitly mention any
> > nvidia symbols, but this line must disappear before anybody will bother to
> > read your report.
> >
> > Remove the module. This does not mean unload, this means "never load in the
> > first place". Then reproduce the problem. If you are successful, send a new

Agreed. As long as nvidia or vmware binary only modules have even been
loaded once, what state the kernel is in is a complete unknown.
To be useful, all testing you do *must* happen without both the nvidia
and vmware modules ever having been loaded. As soon as you load one of
them for even a second any further testing becomes irrelevant.


> > email (not pinned to this thread) with a subject a la "kernel BUG at
> > mm/mmap.c:2214". State that the kernel is not tainted.
> >
> > At this point all you can do is wait. Good luck!
> >
>
> Well, i guess i'll have to do that to be sure. But i must say that i did
> try the nv module and de-installed the nvidia binary module. It didn't
> matter, the system froze but didn't leave anything in the logs, this
> time it did. Doesn't that help at all ?
>
Not really, since anything it leaves in the logs may have been caused
by the binary only module(s), but we have no way to find out, so the
info is next to useless as long as binary only modules are loaded - it
may be correct or it may be wrong, but we have no way to know.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
