Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315154AbSEHUkM>; Wed, 8 May 2002 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315155AbSEHUkK>; Wed, 8 May 2002 16:40:10 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:22523 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S315154AbSEHUju>;
	Wed, 8 May 2002 16:39:50 -0400
Date: Wed, 8 May 2002 22:39:28 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, marcello@acc.umu.se,
        cyeoh@samba.org, anton@samba.org, paulus@samba.org, davidm@hpl.hp.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: WRT SIGURG incorrectly delivered to process
Message-ID: <20020508223928.J9980@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On, or about, April 18, Christopher Yeoh fixed a problem in the
v2.4-kernel where SIGURG got terminated incorrectly, in violation to
SuSv3. I intend to merge this fix into v2.0 as well, unless someone has
any objections.

However, I noticed that kernel/signal.c also contains similar code that
does not contain SIGURG (mangled whitespace):

(on line 1112 or thereabouts)

  if (k->sa.sa_handler == SIG_IGN
                    || (k->sa.sa_handler == SIG_DFL
                        && (sig == SIGCONT ||
                            sig == SIGCHLD ||
                            sig == SIGWINCH))) {
                        spin_lock_irq(&current->sigmask_lock);
                        if (rm_sig_from_queue(sig, current))
                                recalc_sigpending(current);
                        spin_unlock_irq(&current->sigmask_lock);
                }


Is this intentionally left this way, or did it get missed out by
mistake?!


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
