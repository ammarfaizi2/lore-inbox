Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSE2Lko>; Wed, 29 May 2002 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSE2Lkn>; Wed, 29 May 2002 07:40:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:65011 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315048AbSE2Lkm>; Wed, 29 May 2002 07:40:42 -0400
Subject: Re: wait queue process state
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>, jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2338.1022669938@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 13:43:21 +0100
Message-Id: <1022676201.9255.160.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 11:58, David Woodhouse wrote:
> Broken software can be fixed.

Given an infinite number of monkeys yes. The 'disk I/O is not
interruptible' assumption is buried in vast amounts of software. This
isnt a case of sorting out a few misbehaving applications, you can start
with some of the most basic unix programs like 'ed' and work outwards.

> There are few excuses for uninterruptible sleep.
> Most of them are 'I was too lazy to write the cleanup path.'

>From an abstract point of view there is no need for uninterruptible
sleep since an uninterruptible sleep can be considered an interruptible
sleep which clones a recovery thread and returns -EINTR, plus a little
locking if needed.

> What I'd _really_ like at the moment is an option to allow read_inode() to
> be interruptible. Currently there's no way for it to exit without leaving a
> bad inode behind, which prevents the _next_ iget() for that inode from
> actually succeeding.

If I remember rightly stat() is not interruptible anyway. I don't
actually argue with the general claim. If I was redesigning unix right
now I would have no blocking calls, just 'start_xyz' and wait/notify.

However the unix api as defined has certain limitations and assumptions
we can pretty much never change. Open with O_INTR maybe would work ?

Alan

