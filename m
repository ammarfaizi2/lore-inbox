Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261325AbSKBSqf>; Sat, 2 Nov 2002 13:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSKBSqf>; Sat, 2 Nov 2002 13:46:35 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60938 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261325AbSKBSp2>; Sat, 2 Nov 2002 13:45:28 -0500
Message-Id: <200211021846.gA2Ikhp25511@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Larger IO bitmap?
Date: Sat, 2 Nov 2002 21:38:43 -0200
X-Mailer: KMail [version 1.3.2]
References: <3DC417A4.2000903@yahoo.com>
In-Reply-To: <3DC417A4.2000903@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 November 2002 16:21, Stas Sergeev wrote:
> Hello.
>
> I was trying to add some VESA support to
> dosemu and found that on my Radeon7500
> card it requires an access to the ports
> from range 0x9800-0x98ff. As ioperm()
> doesn't allow to open such a ports, I've
> got a very slow graphics.
> What happens is this:
> IO attempt->GPF->return_to_dosemu->
> decode insn->change uid->change IOPL->
> do IO->change IOPL->change uid->
> back_to_DOS_execution.
> You may guess how slow it is, but if I
> say that it is as slow as the simple
> screen redraw takes up to a minute, that
> may still be a surprise:)
>
> My question is: why do we still have a
> 128-bit IO bitmap? Is it possible to have
> the full 8K IO bitmap per process under
> Linux? And if yes, then why not yet?
> (Note: I am using the latest 2.4 kernels
> and I don't know if there is something
> changed in 2.5 about that problem. If
> something is changed, then sorry for wasting
> your time).

Guess you (and I) need to read the code.
Now that we have per-CPU TSS segments,
8K per CPU would not be a big problem, but
you'll probably need to copy 8K bitmap
into TSS whenever dosemu task starts executing
on that CPU ('normal' tasks won't need large
io bitmap). That's slow but better that what you see now :)

Another question is where to keep it.
You probably need a pointer in task struct
and dynamically allocate bitmap for dosemu-like beasts...
--
vda
