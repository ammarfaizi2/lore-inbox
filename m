Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUHYSJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUHYSJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUHYSJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:09:32 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:31660 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S267368AbUHYSIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:08:49 -0400
Date: Wed, 25 Aug 2004 11:08:45 -0700
Message-Id: <200408251808.i7PI8jFF017075@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notify_parent and ptrace cleanup
In-Reply-To: OGAWA Hirofumi's message of  Thursday, 26 August 2004 02:51:26 +0900 <877jrnm7hd.fsf@devron.myhome.or.jp>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ptrace() is frangible, and racy. And looks like few things can't improve
> without user visible change. So, I'm thinking I would like to rewrite
> it by another interface.

I don't think such vague statements are useful.  Are there other races you
are implicitly referring to here, or only the ones I have just cited?
These issues are with the implementation, not the interface.  Changing the
ptrace interface won't do anything about them, and fixing them need not
change the ptrace interface.

The ptrace interface could use replacing, but that is really a separate
issue.  I will be first in line to replace it with something that has saner
semantics and a more convenient user interface.  But that won't help a whit
with things like these race concerns.  Let's keep the issue of an ugly
interface separate from the issue of potential bugs in the one we have.  If
there are bugs (aside from the inherent limitations of the intended
semantics), they need to be fixed.

> > +	read_lock_irq(&tasklist_lock); /* Protects child->sighand.  */
>                  ^^^^
> _irq is unneeded?

Correct, thanks.


Thanks,
Roland
