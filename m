Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUF2MCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUF2MCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 08:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265729AbUF2MCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 08:02:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:24200 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265727AbUF2MCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 08:02:49 -0400
Date: Tue, 29 Jun 2004 14:02:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Edgar Toernig <froese@gmx.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] signal handler defaulting fix ...
Message-ID: <20040629120201.GA24075@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com> <20040628144003.40c151ff.akpm@osdl.org> <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org> <Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org> <20040629032441.403163dd.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040629032441.403163dd.froese@gmx.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 June 2004 03:24:41 +0200, Edgar Toernig wrote:
> Linus Torvalds wrote:
> > 
> > So? That program is buggy.
> 
> Not the signal part.  It was written for libc5.  There, signals set
> with signal(2) were reset when raised (SysV-style).  Leaving such a
> signal handler with longjmp was perfectly valid.

But has a very distinct problem.  A segmentation fault is usually a
bug and deserves a core dump.  Sane default behaviour.  If the program
tells the kernel, it can handle segmentation faults on it's own, fine.
But if - while handling the fault - it creates a second one, the claim
was obviously false.  Coredump, done.

Now, how can the kernel tell, whether a second segmentation fault
happened inside the handler or after successfully handling the first
one?  Right, with longjmp it can't.  Coredump, done.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
