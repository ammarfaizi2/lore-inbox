Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTAHMkU>; Wed, 8 Jan 2003 07:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTAHMkU>; Wed, 8 Jan 2003 07:40:20 -0500
Received: from pat.uio.no ([129.240.130.16]:20161 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267099AbTAHMkT>;
	Wed, 8 Jan 2003 07:40:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Christian Reis <kiko@async.com.br>
Subject: Re: /var/lib/nfs/sm/ files
Date: Wed, 8 Jan 2003 13:46:10 +0100
User-Agent: KMail/1.4.3
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030107132743.E2628@blackjesus.async.com.br> <shsn0mcj3x8.fsf@charged.uio.no> <20030108095050.C22321@blackjesus.async.com.br>
In-Reply-To: <20030108095050.C22321@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301081346.10335.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 January 2003 12:50, Christian Reis wrote:
>     - Why don't all the diskless workstations get an entry in that
>       directory while they are running? Right now I have 5 running, and
>       only one has an entry there.

...because only clients that are currently holding POSIX locks will have an 
entry.

>     - Why do most entries' mtime get updated periodically, but a few of
>       the entries go stale with time?

The file should get deleted every time the client releases all locks and 
successfully manages to notify the server that it is stopping monitoring.

>     - Why do some of the stale entries get left over even after the
>       workstations have halted (these ones present the nfs hang issue)?


As I've told you before: 'stale' entries, as you call them, indicate that the 
rpc.statd never managed to notify the server that it should stop monitoring. 
It indicates either the server or the client crashed before the POSIX locks 
held by the client got released, or possibly that the rpc.statd processes 
crashed (or got 'kill -9' ed).

Cheers,
  Trond
