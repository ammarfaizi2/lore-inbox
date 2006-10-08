Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWJHJHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWJHJHz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWJHJHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:07:55 -0400
Received: from mail.aknet.ru ([82.179.72.26]:8204 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750967AbWJHJHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:07:54 -0400
Message-ID: <4528C06E.5090902@aknet.ru>
Date: Sun, 08 Oct 2006 13:10:06 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain> <4527A93D.1050203@aknet.ru> <45284694.7060100@goop.org>
In-Reply-To: <45284694.7060100@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jeremy Fitzhardinge wrote:
>> ld.so to start using the access(R_OK | X_OK) before
>> open().
> Not really.  If you want to do something along those lines it would be 
> better to add a new open flag called something like O_RDEXONLY which 
> would require r-x effective file permissions, and allow 
> PROT_READ|PROT_EXEC mmaps (though for that to be really useful, you'd 
> need to make an O_RDONLY fd not allow PROT_EXEC mmaps, which would break 
> a few things).
It will break _many_ things - my intention is to find a
solution for ld.so that won't break things at all. The
current solution (the hack that makes mmap(PROT_EXEC) to
fail on a "noexec" mounts) breaks just too much and doesn't
solve the problem of executing the files without an exec perm.

But your idea about playing with the flags is interesting.
What if the currently-unused MAP_EXECUTABLE flag became a
way for the program to express that it needs an exec perm,
and so the mmap should fail if there is none? I think ld.so
will be happy using such a flag...

