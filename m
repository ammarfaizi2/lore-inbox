Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317270AbSFLL6A>; Wed, 12 Jun 2002 07:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317297AbSFLL57>; Wed, 12 Jun 2002 07:57:59 -0400
Received: from mons.uio.no ([129.240.130.14]:64958 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317270AbSFLL56>;
	Wed, 12 Jun 2002 07:57:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Simon Matthews <simon@paxonet.com>
Subject: Re: NFS Client mis-behaviour?
Date: Wed, 12 Jun 2002 13:57:45 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206102041020.11116-100000@spare> <4.3.1.2.20020611092415.031616a0@coremail>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206121357.45980.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 18:28, Simon Matthews wrote:

> Other packets were able to make it into and out of the machine: I could
> telnet/ssh/rlogin. The user could not interrupt the process, despite the
> fact that the mount options included "intr".

There is a well known problem with 'intr': if one process is waiting on the 
page lock, then there is no provision for interrupting (that's a known 
weakness with the MM layer).
Since taking the page lock is usually done by some process that wants to read 
from a page, the usual cause of such a hangup is the fact that some other 
process is in the middle of an NFS READ. For this reason, if you kill *all* 
READ operations (by doing 'killall -9 rpciod) then you can usually recover. 
That's something that is only possible for 'root' though...

> My point is that the use of half-duplex may prevent the NFS client from
> sending or receiving (probably sending) some packets. But, since the
> processes that caused the load had stopped doing anything and other packets
> were passing in and out, the NFS client should have been able to recover
> earlier.

As I said, all the client is required to do is to retry (unless it gets 
interrupted). I'm not sure what else you mean by 'recover' in the above 
sentence.

Cheers,
  Trond
