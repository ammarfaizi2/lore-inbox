Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWIVI7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWIVI7c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 04:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIVI7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 04:59:32 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:17632 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751091AbWIVI7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 04:59:31 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 08:59:12 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef08l0$avn$1@taverner.cs.berkeley.edu>
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org> <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158915552 11255 128.32.168.222 (22 Sep 2006 08:59:12 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 22 Sep 2006 08:59:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Pitcock  wrote:
>This patch allows for a user to disable the requirement to meet the  
>CAP_NET_BIND_SERVICE capability for a non-superuser. It is toggled by  
>the net.ipv4.allow_lowport_bind_nonsuperuser sysctl value.

Can't you provide this functionality (in a non-transparent way) through
user-space code alone?  I'm thinking of a setuid-root program that
takes a port number as argv[1], binds to that port, dup()s the new
file descriptor onto fd 0 (say), drops root, and then forks and execs
a program specified on argv[2].  If you want to get fancy, instead of
exec-ing, you could use the standard trick to pass the file descriptor
over a Unix domain socket to some other process.  Seems like you should
be able to make something like this work, as long as you're willing to
make small modifications to the program that uses the low port.  Does
that work?
