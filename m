Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSATV2l>; Sun, 20 Jan 2002 16:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSATV2c>; Sun, 20 Jan 2002 16:28:32 -0500
Received: from ns.suse.de ([213.95.15.193]:56591 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287189AbSATV2X>;
	Sun, 20 Jan 2002 16:28:23 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com.suse.lists.linux.kernel> <3C48607C.35D3DDFF@redhat.com.suse.lists.linux.kernel> <20020120201603.L21279@athlon.random.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Jan 2002 22:28:21 +0100
In-Reply-To: Andrea Arcangeli's message of "20 Jan 2002 20:21:39 +0100"
Message-ID: <p734rlg90ga.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:
> 
> if you read in chunks of a few mbytes per read syscall, the lack of
> readahead shouldn't make much difference (this is true for both raid and
> standalone device). If there's a relevant difference it's more liekly an
> issue with the blocksize.

The problem with that is that doing overlapping IO requires much more
effort (you need threads in user space). If you don't do overlapping
IO you add a latency bubble for each round trip to user space after you
read one big chunk and submitting the request for the next big chunk.
Your disk will not be constantly streaming, because of these pauses where
it doesn't have an request to process. 
The application could do it using some aio setup, but it gets rather
complicated and the kernel already knows how to do that well.

I think an optional readahead mode for O_DIRECT would be useful. 

-Andi
