Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbRBFUln>; Tue, 6 Feb 2001 15:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRBFUld>; Tue, 6 Feb 2001 15:41:33 -0500
Received: from colorfullife.com ([216.156.138.34]:54536 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130355AbRBFUlV>;
	Tue, 6 Feb 2001 15:41:21 -0500
Message-ID: <3A806177.59304E88@colorfullife.com>
Date: Tue, 06 Feb 2001 21:41:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben LaHaise <bcrl@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise wrote:
> 
> On Tue, 6 Feb 2001, Ingo Molnar wrote:
> 
> >
> > On Tue, 6 Feb 2001, Ben LaHaise wrote:
> >
> > > This small correction is the crux of the problem: if it blocks, it
> > > takes away from the ability of the process to continue doing useful
> > > work.  If it returns -EAGAIN, then that's okay, the io will be
> > > resubmitted later when other disk io has completed.  But, it should be
> > > possible to continue servicing network requests or user io while disk
> > > io is underway.
> >
> > typical blocking point is waiting for page completion, not
> > __wait_request(). But, this is really not an issue, NR_REQUESTS can be
> > increased anytime. If NR_REQUESTS is large enough then think of it as the
> > 'absolute upper limit of doing IO', and think of the blocking as 'the
> > kernel pulling the brakes'.
> 
> =)  This is what I'm seeing: lots of processes waiting with wchan ==
> __get_request_wait.  With async io and a database flushing lots of io
> asynchronously spread out across the disk, the NR_REQUESTS limit is hit
> very quickly.
>
Has that anything to do with kiobuf or buffer head?

Several kernel functions need a "dontblock" parameter (or a callback, or
a waitqueue address, or a tq_struct pointer). 

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
