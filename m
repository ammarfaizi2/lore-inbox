Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVFWVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVFWVxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVFWVvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:51:09 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:36838 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262766AbVFWVrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:47:12 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1: BUG() in fd_install, RCU related?
Date: Thu, 23 Jun 2005 23:47:03 +0200
User-Agent: KMail/1.8.1
Cc: syrius.ml@no-log.org, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, bero@arklinux.org, sharyath@in.ibm.com
References: <20050621083424.GA2076@elf.ucw.cz> <874qbpwbae.873br9wbae@871x6twbae.message.id> <20050623190218.GA4999@in.ibm.com>
In-Reply-To: <20050623190218.GA4999@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506232347.04396.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 23 of June 2005 21:02, Dipankar Sarma wrote:
> On Thu, Jun 23, 2005 at 01:50:11PM +0200, syrius.ml@no-log.org wrote:
> > Dipankar Sarma <dipankar@in.ibm.com> writes:
> > 
> > > Some things are common - always with fcntl() or fcntl64() and with
> > > a daemon. Does your box come up at all ? If so, can you get me an
> > > strace on the process that triggers this ? If I can narrow it
> > > down to a small testcase, it would be a lot easier. Also, does
> > > switching off CONFIG_PREEMPT fix this problem ?
> > 
> > I haven't read about this thread. I hope u'll find a way to reproduce
> > it. here debian/sid i386 (.config sent in an earlier message), it 100%
> > reproducible when restarting bind9. (it also happens on its own on
> > different occasion)
> > 
> > 
> > then i restart the daemon:
> > 
> > end of a strace -f /etc/init.d/bind9 start
> > 6541  rt_sigaction(SIGPIPE, {0xb7ca2a70, [], 0}, {SIG_IGN}, 8) = 0
> > 6541  send(3, "<30>Jun 23 00:51:35 named[6540]:"..., 82, 0) = 82
> > 6541  rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
> > 6541  socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 10
> > 6541  fcntl64(10, F_DUPFD, 20)          = 32
> > 6541  close(10)                         = 0
> > 6541  fcntl64(32, F_GETFL)              = 0x2 (flags O_RDWR)
> > 6541  fcntl64(32, F_SETFL, O_RDWR|O_NONBLOCK) = 0
> > 6541  setsockopt(32, SOL_SOCKET, SO_TIMESTAMP, [1], 4) = 0
> > 6541  setsockopt(32, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > 6541  bind(32, {sa_family=AF_INET, sin_port=htons(53),
> > sin_addr=inet_addr("172.16.254.1")}, 16) = 0
> > 6541  socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 10
> > 6541  fcntl64(10, F_DUPFD, 20
> 
> Aha, this has been extremely helpful. Could you all please try the
> following (untested) patch ? This should fix the problem, or
> atleast one problem that I can see.

On my system the patch apparently fixes the problem.  Excellent job! :-)

Thanks,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
