Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266059AbRGLPcy>; Thu, 12 Jul 2001 11:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266031AbRGLPcd>; Thu, 12 Jul 2001 11:32:33 -0400
Received: from sncgw.nai.com ([161.69.248.229]:919 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S265994AbRGLPcW>;
	Thu, 12 Jul 2001 11:32:22 -0400
Message-ID: <XFMail.20010712083453.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B4DBFDC.91C27FFB@kegel.com>
Date: Thu, 12 Jul 2001 08:34:53 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: Improving (network) IO performance ...
Cc: x@xman.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niels Provos <provos@citi.umich.edu>,
        Charles Lever <Charles.Lever@netapp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jul-2001 Dan Kegel wrote:
> Yes, in fact, it shows that adding more dead connections actually
> improves performance using your patch :-)
> 
> Here's what the little birdie told me exactly:
>> You'll be happy to know I've achieved over 500,000 connections
>> on Pentium hardware with 4G of RAM and 2 1Gbit cards on FreeBSD 4.3.
> 
> I think the application was similar to your benchmark configuration;
> no idea what the ratio of live to dead connections was.
> Let's see: if you have 1/32nd as much RAM as she had, you ought to 
> be able to handle 1/32nd as many connections, right?  Since you
> hit 16000 connections, I guess you just about did.

I've done a couple of changes to the patch :

1) moved the file callback list handling from fs/file.c to fs/fcblist.c

2) moved the functions definitions from include/linux/file.h to
        include/linux/fcblist.h

3) added a new kernel config param CONFIG_FCBLIST

4) renamed the patch from /dev/poll to /dev/epoll ( event poll )

5) renamed the devpoll.c(.h) files into eventpoll.c(.h)

6) made CONFIG_EPOLL dependent of CONFIG_FCBLIST

7) fixed a locking issue on SMP

8) kmalloc/vmalloc switch for big chunks of mem

9) increased the maximum number of fds to 128000 ( maybe I'll change this to be
        unbounded )


The new stuff will be published today in the same link :

http://www.xmailserver.org/linux-patches/nio-improve.html

About the old /dev/poll patch it seems to have problems when the number of
connections go over 8000-9000.
I don't know what it could be coz I've looked deeply inside the patch.
Maybe Niels or Charles can be more precise about this issue.




- Davide

