Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTAHRF7>; Wed, 8 Jan 2003 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbTAHRF7>; Wed, 8 Jan 2003 12:05:59 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:64393 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267613AbTAHRF6>; Wed, 8 Jan 2003 12:05:58 -0500
Date: Wed, 8 Jan 2003 15:14:24 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: /var/lib/nfs/sm/ files
Message-ID: <20030108151424.N2628@blackjesus.async.com.br>
References: <20030107132743.E2628@blackjesus.async.com.br> <shsn0mcj3x8.fsf@charged.uio.no> <20030108095050.C22321@blackjesus.async.com.br> <200301081346.10335.trond.myklebust@fys.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301081346.10335.trond.myklebust@fys.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jan 08, 2003 at 01:46:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 01:46:10PM +0100, Trond Myklebust wrote:
> >     - Why do most entries' mtime get updated periodically, but a few of
> >       the entries go stale with time?
> 
> The file should get deleted every time the client releases all locks and 
> successfully manages to notify the server that it is stopping monitoring.

Aha, this makes a lot of sense. Then the leftover files I am getting are
probably a product of:

syslog:Jan  7 08:35:47 canario rpc.statd[101]: Received erroneous SM_UNMON request from canario for 192.168.99.4
syslog:Jan  7 09:09:37 canario rpc.statd[101]: Received erroneous SM_UNMON request from canario for 192.168.99.4
syslog:Jan  7 18:23:15 canario rpc.statd[101]: Received erroneous SM_UNMON request from canario for 192.168.99.4

It seems that rpc.statd itself isn't liking the request it's getting and
never forwards it to the server. I used to think these were harmless,
but now I wonder why would this be happening?

> >     - Why do some of the stale entries get left over even after the
> >       workstations have halted (these ones present the nfs hang issue)?
> 
> 
> As I've told you before: 'stale' entries, as you call them, indicate that the 

(Sorry, I am apparently clueless when it gets to these details.)

> rpc.statd never managed to notify the server that it should stop monitoring. 
> It indicates either the server or the client crashed before the POSIX locks 
> held by the client got released, or possibly that the rpc.statd processes 
> crashed (or got 'kill -9' ed).

But at least it seems that nobody has crashed - statd is running along
fine. Both server and clients run the same versions of the daemon, and
the fact that we get repeated messages (without restarting anybody)
should indicate that it is in fact running. 

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
