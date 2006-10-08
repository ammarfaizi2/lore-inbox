Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWJHKjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWJHKjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 06:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWJHKjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 06:39:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:30031 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751067AbWJHKjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 06:39:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+hbkQc1bFupXm1+AoXkkqArBJhu2slVgbwi8Ek1f7xkQb5f9ZICmHGeZXAyP+pkMHEA7BTPEiBNonT19gVu52H+NotFCyptgS8nXo+nm3gGq+fNyawHwhoRY9Unqg+CcQG71uPD48Lm2P5GxiCRwmD6vfsVol7lme4VakBirBs=
Message-ID: <9a8748490610080339t668095b9v15c4d0040dabae89@mail.gmail.com>
Date: Sun, 8 Oct 2006 12:39:42 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: [patch] honour MNT_NOEXEC for access()
Cc: "Stas Sergeev" <stsp@aknet.ru>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Jakub Jelinek" <jakub@redhat.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Ulrich Drepper" <drepper@redhat.com>
In-Reply-To: <4528CB5B.1020807@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4516B721.5070801@redhat.com> <4522B4F9.8000301@aknet.ru>
	 <20061003210037.GO20982@devserv.devel.redhat.com>
	 <45240640.4070104@aknet.ru> <45269BEE.7050008@aknet.ru>
	 <1160170464.12835.4.camel@localhost.localdomain>
	 <4527A93D.1050203@aknet.ru> <45284694.7060100@goop.org>
	 <4528C06E.5090902@aknet.ru> <4528CB5B.1020807@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
[snip]
> Also, I guess there's the general question of what the noexec mount flag
> really means?  Does it mean "make the execve syscall fail", or does it
> mean "no bits on this filesystem may be interpreted as instructions".
> The former is simple to implement, but probably not very useful; the
> latter is not possible to implement in general.
>

As I see it, what we can resonably do with 'noexec' is
- make execve() fail.
- make access(), faccessat() return EACCESS for files stored on
'noexec' filesystems.
- make mmap(...PROT_EXEC...) fail for files stored on 'noexec' filesystems.

For things like /dev/shm we can additionally let 'noexec' mean "don't
allow executable shared memory".

Since we can't really prevent things like perl/php/bash/tcl/whatever
scripts from being executed/interpreted from there with this
mechanism, let's not worry about that.  Leave that for things like
SELinux to deal with.

I don't think we can do much more with 'noexec'.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
