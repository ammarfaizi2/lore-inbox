Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273702AbRJDOSQ>; Thu, 4 Oct 2001 10:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJDOSG>; Thu, 4 Oct 2001 10:18:06 -0400
Received: from my.nada.kth.se ([130.237.226.101]:21503 "EHLO my.nada.kth.se")
	by vger.kernel.org with ESMTP id <S273702AbRJDORz>;
	Thu, 4 Oct 2001 10:17:55 -0400
Date: Thu, 4 Oct 2001 16:18:20 +0200 (MET DST)
Message-Id: <200110041418.QAA17395@my.nada.kth.se>
From: "=?ISO-8859-1?Q?Mattias Engdeg=E5rd?=" <f91-men@nada.kth.se>
To: pmenage@ensim.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com> (message from Paul
	Menage on Thu, 04 Oct 2001 00:52:58 -0700)
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage <pmenage@ensim.com> wrote:
>The only real user-space solution to this is to have the SIGCHLD handler
>somehow cause the select() to return immediately by e.g. writing a byte
>to a looped pipe which is included in the select() readfd set, but this
>seems a little contrived.

I don't think it's contrived --- writing not a byte, but the pid and
return status of the dead child to a pipe is an old but useful trick.
It gives a natural serialisation of child deaths, and also eliminates
the common race where a child dies before its parent has recorded its
pid in a data structure. See it as a safe way of converting an
asynchronous signal to a queued event.

Using pipes to wake up blocking select()s is a useful thing in general,
and often a lot cleaner than using signals when dealing with threads.

