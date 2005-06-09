Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVFIKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVFIKdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVFIKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:33:06 -0400
Received: from mailfe07.swip.net ([212.247.154.193]:3056 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262341AbVFIKc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:32:58 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [PATCH] capabilities not inherited
From: Alexander Nyberg <alexn@telia.com>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d88ba7$hck$1@abraham.cs.berkeley.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
	 <20050608204430.GC9153@shell0.pdx.osdl.net>
	 <1118265642.969.12.camel@localhost.localdomain>
	 <d88ba7$hck$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 12:32:47 +0200
Message-Id: <1118313167.970.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor 2005-06-09 klockan 02:59 +0000 skrev David Wagner:
> Alexander Nyberg  wrote:
> >btw since the last discussion was about not changing the existing
> >interface and thus exposing security flaws, what about introducing
> >another prctrl that says maybe PRCTRL_ACROSS_EXECVE?
> 
> Not sure if I understand the semantics you are proposing.
> 
> I remember that the sendmail attack involved the attacker clearing
> its SETUID capability bit, then execing sendmail.  Sendmail, the victim,
> got executed with fewer capabilities than it expected, and this caused it
> to fail (in particular, sendmail's attempt to drop privileges silently
> failed) -- leading to a security hole.  Will your proposal prevent such
> attacks?  I'm worried.

I'll look this up but it sounds very weird and I don't see how this
would happen with this change.

> >Any new user-space applications must understand the implications of
> >using it so it's safe in that aspect. Yes?
> 
> Not clear.  Suppose Alice exec()s Bob.  
> 
> Does your scheme protect Alice against a malicious Bob?  Yes, because
> Alice has to know about PRCTRL_ACROSS_EXECVE to use it.

Yeah but for capabilities to be useful it needs to be recursive too, ie.
Alice runs Bob that in turn runs Joe. Joe should now have the
capabilities that Alice had if Alice had set PCRTL_ACROSS_EXECVE and Bob
did not drop the PRCTL flag nor zeroed the inheritable mask.

> Does your scheme protect Bob against a malicious Alice?  Not clear.
> If Alice is the only who has to set PRCTRL_ACROSS_EXECVE, then Bob might
> not know about this flag and thus might be surprised by the implicatiohns
> of this flag.  Consequently, I can imagine this flag might allow Alice
> to attack Bob by exec()ing Bob with a different set of capabilities than
> Bob was expecting.  Does this sound right?

That would require Alice to already have the capabilities. No extra
capabilities are gained by exec'ing, it's only about inheriting the
existing ones.

