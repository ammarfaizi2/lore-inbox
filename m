Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTAWSTY>; Thu, 23 Jan 2003 13:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbTAWSTY>; Thu, 23 Jan 2003 13:19:24 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:57816 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265523AbTAWSTY>;
	Thu, 23 Jan 2003 13:19:24 -0500
Date: Thu, 23 Jan 2003 18:28:31 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030123182831.GA8184@bjl1.asuk.net>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123172734.GA2490@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> Or, fix sys_poll(). With the +1, this means that sys_poll() would have
> a 1 in 1001 chance per second of returning one jiffie too early.

Nope.  Read the expression again.

> > poll(2) takes an int, but sys_poll() takes a long.
> > I think everyone is confused :)
> > The reason I suggested "long timeout" for ep_poll is because the
> > multiply in the expression:
> > 	jtimeout = (unsigned long)(timeout*HZ+999)/1000;
> > can overflow if you don't.  If you stick with the int, you'll need to
> > write:
> > 	jtimeout = (((unsigned long)timeout)*HZ+999)/1000;
> 
> On a 16 bit platform, perhaps... :-)

Nope.  It will overflow on a _64_ bit platform, if you give it a value
of MAXINT for example.

-- Jamie
