Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSF0WbW>; Thu, 27 Jun 2002 18:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSF0WbV>; Thu, 27 Jun 2002 18:31:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18821 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317007AbSF0WbU>;
	Thu, 27 Jun 2002 18:31:20 -0400
Date: Thu, 27 Jun 2002 15:33:33 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: "Hurwitz Justin W." <hurwitz@lanl.gov>
cc: Nivedita Singhvi <niv@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: zero-copy networking & a performance drop
In-Reply-To: <Pine.LNX.4.44.0206271545220.17078-100000@alvie-mail.lanl.gov>
Message-ID: <Pine.LNX.4.33.0206271513320.13651-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002, Hurwitz Justin W. wrote:

> On Thu, 27 Jun 2002, Nivedita Singhvi wrote:
> 
> [ snip ]
> 
> > That said, rx has been slower than sends in most of our testing
> > too. 
> 
> Is this a documented/explained phemomenon? Or are you and I the only 
> people experiencing it? Do we have any idea as to its cause (or is it 
> inherent architecturally)? 
> 
> Cheers,
> --Gus


Well, briefly, completely speculatively, and possibly unhelpfully,

      - rx side processing can involve more work (stack length
        is simply longer) and so can legitimately take longer.
	This is especially true when options and out of order
	packets are involved, and TCP fast path processing
	on the rx side isnt taken. (I had done a breakdown 
	of this based on some profiles last year, but dont
	have that at the moment)

      - rx side reassembly could cause longer delays in the
        case of fragmentation

      - scheduler comes slightly more into play on the rx
        side for TCP, may be since we can put stuff on the backlog
	or prequeue q's (waiting for a recvmsg()) (??). this is
	again, very off the cuff and based on some profiles
	I had seen on send/rx side with rx side scheduler 
	showing up higher, and without having investigated 
	further at the time..(long time ago, dont quote me, etc..)

	
there are possibly many different scenario's here, and
I'm probably missing the most obvious causes...


thanks,
Nivedita

