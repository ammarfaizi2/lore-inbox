Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUHaX6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUHaX6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHaX57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:57:59 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:10375 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S269162AbUHaXyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:54:18 -0400
Date: Tue, 31 Aug 2004 16:54:10 -0700
Message-Id: <200408312354.i7VNsAND001811@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
X-Fcc: ~/Mail/linus
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Albert Cahalan's message of  , 31 August 2004 11:59:25 -0400 <1093967964.434.7086.camel@cube>
X-Windows: putting new limits on productivity.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For TASK_DEAD and TASK_TRACED, might you be hiding some underlying state?

Not really.

> I want to display stuff like:
> 
> T    stopped (not traced)
> TX   stopped, and being traced
> RX   running or runnable, and being traced
> ZE   zombie, and trying to exit
> RXE  running, trying to exit, and traced

These distinctions don't exist in any data structures, except for the
PF_EXITING flag.  

> It's troubling the way TASK_DEAD and TASK_TRACED show up as
> actual states and hide any other stuff. I'd much prefer them
> to be flags of some sort.

That's a different implementation than what we've got now.  Feel free to
try to make it work.  Linus has talked before about treating the state as a
bitmask, but the code is not actually written that way now.  
