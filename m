Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDPRbU>; Mon, 16 Apr 2001 13:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRDPRbK>; Mon, 16 Apr 2001 13:31:10 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:34018 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131665AbRDPRay>; Mon, 16 Apr 2001 13:30:54 -0400
Message-ID: <3ADB2B38.90EBF599@uow.edu.au>
Date: Mon, 16 Apr 2001 10:26:16 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rw_semaphores
In-Reply-To: <Pine.LNX.4.31.0104092242320.11520-100000@penguin.transmeta.com> <8623.986888854@warthog.cambridge.redhat.com>,
		<8623.986888854@warthog.cambridge.redhat.com>; from dhowells@cambridge.redhat.com on Tue, Apr 10, 2001 at 08:47:34AM +0100 <20010416083912.C4036@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:
> 
> On Tue, Apr 10, 2001 at 08:47:34AM +0100, David Howells wrote:
> >
> > Since you're willing to use CMPXCHG in your suggested implementation, would it
> > make it make life easier if you were willing to use XADD too?
> >
> > Plus, are you really willing to limit the number of readers or writers to be
> > 32767? If so, I think I can suggest a way that limits it to ~65535 apiece
> > instead...
> 
> I'm trying to imagine a case where 32,000 sharing a semaphore was anything but a
> major failure and I can't. To me: the result of an attempt by the 32,768th locker
> should be a kernel panic. Is there a reasonable scenario where this is wrong?
> 

It can't happen (famous last words).

- It is a bug for a task to acquire an rwsem more than once
  (either for read or write), so we don't do this.

- Linux only supports, err, 31700 user processes.
