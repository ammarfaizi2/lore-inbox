Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSJ3Dsy>; Tue, 29 Oct 2002 22:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbSJ3Dsy>; Tue, 29 Oct 2002 22:48:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:10165 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262415AbSJ3Dsx>;
	Tue, 29 Oct 2002 22:48:53 -0500
Message-ID: <3DBF581E.EAFA478A@digeo.com>
Date: Tue, 29 Oct 2002 19:55:10 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
References: <3DBF5372.901E3CB3@digeo.com> <Pine.LNX.4.44.0210291946260.1457-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 03:55:11.0065 (UTC) FILETIME=[24FEA490:01C27FC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Tue, 29 Oct 2002, Andrew Morton wrote:
> 
> > Davide Libenzi wrote:
> > >
> > > Thanks to Andrew and John suggestions I coded another version of the
> > > sys_epoll patch ( 0.13 skipped ... superstition :) ). I won't send the
> > > patch to not waste bandwidth, the patch is available here :
> > >
> > > http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff
> > >
> > > Comments are welcome ...
> > >
> >
> > Looking good to me, Davide.  I think you've nailed everything there
> > except:
> >
> > - Do we want to introduce new list macros, or change epoll a little
> >   to use the existing list manipulators (I think the latter)
> 
> Andrew, sys_epoll uses linux/list.h interface. Doesn't it ?

I was referring to these guys:

+#define list_first(head)	(((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
+#define list_last(head)	(((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
+#define list_next(pos, head)	(((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
+#define list_prev(pos, head)	(((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)

if we are to add such things to list.h then lots of people need
to hum and hah over them first and ask questions like "why doesn't
it use list_empty?"  ;)

It would be better to recode epoll's list walks to use the existing
list accessors.
