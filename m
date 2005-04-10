Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVDJRgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVDJRgW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVDJRgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:36:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61081 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261536AbVDJRgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:36:08 -0400
Date: Sun, 10 Apr 2005 19:35:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, Dave Jones <davej@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410173554.GB17549@elte.hu>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <Pine.LNX.4.61.0504101326210.16675@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504101326210.16675@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rik van Riel <riel@redhat.com> wrote:

> GCC 4 isn't very happy.  Mostly sign changes, but also something that 
> looks like a real error:
> 
> gcc -g -O3 -Wall   -c -o fsck-cache.o fsck-cache.c
> fsck-cache.c: In function 'main':
> fsck-cache.c:59: warning: control may reach end of non-void function 'fsck_tree' being inlined
> fsck-cache.c:62: warning: control may reach end of non-void function 'fsck_commit' being inlined
> 
> I assume that fsck_tree and fsck_commit should complain loudly if they 
> ever get to that point - but since I'm not quite sure there's no 
> patch, sorry.

i sent a patch for most of the sign errors, but the above is a case gcc 
not noticing that the function can never ever exit the loop, and thus 
cannot get to the 'return' point.

	Ingo
