Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUIHIya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUIHIya (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIHIya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:54:30 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:14518 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268464AbUIHIyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:54:19 -0400
Date: Wed, 8 Sep 2004 10:54:10 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: Andrew Morton <akpm@osdl.org>
cc: Simon Derr <simon.derr@bull.net>, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: 2.6.9-rc1-mm4
In-Reply-To: <20040908014735.7a2058dc.akpm@osdl.org>
Message-ID: <Pine.A41.4.53.0409081051410.75304@isabelle.frec.bull.fr>
References: <20040907020831.62390588.akpm@osdl.org>
 <Pine.LNX.4.58.0409071415380.10577@daphne.frec.bull.fr>
 <20040908014735.7a2058dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Andrew Morton wrote:

> > kernel/sys.c:283:29: macro "sys_request_key" requires 5 arguments, but only 1 given
> > kernel/sys.c:283: error: `sys_request_key' defined both normally and as an alias
> > kernel/sys.c:283: warning: `syscall_linkage' attribute only applies to function types
> > kernel/sys.c:284:24: macro "sys_keyctl" requires 5 arguments, but only 1 given
> > kernel/sys.c:284: error: `sys_keyctl' defined both normally and as an alias
> > kernel/sys.c:284: warning: `syscall_linkage' attribute only applies to function types
> >
> > In include/linux/key.h, sys_request_key and sys_keyctl are defined as
> > macros :
> >
> > #define sys_request_key(a,b,c,d,e)      (-ENOSYS)
> > #define sys_keyctl(a,b,c,d,e)           (-ENOSYS)
> >
> > But in kernel/sys.c, we find:
> >
> > cond_syscall(sys_request_key)
> > cond_syscall(sys_keyctl)
> >
> > Which expects these symbols to be real functions, it seems.
>
> Works OK here.  What compiler version are you using?  And what architecture?
>
gcc 3.3.2 on ia64.

> to pass through unscathed.  It's a bit unpleasant though.  I guess we can
> just remove those defines from key.h.
I agree.

