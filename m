Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129803AbQKXOTb>; Fri, 24 Nov 2000 09:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129784AbQKXOTR>; Fri, 24 Nov 2000 09:19:17 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:17162 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129803AbQKXNTL>;
        Fri, 24 Nov 2000 08:19:11 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mark Ellis <mark.uzumati@virgin.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS on bringing down ppp 
In-Reply-To: Your message of "Fri, 24 Nov 2000 10:55:39 -0000."
             <20001124105539.A18945@ElCapitan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Nov 2000 23:49:05 +1100
Message-ID: <2401.975070145@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000 10:55:39 +0000, 
Mark Ellis <mark.uzumati@virgin.net> wrote:
>Hi all, consistently getting the following when pppd is terminated. Happens
>in 2.4.0-test11, fine in 2.4.0-test9, don't know about test10. Same happens
>for pppd 2.4.0b4 and 2.4.0, both recompiled for test11. Is this related to
>the modutils incompatability (modutils 2.3.19) ? 

I don't think so.  I cannot reproduce this oops on 2.4.0-test11 with
modutils 2.3.21, ppp 2.4.0.  modutils 2.3.19 should be compatible with
kernel 2.4.0-test11, the incompatibility is between modutils <= 2.3.15
and kernel 2.4.0-test11.

It was difficult to find the right area of code, my compile with
egcs-2.91.66 and -march=i686 gives quite different Assembler, so take
this analysis with a pinch of salt.  Is there any chance that you are
using the wrong compiler and/or compiler options?

The oops looks to be on line 102 of kmod.c

	for (i = 0; i < current->files->max_fds; i++ ) {

current->files is NULL.  That has nothing to do with modutils, rather
it points to an invalid or incomplete current context.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
