Return-Path: <linux-kernel-owner+w=401wt.eu-S1030221AbWLTRx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWLTRx1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWLTRx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:53:27 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:48533 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221AbWLTRx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:53:26 -0500
Date: Wed, 20 Dec 2006 18:53:09 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061220175309.GT30106@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org> <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [2006-12-20 09:35]:
> Can you remind us:
>  - your ARM is UP, right? Do you have PREEMPT on?

It's UP and PREEMPT is not set.  I used 2.6.19 plus the patch that has
been posted.

>  - This is probably a stupid question, but you did make sure that the
>    database was ok (with some rebuild command) and that you didn't have
>    preexisting corruption?

Yes, my test case is to install Debian on the ARM machine so the
database is created fresh.  While the corruption always triggers
during a fresh installation, it's much harder to see in a running
system.  Some people see it on their system but I haven't found a 100%
working recipe to reproduce it yet given a working system; doing a new
installation seems to trigger it all the time though.

> Anyway, the page_mkclean_one() fixes (along with _most_ things we've
> looked at) shouldn't matter on UP, at least certainly not without
> PREEMPT.

Hmm.  So what about UP without PREEMPT then...

Maybe the following information is helpful in some way: remember how I
said that we have applied 6 mm patches to 2.6.18 in Debian?  According
to Gordon Farquharson, who's helping me a great deal with testing
installation on this ARM machine (Linksys NSLU2), the corruption
doesn't always show up when you only apply
mm-tracking-shared-dirty-pages.patch to 2.6.18 but it shows up all the
time with all six patches applied.  As a reminder, the 6 patches we
apply are:

mm-tracking-shared-dirty-pages.patch
mm-balance-dirty-pages.patch
mm-optimize-mprotect.patch
mm-install_page-cleanup.patch
mm-do_wp_page-fixup.patch
mm-msync-cleanup.patch

-- 
Martin Michlmayr
http://www.cyrius.com/
