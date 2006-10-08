Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWJHKzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWJHKzv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWJHKzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:55:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57267 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751076AbWJHKzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:55:50 -0400
Subject: Re: [patch] honour MNT_NOEXEC for access()
From: Arjan van de Ven <arjan@infradead.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <4528C0B0.4070002@aknet.ru>
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>
	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>
	 <1159887682.2891.537.camel@laptopd505.fenrus.org>
	 <45229A99.6060703@aknet.ru>
	 <1159899820.2891.542.camel@laptopd505.fenrus.org>
	 <4522AEA1.5060304@aknet.ru>
	 <1159900934.2891.548.camel@laptopd505.fenrus.org>
	 <4522B4F9.8000301@aknet.ru>
	 <20061003210037.GO20982@devserv.devel.redhat.com>
	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru>
	 <1160170464.12835.4.camel@localhost.localdomain>
	 <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>
	 <4527D64A.7060002@redhat.com>  <4527FC8B.8010208@aknet.ru>
	 <1160296364.3000.167.camel@laptopd505.fenrus.org>
	 <4528C0B0.4070002@aknet.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 08 Oct 2006 12:55:45 +0200
Message-Id: <1160304945.3000.175.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 13:11 +0400, Stas Sergeev wrote:
> Hello.
> 
> Arjan van de Ven wrote:
> >> but ld.so seems to be
> >> the special case - it is a kernel helper after all,
> > in what way is ld.so special in ANY way?
> It is a kernel helper. Kernel does all the security
> checks before invoking it. However, when invoked
> directly, it have to do these checks itself. So it is
> special in a way that it have to do the security checks
> which otherwise only the kernel should do.

wrong. 
It's "special" only a little bit when the kernel invokes it, but not
really. The *application* is what decides to use which file. And for
example LSB application use another ld.so than the normal one.
(So that the LSB ld.so can translate from the LSB abi to what is on the
system).

But when invoked manually.. there is even LESS special about it... it
could be ANY file on the system. And it's no different from any other
file in /bin, /usr/bin etc etc

> Otherwise, please tell me, how can you solve the problem
> of ld.so started directly, can execute the files you do
> not have an exec permission for?

>  The MNT_NOEXEC hack of
> mmap doesn't solve that.

denying PROT_EXEC of non-"x" files does (somewhat). It's never fool
proof obviously, as long as you need to allow jits.

> Then ld.so can just use that to solve all those permission
> problems.

this is just entirely a wrong assumption; one based on the assumption
that ld.so is something special, that it isn't.


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

