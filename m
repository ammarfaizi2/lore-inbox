Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSHLDxz>; Sun, 11 Aug 2002 23:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSHLDxz>; Sun, 11 Aug 2002 23:53:55 -0400
Received: from zok.SGI.COM ([204.94.215.101]:59077 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317261AbSHLDxy>;
	Sun, 11 Aug 2002 23:53:54 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unix-domain sockets - abstract addresses 
In-reply-to: Your message of "Sun, 11 Aug 2002 20:13:14 MST."
             <20020811.201314.111686100.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Aug 2002 13:57:24 +1000
Message-ID: <1716.1029124644@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 20:13:14 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Keith Owens <kaos@ocs.com.au>
>   Date: Mon, 12 Aug 2002 13:20:09 +1000
>   
>   The problem here is that 'unix' is
> ...
>   a symbol that is defined by gcc.
>
>I see.  GCC really shouldn't be doing that as it pollutes the global
>namespace.  However, I see current 3.x vintage gcc is still doing it
>under Linux so there must be a reason it is kept around.

Untested, against 2.5.31.  It would be better to -Uunix globally but
one header depends on it, drivers/message/fusion/lsi/mpi_type.h.

--- 2.5.31-pristine/net/unix/Makefile.orig	Sat May 25 14:50:09 2002
+++ 2.5.31-pristine/net/unix/Makefile	Mon Aug 12 13:54:54 2002
@@ -8,5 +8,7 @@
 unix-$(CONFIG_SYSCTL)	+= sysctl_net_unix.o
 unix-objs		:= $(unix-y)
 
+EXTRA_CFLAGS		+= -Uunix	# avoid gcc namespace pollution
+
 include $(TOPDIR)/Rules.make
 

