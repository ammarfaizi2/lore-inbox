Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273326AbRISHN7>; Wed, 19 Sep 2001 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273937AbRISHNt>; Wed, 19 Sep 2001 03:13:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43605 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273326AbRISHNf>; Wed, 19 Sep 2001 03:13:35 -0400
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
In-Reply-To: <20010918234648.A21010@netnation.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 01:05:06 -0600
In-Reply-To: <20010918234648.A21010@netnation.com>
Message-ID: <m1r8t3fyot.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.com> writes:

> I've always wondered why it's not possible to do this:
> 
> fd = open("an_actual_file",O_RDONLY);
> fcntl(fd,F_SETFL,O_NONBLOCK);
> r = read(fd,buf,4096);
> 
> And actually have read return -1 and errno == EWOULDBLOCK/EAGAIN if the
> block requested is not already cached.
> 
> Wouldn't this be the ideal interface for daemons of all types that want
> to stay single-threaded and still offer useful performance when the
> working set doesn't fit in cache?  It works with sockets, so why not
> with files?

Besides the SUS or the POSIX specs...
What would cause the data to be read in if read just checks the caches?
With sockets the other side is clearing pushing or pulling the data.  With
files there is no other side...

This is resolveable just not currently implemented.

Eric

