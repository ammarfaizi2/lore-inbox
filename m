Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbRGGJjB>; Sat, 7 Jul 2001 05:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266074AbRGGJiw>; Sat, 7 Jul 2001 05:38:52 -0400
Received: from borg.metroweb.co.za ([196.23.181.81]:23046 "EHLO
	borg.metroweb.co.za") by vger.kernel.org with ESMTP
	id <S266069AbRGGJin>; Sat, 7 Jul 2001 05:38:43 -0400
From: Henry <henry@borg.metroweb.co.za>
To: Andrew Morton <andrewm@uow.edu.au>
Subject: Re: OOPS (kswapd) in 2.4.5 and 2.4.6
Date: Sat, 7 Jul 2001 11:33:25 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01070516412506.06182@borg> <01070708085101.00793@borg> <3B46C342.A27D6C50@uow.edu.au>
In-Reply-To: <3B46C342.A27D6C50@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01070711384402.00793@borg>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I wonder why it only affects you.  Is the drive which holds
> your swap partition running in PIO mode?  `hdparm' will tell
> you.  If it is, then that could easily cause the page to come
> unlocked before brw_page() has finished touching the buffer
> ring.  Then all it takes is a parallel try_to_free_buffers
> on the other CPU.

Here's output from htparm:

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2494/255/63, sectors = 40079088, start = 0

Does this provide the info you need?

I believe another chap responded to my post with a similar issue (also
SMP machine).

Uptime now 21:55 with no oops.

