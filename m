Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSJOSvr>; Tue, 15 Oct 2002 14:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSJOSvr>; Tue, 15 Oct 2002 14:51:47 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:31982 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261645AbSJOSvg>; Tue, 15 Oct 2002 14:51:36 -0400
Date: Tue, 15 Oct 2002 14:57:31 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Dan Kegel <dank@kegel.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021015145731.J14596@redhat.com>
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com> <3DAC59ED.2070405@watson.ibm.com> <3DAC643C.86A016B4@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DAC643C.86A016B4@kegel.com>; from dank@kegel.com on Tue, Oct 15, 2002 at 11:53:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:53:48AM -0700, Dan Kegel wrote:
> Seems like the thing to do is to move /dev/epoll over to use
> Ben's event system rather than worry about the old /dev/epoll interface.
> But like signal-per-fd, we will want to collapse readiness events,
> which is something Ben's event system might not do naturally.
> (I wouldn't know -- I haven't actually looked at Ben's code.)

If you look at how /dev/epoll does it, the collapsing of readiness 
events is very elegant: a given fd is only allowed to report a change 
in its state once per run through the event loop.  The ioctl that swaps 
event buffers acts as a barrier between the two possible reports.

As to how this would interact with the aio event loops, I thought the 
"barrier" syscall could be the point at which aio event slots are reserved 
and freed.  Interest registration would be the other syscall (which would 
naturally have to reserve an event for the descriptor in the current set 
of readiness notifications).  Anyways, just a few thoughts...

		-ben
-- 
"Do you seek knowledge in time travel?"
