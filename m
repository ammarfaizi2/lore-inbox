Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTHSS7c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTHSS7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:59:16 -0400
Received: from main.gmane.org ([80.91.224.249]:40149 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261214AbTHSS6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:58:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] O17int
Date: Tue, 19 Aug 2003 20:58:35 +0200
Message-ID: <yw1xbrulxyn8.fsf@users.sourceforge.net>
References: <200308200102.04155.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:RvIH+kdQVbFnD7pOGfra1TC0Gh8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another XEmacs strangeness:

When compiling from xemacs, everything is fine until the compilation
is done.  Then xemacs starts spinning wildly in some loop doing this:

select(1024, [], NULL, NULL, {0, 0})    = 0 (Timeout)
write(5, "F\v\5\0004\0\0\0017\0\0\1\4\0\223\0008\0\r\0F0\5\0004\0"..., 40) = 40
write(5, "F\v\5\0004\0\0\0017\0\0\1\4\0\223\0008\0\r\0F0\5\0004\0"..., 40) = 40
select(1024, [], NULL, NULL, {0, 0})    = 0 (Timeout)
ioctl(5, 0x541b, [0])                   = 0
ioctl(5, 0x541b, [0])                   = 0
gettimeofday({1061288133, 302532}, NULL) = 0
select(20, [3 5 6 7 9 10 12 13 19], [], [], {0, 0}) = 1 (in [13], left {0, 0})
gettimeofday({1061288133, 302779}, NULL) = 0
select(1024, [13], NULL, NULL, {0, 0})  = 1 (in [13], left {0, 0})
read(13, 0x8dc4b08, 512)                = -1 EIO (Input/output error)
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1703, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1162, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1160, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1003, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
select(1024, [], NULL, NULL, {0, 0})    = 0 (Timeout)
write(5, "F\v\5\0004\0\0\0017\0\0\1\4\0\223\0008\0\r\0F0\5\0004\0"..., 40) = 40
write(5, "F\v\5\0004\0\0\0017\0\0\1\4\0\223\0008\0\r\0F0\5\0004\0"..., 40) = 40
select(1024, [], NULL, NULL, {0, 0})    = 0 (Timeout)
ioctl(5, 0x541b, [0])                   = 0
ioctl(5, 0x541b, [0])                   = 0
gettimeofday({1061288133, 304385}, NULL) = 0
select(20, [3 5 6 7 9 10 12 13 19], [], [], {0, 0}) = 1 (in [13], left {0, 0})
gettimeofday({1061288133, 304605}, NULL) = 0
select(1024, [13], NULL, NULL, {0, 0})  = 1 (in [13], left {0, 0})
read(13, 0x8dc4b08, 512)                = -1 EIO (Input/output error)
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1703, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1162, 0xbfffe80c, WNOHANG, NULL)  = 0
rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
wait4(1160, 0xbfffe80c, WNOHANG, NULL)  = 0

This goes on for anything from half a second to several seconds.
During that time other processes, except X, are starved.

I saw this first with 2.6.0-test1 vanilla, then it went away in -test2
and -test3, only to show up again with O16.3int.  My O16.2 kernel
seems ok, which seems strange to me since the difference from O16.2 to
O16.3 is very small.

Any ideas?

-- 
Måns Rullgård
mru@users.sf.net

