Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263608AbRFYEU1>; Mon, 25 Jun 2001 00:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265875AbRFYEUR>; Mon, 25 Jun 2001 00:20:17 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:6819 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S263608AbRFYEUB>; Mon, 25 Jun 2001 00:20:01 -0400
Message-ID: <3B36BC65.FF27BBB1@kegel.com>
Date: Sun, 24 Jun 2001 21:21:57 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Collapsing RT signals ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> wrote:
> I'm making some test with RT signals and looking at how they're implemented
> inside the kernel.
> After having experienced frequent queue overflow signals I looked at how
> signals are queued inside the task_struct.
> There's no signals optimization inside and this make the queue length depending
> on the request rate instead of the number of connections.
> It can happen that two ( or more ) POLL_IN signals are queued with a single
> read() that sweep the buffer leaving other signals to issue reads ( read this
> as user-mode / kernel-mode switch ) that will fail due lack of data.
> So for every "superfluous" signal we'll have two user-mode / kernel-mode
> switches, one for signal delivery and one for a failing read().
> I'm just thinking at a way to optimize the signal delivery that is ( draft ) :
> ...

I agree, the queue overflow case is a pain in the butt.

Before you get too far coding up your idea, have you read
http://marc.theaimsgroup.com/?l=linux-kernel&m=99023775430848&w=2
?  He's already implemented and benchmarked a variation on this
idea, maybe you could vet his code.  He has taken it a step
further than perhaps you were going to.

(See also http://www.kegel.com/c10k.html#nb.sigio )

- Dan
