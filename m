Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316542AbSHJCPm>; Fri, 9 Aug 2002 22:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316545AbSHJCPm>; Fri, 9 Aug 2002 22:15:42 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:777 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316542AbSHJCPm>;
	Fri, 9 Aug 2002 22:15:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-reply-to: Your message of "Fri, 09 Aug 2002 18:41:04 MST."
             <20020809.184104.68900725.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Aug 2002 12:19:13 +1000
Message-ID: <9131.1028945953@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Aug 2002 18:41:04 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Sat, 10 Aug 2002 11:35:04 +1000
>   
>   af_unix.c is linked into unix.o so we have -DKBUILD_MODNAME=unix.  Alas
>   we also have -Dunix=1.  __stringify(KBUILD_MODNAME) -> __stringify(unix) ->
>   "1" instead of "unix".
>   
>This seems really tacky.  There must be a better way to do this.
>Perhaps prepending some constant string prefix to these module
>names such that they will not collide with the namespace in
>this way.  For example, "kmod_".

Adding a constant prefix to every label and string will increase the
size of the kernel.  I would much rather find a way for cpp to strip
quotes from a #define, then -DKBUILD_OBJECT=\"unix\" has no problems.
But I don't know any cpp construct to convert KBUILD_OBJECT ("unix") to
bare 'unix' without the quotes.  Undefining conflicting names is tacky
but it has the least (zero) impact on the kernel size.

ps.  The variable name is KBUILD_OBJECT, not KBUILD_MODNAME.  The
comment is wrong.

