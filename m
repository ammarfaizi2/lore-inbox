Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTJISwo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJISwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:52:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37648 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262353AbTJISwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:52:43 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Date: 9 Oct 2003 18:43:00 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bm4a7k$5eq$1@gatekeeper.tmr.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAwtz+A6aJAkeufXSGK2GIiwEAAAAA@casabyte.com> <Pine.LNX.4.44.0310071743370.32358-100000@home.osdl.org> <20031008104726.GA4655@outpost.ds9a.nl> <3F846183.9010205@redhat.com>
X-Trace: gatekeeper.tmr.com 1065724980 5594 192.168.12.62 (9 Oct 2003 18:43:00 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F846183.9010205@redhat.com>,
Ulrich Drepper  <drepper@redhat.com> wrote:

| The kernel thread functionality is not used 1-to-1 in the userlevel
| interfaces of the pthread library.  One very specific combination of all
| the CLONE_* flags is used in libpthread.  Other users of the kernel
| might use other combinations and they won't implement pthreads.  That
| is perfectly fine and if it fits your bill, do it.  But none of this
| ever has any influence on the pthread interface.  The properties like
| sharing of file descriptors are guaranteed.

I confess that my first reaction to this topic was that I could add an
attribute when starting a thread, and then use existing code (pthreads)
and just take advantage of the non-fd-sharing.

Pseudo code: (some of the if's are clearly ifdef)

  if linux add_noshare_to_attributes
  for (;;) {
    fd = listen();
    start_thread(fd)
    if linux clode fd
  }

Clearly that isn't what's needed, I would probably define a
start_service_and_close_fd_ifUcan macro/procedure. When this is stable
and 2.6 is closer to production quality I will probably modify a few
applications to see what benefits might be available.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
