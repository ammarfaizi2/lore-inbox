Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319186AbSH2LSZ>; Thu, 29 Aug 2002 07:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319189AbSH2LSZ>; Thu, 29 Aug 2002 07:18:25 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:53008 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319186AbSH2LSZ>;
	Thu, 29 Aug 2002 07:18:25 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208291122.g7TBMfa05527@oboe.it.uc3m.es>
Subject: Re: O_DIRECT
In-Reply-To: <200208291113.g7TBDut26852@tench.street-vision.com> from "kernel@street-vision.com"
 at "Aug 29, 2002 11:13:56 am"
To: kernel@street-vision.com
Date: Thu, 29 Aug 2002 13:22:41 +0200 (MET DST)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago kernel@street-vision.com wrote:"
> > What functions does a block driver have to implement in order to
> > support read/write when it has been opened with O_DIRECT from user
> > space.
> > 
> > I have made some experiments with plain read/write after opening with 
> > O_DIRECT:
> > 
> > 2.5.31:
> >    /dev/ram0      open fails
> >    file on ext2   r/w gives EINVAL
> >    /dev/hdaN      works
> > 
> > 2.4.19:
> >    /dev/ram0      r/w gives EINVAL
> >    file on ext2   r/w gives EINVAL
> >    /dev/hdaN      r/w gives EINVAL
> > 
> > WTF? It's not a library issue - strace shows the syscalls happening
> > with the right flag set on the open.
> 
> You should be able to get it to work on ext2. It works fine for me.
> Remeber that the memory you read/write from must be page aligned (ie
> mmap /dev/zero not malloc) and reads and writes must be multiples of the
> page size. I think block devices work on 2.4 too, but I forget (otherwise
> you can use raw devices).

Thanks for the input. Well, I used the same test program on all, and
the buffer was aligned at 512 bytes (because I intended it to work
with raw character devices too). You are saying that it was luck .. OK,
I'll retest in a little while.

So I simply have to do "nothing" in the driver?

Peter
