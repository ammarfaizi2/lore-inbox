Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279829AbRJ3C6D>; Mon, 29 Oct 2001 21:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279831AbRJ3C5z>; Mon, 29 Oct 2001 21:57:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62214 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279829AbRJ3C5i>; Mon, 29 Oct 2001 21:57:38 -0500
Message-ID: <3BDE161A.D8289730@zip.com.au>
Date: Mon, 29 Oct 2001 18:53:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Mansfield <david@cobite.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: i/o stalls on 2.4.14-pre3 with ext3
In-Reply-To: <Pine.LNX.4.21.0110292120340.16895-100000@admin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:
> 
> I tried out 2.4.14-pre3 plus the ext3 patch from Andrew Morton and
> encountered some strange I/O stalls.   I was doing a 'cvs tag' of my local
> kernel-cvs repository, which generates a lot of read/write traffic in a
> single process.

hmm..  Thanks - I'll do some metadata-intensive testing.

ext3's problem is that it is unable to react to VM pressure 
for metadata (buffercache) pages.  Once upon a time it did
do this, but we backed it out because it involved mauling
core kernel code.  So at present we only react to VM pressure
for data pages.

Now that metadata pages have a backing address_space, I think we
can again allow ext3 to react to VM pressure against metadata.
It'll take some more mauling, but it's good mauling ;)

Then again, maybe something got broken in the buffer writeout
code or something.

Is this repeatable? 

	while true
	do
		cvs tag foo
		cvs tag -d foo
	done

If so, can you run `top' in parallel, see if there's
anything suspicious happening?
