Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287831AbSBCW2x>; Sun, 3 Feb 2002 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287833AbSBCW2h>; Sun, 3 Feb 2002 17:28:37 -0500
Received: from elin.scali.no ([62.70.89.10]:34319 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S287831AbSBCW2P>;
	Sun, 3 Feb 2002 17:28:15 -0500
Message-ID: <3C5DB965.643661F2@scali.com>
Date: Sun, 03 Feb 2002 23:27:49 +0100
From: Steffen Persvold <sp@scali.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Short question regarding generic_make_request()
In-Reply-To: <3C5D3BC9.CA9E24A@scali.com> <Pine.LNX.4.33.0202031632580.11943-100000@localhost.localdomain> <20020203143946.H29553@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Sun, Feb 03 2002, Ingo Molnar wrote:
> >
> > On Sun, 3 Feb 2002, Steffen Persvold wrote:
> >
> > > Can generic_make_request() be called from interrupt level (or tasklet)
> > > ?
> >
> > no.
> 
> In theory, READA from interrupt context would be ok, though. That
> doesn't work in real-life due to the non flag saving spin locking in
> __make_request.
> 

Ok, the reason I'm asking is that I receive a request from a remote machine on interrupt level
(tasklet) and want to submit this to the local device. The reason I'm using a tasklet instead of a
kernel thread is that somewhere between RedHat's 2.4.3-12 and 2.4.9-12 kernels the latency of waking
up a kernel thread increased (using a semaphore method similar to the one used in loop.c). I don't
know why this happened, but I guess that if I still could use a kernel thread there wouldn't be any
problems using generic_make_request().

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency
