Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262743AbUC2IQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUC2IQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:16:59 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:38302 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262743AbUC2IPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:15:51 -0500
Message-ID: <082a01c41562$cecdf940$fc82c23f@pc21>
From: "Ivan Godard" <igodard@pacbell.net>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0403281946240.12828-100000@bigblue.dev.mdolabs.com>
Subject: Re: Kernel support for peer-to-peer protection models...
Date: Sun, 28 Mar 2004 23:52:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Davide Libenzi" <davidel@xmailserver.org>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: "Paul Mackerras" <paulus@samba.org>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Sunday, March 28, 2004 7:48 PM
Subject: Re: Kernel support for peer-to-peer protection models...


> > > Ivan Godard writes:
> > >
> > > > 3) flat, unified virtual addresses (64 bit) so that pointers,
including
> > > > inter-space pointers, have the same representation in all spaces
> > >
> > > How are you going to implement fork() ?
> >
> > The usual COW using the page tables. The child keeps the same code space
but
> > gets a new data space. I expect that specialized versions of fork will
give
> > explicit control over which space the child gets, but in comman usage no
one
> > cases just as no one cares which PID it gets.
>
> Uh?
>
> int myexec(char const *cmd) {
>
> if (!fork()) {
> exit(exec(cmd));
> }
> ...
> }
>

Ah! you wanted to know about exec, not fork. A true fork() is pretty rare
these days anyway. Still, the answer is pretty much the same: the fork()
gets you a new data space, retaining the old code space, and the exec()
finds (or creates) the code space that cmd's code is in and switches the
active code space to that space. Heritable data, such as file descriptors,
won't have been in the old data space anyway, so the child references them
through syscalls just as in a conventional.

Perhaps I'm missing your question here, but in general we see no problem
with fork/exec in our model - it's one of the least changed things. You
always get a new address space on a conventional, and you also do with a
Mill; the only difference is that you don't have to shoot down the cache or
TLB, so a fork/exec should be quite a bit faster.

Ivan


