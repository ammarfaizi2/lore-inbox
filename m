Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265450AbRFVP6C>; Fri, 22 Jun 2001 11:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265451AbRFVP5w>; Fri, 22 Jun 2001 11:57:52 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:4356
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S265450AbRFVP5k>; Fri, 22 Jun 2001 11:57:40 -0400
Date: Fri, 22 Jun 2001 12:57:24 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: <NFS@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>
Subject: Re: [NFS] NFS insanity
In-Reply-To: <shsvgloisc2.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.32.0106221247390.183-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 2001, Trond Myklebust wrote:

> I'm a bit surprised about your choice or rsize and wsize. Although it
> shouldn't make any difference, 3072 is not a natural size on an x86
> machine. You usually want something that divides PAGE_CACHE_SIZE=4096.
> Furthermore, on the Linux NFS client, any value < PAGE_CACHE_SIZE
> means that you use synchronous writes (deferred writes are enabled
> with wsize=4096 or greater).

Trond, your command was very much appreciated. I got to this value after
stress testing the network install in the office: anything above that
value caused massive collisions on the hub and I just thought it would be
unhealthy to be forcing this sort of bustage onto the wire. 1 and 2k
performed worse, and 4k causing collisions, I chose 3k. The tests
consisted of doing compiles and simple file operations (reading large mail
folders, in addition), which is what users doing everyday work here and
evaluating the performance of the filesystem look for.

I'm not _entirely_ sure my tests were sane, but is this a reasonable
explanation?

> The advantage in this case though, is that it means any error message
> that was returned by the server was guaranteed to have been received
> by 'cp', because the page was written to the server immediately.

And no error was reported; it was completely silent. I can no longer
reproduce this after the power outage we had yesterday forced a reboot on
the client. *sigh* It would have been nice to find out what it was.

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311


