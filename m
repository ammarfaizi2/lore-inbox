Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSHJBbb>; Fri, 9 Aug 2002 21:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSHJBbb>; Fri, 9 Aug 2002 21:31:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:42760 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316541AbSHJBba>;
	Fri, 9 Aug 2002 21:31:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-reply-to: Your message of "Fri, 09 Aug 2002 18:05:00 MST."
             <20020809.180500.87139790.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Aug 2002 11:35:04 +1000
Message-ID: <8740.1028943304@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Aug 2002 18:05:00 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>   --- linus-2.5/net/unix/af_unix.c	Mon Aug  5 12:02:05 2002
>   +++ thunder-2.5/net/unix/af_unix.c	Fri Aug  9 16:28:36 2002
>   @@ -79,6 +79,8 @@
>     *		  with BSD names.
>     */
>    
>   +#undef unix	/* KBUILD_MODNAME */
>   +
>
>Explain to me what this giblet is for?

Rusty's plan to standardize boot and module parameters needs the
overall "module name" in the code, whether the code is built in or a
module.  KBUILD_MODNAME defines the overall module name based on the
linkage data.

Sometimes KBUILD_MODNAME is used quoted, sometimes it is used unquoted.
We can quote it easily (__stringify) but AFAIK there is no way in cpp
to strip quotes from a string, so KBUILD_MODNAME has to be passed as a
bare word, without quotes.

af_unix.c is linked into unix.o so we have -DKBUILD_MODNAME=unix.  Alas
we also have -Dunix=1.  __stringify(KBUILD_MODNAME) -> __stringify(unix) ->
"1" instead of "unix".

