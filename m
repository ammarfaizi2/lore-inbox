Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWJHJJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWJHJJB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWJHJJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:09:01 -0400
Received: from mail.aknet.ru ([82.179.72.26]:28686 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750968AbWJHJJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:09:00 -0400
Message-ID: <4528C0B0.4070002@aknet.ru>
Date: Sun, 08 Oct 2006 13:11:12 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakub Jelinek <jakub@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru>	 <1160170464.12835.4.camel@localhost.localdomain>	 <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>	 <4527D64A.7060002@redhat.com>  <4527FC8B.8010208@aknet.ru> <1160296364.3000.167.camel@laptopd505.fenrus.org>
In-Reply-To: <1160296364.3000.167.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Arjan van de Ven wrote:
>> but ld.so seems to be
>> the special case - it is a kernel helper after all,
> in what way is ld.so special in ANY way?
It is a kernel helper. Kernel does all the security
checks before invoking it. However, when invoked
directly, it have to do these checks itself. So it is
special in a way that it have to do the security checks
which otherwise only the kernel should do.
Otherwise, please tell me, how can you solve the problem
of ld.so started directly, can execute the files you do
not have an exec permission for? The MNT_NOEXEC hack of
mmap doesn't solve that.

Jeremy proposed playing with flags - interesting.
What if the MAP_EXECUTABLE flag, which is currently unused,
will be used for the program to explicitly specify that it
needs an exec permission on the file, and fail otherwise?
Then ld.so can just use that to solve all those permission
problems.

