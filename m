Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279424AbRJWNdQ>; Tue, 23 Oct 2001 09:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279426AbRJWNdG>; Tue, 23 Oct 2001 09:33:06 -0400
Received: from euston.inpharmatica.co.uk ([193.115.214.6]:58356 "EHLO
	sunsvr03.inpharmatica.co.uk") by vger.kernel.org with ESMTP
	id <S279424AbRJWNct>; Tue, 23 Oct 2001 09:32:49 -0400
Message-ID: <3BD571A1.1000009@purplet.demon.co.uk>
Date: Tue, 23 Oct 2001 14:33:21 +0100
From: Mike Jagdis <jaggy@purplet.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, fr, de
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Behavior of poll() within a module
In-Reply-To: <Pine.LNX.3.95.1011023085214.9875A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> What is the intended behavior of poll within a module when
> two or more tasks are sleeping in poll? Specifically, when
> wake_up_interruptible is executed from a module, are all
> tasks awakened or is only one? If only one, is it the
> first task to call poll/select or the last, which is awakened
> first? 

Normally all but... In the case of accept() the kernel knows
that a woken up process will service the event (the code is
all in the kernel) so the accept code flags its wait_queue
entry to say, "If this gets woken don't wake the rest".
Unfortunately the way wake one and wake all semantics are
handled within the wait queue mean we get FIFO rather than
LIFO behaviour I believe :-(

I guess you could do "the accept() thing" yourself from a
module - or add a Linux specific poll flag and do it from
user space for that matter.

Oh, and yes, wake all is required behaviour of poll/select.
It's just accept that is special because all the code is in
the kernel and if it gets woken we _know_ that event is no
longer present.

				Mike

