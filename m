Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315155AbSE2L4S>; Wed, 29 May 2002 07:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSE2L4R>; Wed, 29 May 2002 07:56:17 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:1020 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315155AbSE2L4N>; Wed, 29 May 2002 07:56:13 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1022676201.9255.160.camel@irongate.swansea.linux.org.uk> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin LaHaise <bcrl@redhat.com>, jw schultz <jw@pegasys.ws>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait queue process state 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 May 2002 12:56:03 +0100
Message-ID: <9160.1022673363@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Given an infinite number of monkeys yes. The 'disk I/O is not
> interruptible' assumption is buried in vast amounts of software. This
> isnt a case of sorting out a few misbehaving applications, you can
> start with some of the most basic unix programs like 'ed' and work
> outwards.

Still probably worth doing in the long term. In the short term, we could 
possibly have a sysctl or personality flag to disable it for the benefit of 
broken software. I'm in favour of just letting it break though, to be 
honest - it's _already_ possible to trigger the breakage in some 
circumstances and making it more reproducible is a _good_ thing.

>  If I remember rightly stat() is not interruptible anyway. I don't
> actually argue with the general claim. If I was redesigning unix right
> now I would have no blocking calls, just 'start_xyz' and wait/notify. 

stat() would be restartable. With -ERESTARTNOINTR would prevent us from 
ever actually returning -EINTR if the signal handler exists and returns.

I suspect open() would actually be more of a pain -- but that we could
probably also restart if we get interrupted as early as the read_inode()
stage.

You don't actually have to redesign the API, although I agree it could do 
with it. We could get rid of the bloody silly returning status _and_ length 
in one return code from read()/write() etc. 

--
dwmw2


