Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUHWOwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUHWOwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUHWOwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:52:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53890 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264571AbUHWOwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:52:34 -0400
Date: Mon, 23 Aug 2004 10:52:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lei Yang <leiyang@nec-labs.com>
cc: Lee Revell <rlrevell@joe-job.com>, Sam Ravnborg <sam@ravnborg.org>,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling kernel modules
In-Reply-To: <412A01AC.5020108@nec-labs.com>
Message-ID: <Pine.LNX.4.53.0408231046190.7816@chaos>
References: <4127A15C.1010905@nec-labs.com>  <20040821214402.GA7266@mars.ravnborg.org>
 <4127A662.2090708@nec-labs.com>  <20040821215055.GB7266@mars.ravnborg.org>
  <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net>
 <4129FAC8.3040502@nec-labs.com> <Pine.LNX.4.53.0408231018001.7732@chaos>
 <412A01AC.5020108@nec-labs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Lei Yang wrote:

> Richard B. Johnson wrote:
>
> > Do `depmod -e test.ko` to see what it's complaining about. You
> > can see all the symbols by using `nm`. Try it. Your code
> > probably didn't define the necessary stuff to make a module.
> > You need to look at a typical module (driver) that comes with the
> > kernel. Just find one of the shortest ".c" files in the driver
> > tree.
>
> Thanks! I did less /var/log/messages, and got the unknown symbols
> Unknown symbol __divsf3
> Unknown symbol __fixsfsi
> Unknown symbol __subsf3
> Unknown symbol __floatsisf
> Unknown symbol __mulsf3
> Unknown symbol __gesf2
> Unknown symbol __addsf3
>
> However, I don't know what those symbols are :( I am a bit worried that
> maybe I've done something that is not supported by the kernel, like
> left-shift 16 bits of an int, or floating operations.
>
> Any hints?
>
> Thanks a lot!
> Lei

You cannot use floating-point in the kernel. It appears that you
are trying to make user-mode code execute within the kernel. It
can't. That's not what a module does. The kernel executes code
on behalf of the user-mode caller, in the context of the caller.
It does things, on behalf of the user, that the user can't
be trusted to do properly by himself. That's all the kernel
is for! Any calculations and similar stuff can be done in
regular user-mode code.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


