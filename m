Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWJHNUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWJHNUh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWJHNUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:20:37 -0400
Received: from mail.aknet.ru ([82.179.72.26]:39429 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751139AbWJHNUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:20:36 -0400
Message-ID: <4528FBA5.9010701@aknet.ru>
Date: Sun, 08 Oct 2006 17:22:45 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru> <45269BEE.7050008@aknet.ru>	 <1160170464.12835.4.camel@localhost.localdomain>	 <4527A93D.1050203@aknet.ru> <45284694.7060100@goop.org>	 <4528C06E.5090902@aknet.ru> <4528CB5B.1020807@goop.org> <9a8748490610080339t668095b9v15c4d0040dabae89@mail.gmail.com>
In-Reply-To: <9a8748490610080339t668095b9v15c4d0040dabae89@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jesper Juhl wrote:
> As I see it, what we can resonably do with 'noexec' is
> - make execve() fail.
Done. 

> - make access(), faccessat() return EACCESS for files stored on
> 'noexec' filesystems.
Done now in -mm.

> - make mmap(...PROT_EXEC...) fail for files stored on 'noexec' filesystems.
Even for MAP_PRIVATE?
But in what way the "noexec" is better than "chmod -x",
which does _not_ make the PROT_EXEC to fail?

> Since we can't really prevent things like perl/php/bash/tcl/whatever
> scripts from being executed/interpreted from there with this
> mechanism, let's not worry about that.  Leave that for things like
> SELinux to deal with.
Exactly, but isn't it the same with mmap? (MAP_PRIVATE at least)
Since you can't prevent the prog to simply read() the data into
an anonymously mapped space, you can just as well leave that to
selinux too.

