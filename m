Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIMPvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 11:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTIMPvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 11:51:50 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:13480 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261334AbTIMPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 11:51:48 -0400
Subject: Re: "busy" load counters
From: Albert Cahalan <albert@users.sf.net>
To: dada1 <dada1@cosmosbay.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <027d01c379d2$1d7b0380$890010ac@edumazet>
References: <1063436451.314.9010.camel@cube>
	 <027d01c379d2$1d7b0380$890010ac@edumazet>
Content-Type: text/plain
Organization: 
Message-Id: <1063467585.314.9060.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Sep 2003 11:39:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 04:36, dada1 wrote:
> From: "Albert Cahalan" <albert@users.sourceforge.net>
> > The feature is available, but you'll need to upgrade
> > to procps-3.1.12 and linux-2.6.0-test4 at least.
> >
> > http://www.kernel.org/pub/linux/kernel/v2.6/
> > http://procps.sf.net/
> >
> 
> With procps-3.1.12 and linux-2.6.0-test5, top and ps reports 0.00 time for
> multi-threaded programs.
> 
> It seems only the 'main' thread is now visible in /proc, and its cpu time
> dont include the cpu time of other threads...

This is correct. For now, the kernel does not report the
existance of new-style threads. I intend to deal with this
problem during the coming week.

I could use a bit of help with research. If you have access
to a non-Linux system, please let me know how the native ps
and top programs handle threads. I do know that many non-Linux
implementations will group threads together in ps output.

Ways to display all threads include:

ps -m   (Tru64, AIX)
ps m    (Tru64, AIX)
ps -T   (IRIX)
ps -L   (Solaris, UnixWare)
ps H    (FreeBSD)
ps k    (OpenBSD)
ps s    (NetBSD)

Examples:
AIX:     ps -eo pid,thcount,tid,comm
Solaris: ps -eLf
Tru64:   ps -emO THREAD

Please use procps-feedback@lists.sf.net for this data.
Here's a program you can use for testing; you may need
to compile it as "cc foo.c -lpthread".

////////////////////////////////////////////
#include <unistd.h>
#include <pthread.h>
void *hanger(void *vp){
  (void)vp;
  for(;;) pause();
}
int main(int argc, char *argv[]){
  pthread_t thread;
  (void)argc;
  (void)argv;
  pthread_create(&thread, NULL, hanger, NULL);
  hanger(NULL);
  return 0; // keep gcc happy
}
/////////////////////////////////////////////



