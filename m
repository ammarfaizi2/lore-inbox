Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132439AbRCaQLl>; Sat, 31 Mar 2001 11:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132440AbRCaQLc>; Sat, 31 Mar 2001 11:11:32 -0500
Received: from elektra.higherplane.net ([203.37.52.137]:38016 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S132439AbRCaQLR>; Sat, 31 Mar 2001 11:11:17 -0500
Date: Sun, 1 Apr 2001 02:15:24 +1000
From: john slee <indigoid@higherplane.net>
To: Radu Greab <radu@netsoft.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug report: select on unconnected sockets
Message-ID: <20010401021524.A28831@higherplane.net>
In-Reply-To: <15045.64340.14915.404305@ix.netsoft.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15045.64340.14915.404305@ix.netsoft.ro>; from radu@netsoft.ro on Sat, Mar 31, 2001 at 06:44:20PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2001 at 06:44:20PM +0300, Radu Greab wrote:
> Sorry if this is already known: on a RH 7.0 system with kernel 2.4.2
> or 2.4.3, a select on an unconnected socket incorrectly says that the
> socket is ready for input and output. Of course, reading from the socket
> file descriptor returns -1 and errno is set to ENOTCONN as shown in
> the strace output:
> 
> socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
> select(4, [3], [3], [3], {0, 0})        = 2 (in [3], out [3], left {0, 0})
> read(3, 0xbffff668, 1024)               = -1 ENOTCONN (Transport endpoint is not connected)
> 
> I attached a small example program to reproduce the bug.

bleah.  which one is supposed to be right?

linux 2.4
---------
$ uname -a
Linux XXXXX 2.4.2-ac20 #8 Wed Mar 14 01:53:05 EST 2001 i686 unknown
$ ./t
select result=2
read: Transport endpoint is not connected

linux 2.2
---------
$ uname -a
Linux XXXXX 2.2.18 #1 Thu Dec 21 21:13:10 EST 2000 i586 unknown
$ ./t
select result=1

solaris
-------
$ uname -a
SunOS XXXXX 5.7 Generic_106541-07 sun4m sparc sun4m
$ ./t
select result=0

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
