Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUJ0EcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUJ0EcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUJ0EcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:32:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:12684 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262316AbUJ0Eb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:31:59 -0400
Date: Tue, 26 Oct 2004 21:29:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: karim@opersys.com
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       rpm@xenomai.org
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-Id: <20041026212956.4729ce98.akpm@osdl.org>
In-Reply-To: <417F12F1.5010804@opersys.com>
References: <20041023194721.GB1268@us.ibm.com>
	<417F12F1.5010804@opersys.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour <karim@opersys.com> wrote:
>
> Here are a number of solutions that some have found to be "correct"
>  for their needs over time, in chronological order of appearance:
>  a- Master/slave kernel (ex.: RTLinux)
>  b- Dual-CPU (there are actually many examples of this, some that
>      date back quite a few years)
>  c- Interrupt levels (ex.: D.Schleef, B.Kuhn, etc.)
>  d- Nanokernel/Hypervisor (ex.:Adeos)
>  e- Preemption
>  f- Uber-preemption and IRQ threading (a.k.a. preemption on acid)
>      (ex.: Ingo, TimeSys, MontaVista, Bill)

uber-preemption is the chosen way for the mainline kernel mainly because
its mechanisms can be largely hidden inside (increasingly ghastly) header
files and most developers just don't have to worry about it.

I have a sneaking suspicion that the day will come when we get nice
sub-femtosecond latencies in all the trivial benchmarks but it turns out
that the realtime processes won't be able to *do* anything useful because
whenever they perform syscalls, those syscalls end up taking long-held
locks.

Which does lead me to suggest that we need to identify the target
application areas for Ingo's current work and confirm that those
applications are seeing the results which they require.  Empirical results
from the field do seem to indicate success, but I doubt if they're
sufficiently comprehensive.
