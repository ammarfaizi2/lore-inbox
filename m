Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSE2K7Z>; Wed, 29 May 2002 06:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSE2K7Y>; Wed, 29 May 2002 06:59:24 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15353 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S314885AbSE2K7Y>; Wed, 29 May 2002 06:59:24 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1022631707.4123.151.camel@irongate.swansea.linux.org.uk> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 May 2002 11:58:58 +0100
Message-ID: <2338.1022669938@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  What Unix and standards say and do make that one unfortunately a very
> bad idea. Its true that to the letter of the specs you can do
> interruptible disk I/O. Its also true to the real world that vast
> amounts of software breaks in subtle, unreported, oh hell what ate my
> file kind of ways 

Broken software can be fixed.

There are few excuses for uninterruptible sleep.
Most of them are 'I was too lazy to write the cleanup path.'

The one you offer seems to be 'Other people are too lazy to write 
the cleanup paths which POSIX mandates.' -- which isn't a great deal 
more acceptable than the original excuse, IMHO.

What I'd _really_ like at the moment is an option to allow read_inode() to
be interruptible. Currently there's no way for it to exit without leaving a
bad inode behind, which prevents the _next_ iget() for that inode from
actually succeeding.

--
dwmw2


