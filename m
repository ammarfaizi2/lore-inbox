Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWEOWYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWEOWYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbWEOWYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:24:50 -0400
Received: from hera.kernel.org ([140.211.167.34]:8147 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965041AbWEOWYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:24:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: send(), sendmsg(), sendto() not thread-safe
Date: Mon, 15 May 2006 15:24:16 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e4av2g$ctj$1@terminus.zytor.com>
References: <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1147731856 13236 127.0.0.1 (15 May 2006 22:24:16 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 15 May 2006 22:24:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <OFE8460E54.0C8D85D8-ON8525716F.0074F22F-8825716F.0076D537@us.ibm.com>
By author:    Mark A Smith <mark1smi@us.ibm.com>
In newsgroup: linux.dev.kernel
>
> I discovered that in some cases, send(), sendmsg(), and sendto() are not
> thread-safe. Although the man page for these functions does not specify
> whether these functions are supposed to be thread-safe, my reading of the
> POSIX/SUSv3 specification tells me that they should be. I traced the
> problem to tcp_sendmsg(). I was very curious about this issue, so I wrote
> up a small page to describe in more detail my findings. You can find it at:
> http://www.almaden.ibm.com/cs/people/marksmith/sendmsg.html .
> 
> Thanks,
> Mark A. Smith
> 
> PS. I am using the term "thread" in the general sense, this is a problem
> independent of pthreads, etc. The problem occurs when two processes
> (whether or not they share an address space) send on the same socket (and
> some other low-resource conditions exist).
> 

User error.  Writes onto a streaming socket (or a pipe) are
thread-safe, *but not necessarily atomic*, if the size exceeds PIPE_BUF.

If you want atomicity you either have to do your own locking, or use a
DGRAM or SEQPACKET socket.

	-hpa

