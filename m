Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWJHAaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWJHAaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 20:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJHAaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 20:30:10 -0400
Received: from gw.goop.org ([64.81.55.164]:54174 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751843AbWJHAaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 20:30:07 -0400
Message-ID: <45284694.7060100@goop.org>
Date: Sat, 07 Oct 2006 17:30:12 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain> <4527A93D.1050203@aknet.ru>
In-Reply-To: <4527A93D.1050203@aknet.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> Even though the access(X_OK) is mostly not needed
> as the execve() would fail anyway, this is not the
> case for ld.so. I think it would be a good idea for
> ld.so to start using the access(R_OK | X_OK) before
> open().

Not really.  If you want to do something along those lines it would be 
better to add a new open flag called something like O_RDEXONLY which 
would require r-x effective file permissions, and allow 
PROT_READ|PROT_EXEC mmaps (though for that to be really useful, you'd 
need to make an O_RDONLY fd not allow PROT_EXEC mmaps, which would break 
a few things).

access() is just plain racy, and can't be used safely for any kind of 
permission/security check.

    J
