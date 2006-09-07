Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWIGWyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWIGWyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWIGWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:54:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33232 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751877AbWIGWyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:54:45 -0400
Date: Fri, 8 Sep 2006 00:54:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060907225429.GA30916@elf.ucw.cz>
References: <20060907003210.GA5503@clipper.ens.fr> <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907173449.GA24013@clipper.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On the webpage, you wrote

* Second, I argue that an attacker (non-root, obviously) cannot take
advantage of the patch. (...) One might argue, however, that the patch makes suid
non-root programs vulnerable, as they could be executed with less
(regular) capabilities than they expect; however, this is not believed
to be a serious problem, because (a) such programs are much rarer than
suid root programs, (b) damage, if any, would be less limited (no
special capabilities are at stake, only access to the filesystem), (c)
removing regular capabilities makes system calls fail with a clean
error code (nothing exotic like the setuid() function which exhibits a
very subtle difference in behavior according as the CAP_SETUID
capability is set or not, which made the sendmail exploit possible),
and (d) system calls can always fail, so adding new causes for failure
is not introducing anything significantly different.

You contradict yourself. Yes, you are decreasing security of suid
non-root programs, and yes, someone will take advantage of that. Plus,
you can easily do away without this risk.

Just add all "usual" capabilities when execing
suid/sgid-anything. Alternatively disallow suid/sgid-anything exec
when all "usual" capabilities are not present.

(And btw I really like your idea of introducing "usual" capabilities
like CAP_REG_FORK/CAP_REG_OPEN/...).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
