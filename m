Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRDJWIk>; Tue, 10 Apr 2001 18:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132387AbRDJWIa>; Tue, 10 Apr 2001 18:08:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49378 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132373AbRDJWIO>;
	Tue, 10 Apr 2001 18:08:14 -0400
Message-ID: <3AD3831E.EABAEE9E@sgi.com>
Date: Tue, 10 Apr 2001 15:03:10 -0700
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: BH_Req question
In-Reply-To: <3AD36912.1F9E0654@sgi.com> <20010410234258.B6030@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
	[ ... ]
> 
> BH_Req is never unset until the buffer is destroyed (put back on the freelist).
> BH_Req only says if such a buffer ever did any I/O yet or not. It is basically
> only used to deal with I/O errors in sync_buffers().

Interesting. Thanks for the explanation. Since submit_bh was setting BH_Req,
I was misled into thinking that end_io would unset it ...


> 
> > PS: In case why the question: I've got a system with tons of
> > pages with buffers marked BH_Req, so try_to_free_buffers() bails
> > out thinking that the buffer is busy ...
> 
> Either your debugging is wrong or you broke try_to_free_buffers because a
> buffer with BH_Req must still be perfectly freeable.


Okay, I got distracted by BH_Req, which I mistook to be in BUFFER_BUSY_BITS.
There was also BH_Lock set on the buffers, which would qualify for BUFFER_BUSY_BITS ...
so may be it is a buffer_locking problem somewhere.

cheers,

ananth.

--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
