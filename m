Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWIVJit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWIVJit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWIVJhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:37:31 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:39816 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751129AbWIVJhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:37:06 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser to bypass CAP_NET_BIND_SERVICE requirement
Date: Fri, 22 Sep 2006 09:37:04 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef0as0$c4f$1@taverner.cs.berkeley.edu>
References: <4E1176C1-8F18-4790-9BCB-95306ACED48A@atheme.org> <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org> <ef08l0$avn$1@taverner.cs.berkeley.edu> <EEE7B568-41EC-4005-AFEF-FD9B47ED98EB@atheme.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158917824 12431 128.32.168.222 (22 Sep 2006 09:37:04 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Fri, 22 Sep 2006 09:37:04 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Pitcock  wrote:
>Additionally, with your solution, the program would still need to be  
>extensively modified.

I suspect "extensively" may be a little bit of an overstatement, though
it sure would take some doing.  With some work, it may be possible to
write an alternative implementation of bind() that creates a Unix domain
socket, forks, execs a copy of the setuid-root program, recieves a copy
of the newly opened fd passed over the Unix domain socket, and returns
that to the caller of bind().  In this way, it might be possible to
build a solution that requires only minimal modifications to the app
(just change how it is linked).  It'd be messy and thoroughly unportable
(because it would only work on systems where that setuid program was
installed), but maybe doable.

>However, that's really not a bad idea (what you proposed). But, I  
>still believe that the sysctl patch is more flexible, especially in  
>cases where you might not have the source-code to what you are trying  
>to run (common with enterprise apps, gameserver admin panels, etc.).

Ok.  Understandable.  I leave it to others to comment further.  I'm not
advocating anything either way.
