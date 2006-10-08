Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWJHKdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWJHKdz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWJHKdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:33:55 -0400
Received: from mail.aknet.ru ([82.179.72.26]:24068 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751052AbWJHKdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:33:55 -0400
Message-ID: <4528D497.20904@aknet.ru>
Date: Sun, 08 Oct 2006 14:36:07 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain> <4527A93D.1050203@aknet.ru> <45284694.7060100@goop.org> <4528C06E.5090902@aknet.ru> <4528CB5B.1020807@goop.org>
In-Reply-To: <4528CB5B.1020807@goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jeremy Fitzhardinge wrote:
>> What if the currently-unused MAP_EXECUTABLE flag became a
>> way for the program to express that it needs an exec perm,
>> and so the mmap should fail if there is none? I think ld.so
>> will be happy using such a flag...
> Yes, but it doesn't solve the fact that there isn't really anything 
> special about ld.so, so putting special checks into it doesn't really 
But this is not the checks - just a flag, MAP_EXECUTABLE, which
may mean that the exec perms are required.
Currently there is no way for the program to express that
explicitly (if only by the use of the mprotect call), so
why not to add one?

> Also, I guess there's the general question of what the noexec mount flag 
> really means?  Does it mean "make the execve syscall fail", or does it 
> mean "no bits on this filesystem may be interpreted as instructions".  
Since PROT_EXEC doesn't require an exec perm on file, I don't
see why "noexec" should be special.

> The former is simple to implement, but probably not very useful; the 
It can be usefull if you put it on all the user-writable
mounts of yours - then someone can't easily exec his exploit.

> latter is not possible to implement in general.
At least without selinux - yes, so my question was why to
even add the hacks.

