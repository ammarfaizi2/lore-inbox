Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFIDC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFIDC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 23:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbVFIDC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 23:02:28 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:6660 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261223AbVFIDCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 23:02:23 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] capabilities not inherited
Date: Thu, 9 Jun 2005 02:59:19 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d88ba7$hck$1@abraham.cs.berkeley.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu> <20050608204430.GC9153@shell0.pdx.osdl.net> <1118265642.969.12.camel@localhost.localdomain>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1118285959 17812 128.32.168.222 (9 Jun 2005 02:59:19 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 9 Jun 2005 02:59:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg  wrote:
>btw since the last discussion was about not changing the existing
>interface and thus exposing security flaws, what about introducing
>another prctrl that says maybe PRCTRL_ACROSS_EXECVE?

Not sure if I understand the semantics you are proposing.

I remember that the sendmail attack involved the attacker clearing
its SETUID capability bit, then execing sendmail.  Sendmail, the victim,
got executed with fewer capabilities than it expected, and this caused it
to fail (in particular, sendmail's attempt to drop privileges silently
failed) -- leading to a security hole.  Will your proposal prevent such
attacks?  I'm worried.

>Any new user-space applications must understand the implications of
>using it so it's safe in that aspect. Yes?

Not clear.  Suppose Alice exec()s Bob.  

Does your scheme protect Alice against a malicious Bob?  Yes, because
Alice has to know about PRCTRL_ACROSS_EXECVE to use it.

Does your scheme protect Bob against a malicious Alice?  Not clear.
If Alice is the only who has to set PRCTRL_ACROSS_EXECVE, then Bob might
not know about this flag and thus might be surprised by the implicatiohns
of this flag.  Consequently, I can imagine this flag might allow Alice
to attack Bob by exec()ing Bob with a different set of capabilities than
Bob was expecting.  Does this sound right?

But maybe I'm not thinking clearly enough about this.  This is tricky
stuff.
