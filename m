Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRCaQ1c>; Sat, 31 Mar 2001 11:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132464AbRCaQ1W>; Sat, 31 Mar 2001 11:27:22 -0500
Received: from ix.netsoft.ro ([193.226.123.26]:31497 "EHLO ix.netsoft.ro")
	by vger.kernel.org with ESMTP id <S132434AbRCaQ1K>;
	Sat, 31 Mar 2001 11:27:10 -0500
From: Radu Greab <radu@netsoft.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15046.1304.603591.678566@ix.netsoft.ro>
Date: Sat, 31 Mar 2001 19:26:00 +0300 (EEST)
To: john slee <indigoid@higherplane.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug report: select on unconnected sockets
In-Reply-To: <20010401021524.A28831@higherplane.net>
In-Reply-To: <15045.64340.14915.404305@ix.netsoft.ro>
	<20010401021524.A28831@higherplane.net>
X-Mailer: VM 6.75 under 21.1 (patch 4) "Arches" XEmacs Lucid
Organization: NetSoft srl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001 02:15 +1000, john slee wrote:
 > On Sat, Mar 31, 2001 at 06:44:20PM +0300, Radu Greab wrote:
 > > Sorry if this is already known: on a RH 7.0 system with kernel 2.4.2
 > > or 2.4.3, a select on an unconnected socket incorrectly says that the
 > > socket is ready for input and output. Of course, reading from the socket
 > > file descriptor returns -1 and errno is set to ENOTCONN as shown in
 > > the strace output:
 > > 
 > > socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
 > > select(4, [3], [3], [3], {0, 0})        = 2 (in [3], out [3], left {0, 0})
 > > read(3, 0xbffff668, 1024)               = -1 ENOTCONN (Transport endpoint is not connected)
 > > 
 > > I attached a small example program to reproduce the bug.
 > 
 > bleah.  which one is supposed to be right?

I think that the Solaris one is right.

 > 
 > linux 2.4
 > ---------
 > $ uname -a
 > Linux XXXXX 2.4.2-ac20 #8 Wed Mar 14 01:53:05 EST 2001 i686 unknown
 > $ ./t
 > select result=2
 > read: Transport endpoint is not connected

Select says that the socket is ready for both input and output. A read
results in ENOTCONN, a write results in EPIPE.

 > linux 2.2
 > ---------
 > $ uname -a
 > Linux XXXXX 2.2.18 #1 Thu Dec 21 21:13:10 EST 2000 i586 unknown
 > $ ./t
 > select result=1

Select says that the socket is ready for output, but a write results
in EPIPE.

 > 
 > solaris
 > -------
 > $ uname -a
 > SunOS XXXXX 5.7 Generic_106541-07 sun4m sparc sun4m
 > $ ./t
 > select result=0

And Digital Unix is right too:

$ uname -a
OSF1 XXX V4.0 1229 alpha
$ ./a.out
select result=0


Thanks,
Radu Greab
