Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266074AbRGGJxn>; Sat, 7 Jul 2001 05:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266082AbRGGJxe>; Sat, 7 Jul 2001 05:53:34 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:43414 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266074AbRGGJxQ>; Sat, 7 Jul 2001 05:53:16 -0400
Message-ID: <3B46DC5C.76A3D7A5@uow.edu.au>
Date: Sat, 07 Jul 2001 19:54:36 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Henry <henry@borg.metroweb.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
In-Reply-To: <01070516412506.06182@borg> <01070708085101.00793@borg> <3B46C342.A27D6C50@uow.edu.au>,
		<3B46C342.A27D6C50@uow.edu.au> <01070711384402.00793@borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henry wrote:
> 
> >
> > I wonder why it only affects you.  Is the drive which holds
> > your swap partition running in PIO mode?  `hdparm' will tell
> > you.  If it is, then that could easily cause the page to come
> > unlocked before brw_page() has finished touching the buffer
> > ring.  Then all it takes is a parallel try_to_free_buffers
> > on the other CPU.
> 
> Here's output from htparm:
> 
> /dev/hda:
>  multcount    =  0 (off)
>  I/O support  =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 2494/255/63, sectors = 40079088, start = 0
> 
> Does this provide the info you need?

Bingo.  PIO mode -> synchronous writes in submit_bh().  Thanks.

> I believe another chap responded to my post with a similar issue (also
> SMP machine).

No, his oops was a bad inode state while trying to
release unused NFS client inodes.  Different bug :)

-
