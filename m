Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVBYTC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVBYTC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVBYTC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:02:29 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:25361 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262760AbVBYTCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:02:25 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: seccomp for 2.6.11-rc1-bk8
Date: Fri, 25 Feb 2005 19:01:26 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cvnsm6$pjh$1@abraham.cs.berkeley.edu>
References: <20050121100606.GB8042@dualathlon.random> <20050121111700.Q469@build.pdx.osdl.net> <csvk20$6qa$1@abraham.cs.berkeley.edu> <20050215092539.GT13712@opteron.random>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1109358086 26225 128.32.168.222 (25 Feb 2005 19:01:26 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 25 Feb 2005 19:01:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli  wrote:
>On Sun, Jan 23, 2005 at 07:34:24AM +0000, David Wagner wrote:
>> [...Ostia...]  The jailed process inherit an open file
>> descriptor to its jailor, and is only allowed to call read(), write(),
>> sendmsg(), and recvmsg().  [...]
>
>Why to call sendmsg/recvmsg when you can call read/write anyway?

Because sendmsg() and recvmsg() allow passing of file descriptors,
and read() and write() do not.  For some uses of this kind of jail,
the ability to pass file descriptors to/from your master is a big deal.
It enables significant new uses of seccomp.  Right now, the only way a
master can get a fd to the jail is to inherit that fd across fork(),
but this isn't as flexible and it restricts the ability to pass fds
interactively.

Andrea, I understand that you don't have any use for sendmsg()/recvmsg()
in your Cpushare application.  I'm thinking about this from the point of
view of other potential users of seccomp.  I believe there are several
other applications which might benefit from seccomp, if only it were
to allow fd-passing.  If we're going to deploy this in the mainstream
kernel, maybe it makes sense to enable other uses as well.  And that's
why I suggested allowing sendmsg() and recvmsg().

It might be worth considering.

[Sorry for the very late reply; I've been occupied with other things
since your last reply.]
