Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSH0UWV>; Tue, 27 Aug 2002 16:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSH0UWV>; Tue, 27 Aug 2002 16:22:21 -0400
Received: from pD9E23A01.dip.t-dialin.net ([217.226.58.1]:42939 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316309AbSH0UWU>; Tue, 27 Aug 2002 16:22:20 -0400
Date: Tue, 27 Aug 2002 14:25:08 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Chris Wedgwood <cw@f00f.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zheng Jian-Ming <zjm@cis.nctu.edu.tw>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
In-Reply-To: <20020827200025.GA8985@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44.0208271420190.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Chris Wedgwood wrote:
>     And how do you protect a caller from having to wait for the lock?
> 
> You don't.  If they have to wait, then they wait.

That leads to the case that we can only run one process of a credential 
sharing group at once. I don't think we need to make it look so bad. 
Particularly bad when we have one default credential per user, which would 
be the logical step. Solution? Don't share credentials...

Look, that's what you're proposing.

>     You'd need a lock count here, where you can only change the
>     credentials when the count is zero. But when will that ever be?
> 
> It depends... for most non-threaded applications, immediately... for
> threaded applications with lots of (day) disk IO, it could be
> indefinite.

Not exactly.

Process 1 kicks a syscall() -> 1
Process 2 kicks a syscall() -> 2
Process 3 kicks a syscall() -> 3
Process 2 ends syscall() -> 2
Process 4 kicks a syscall() -> 3
Process 1 ends syscall() -> 2
Process 2 kicks syscall() -> 3
Process 5 kicks syscall() -> 4
...

> Almost immeasurable.  [sg]et[eu]id doesn't get called that often.

Syscalls do.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

