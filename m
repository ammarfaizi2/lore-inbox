Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSEJXSf>; Fri, 10 May 2002 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316166AbSEJXSe>; Fri, 10 May 2002 19:18:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56332 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316163AbSEJXSd>;
	Fri, 10 May 2002 19:18:33 -0400
Message-ID: <3CDC5509.DCAF336A@zip.com.au>
Date: Fri, 10 May 2002 16:17:29 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: matthew@wil.cx, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
In-Reply-To: <3CDC4037.8040104@us.ibm.com> <3CDC45EF.9000506@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> As Linus pointed out, a semaphore is probably the wrong way to go.
> The only things that really needs to be protected are the list
> operations themselves.
> 

It was I who put the BKL back into locks.c, much to
Matthew's disgust...

The problem was that replacing the BKL with a semaphore
seriously damaged Apache thoughput on 8-way.  Apache
was using flock()-based synchronisation and replacing
a spin with a schedule just killed it.

So.. Apache isn't doing that any more, but it is an
instructive case.  Replacing the BKL with a semaphore
can sometimes be a very bad thing.

See http://www.uwsg.iu.edu/hypermail/linux/kernel/0010.3/ -
search for "scalability"

-
