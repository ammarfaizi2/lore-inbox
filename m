Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbRA0Lqa>; Sat, 27 Jan 2001 06:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130761AbRA0LqU>; Sat, 27 Jan 2001 06:46:20 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:53292 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130367AbRA0LqH>; Sat, 27 Jan 2001 06:46:07 -0500
Message-ID: <3A72B4D9.1FD0D281@linux.com>
Date: Sat, 27 Jan 2001 11:45:29 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/REQ] Increase kmsg buffer from 16K to 32K, kernel/printk.c
In-Reply-To: <200101271014.f0RAE0G04370@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:

> On Sat, 27 Jan 2001 08:01:14 +0000, David Ford <david@linux.com> wrote:
> > Does Linus or anyone object to raising the ksmg buffer from 16K to 32K?
> > 4/5 systems I have now overflow the buffer during boot before init is
> > even launched.
>
> Hmm, are you sure? man dmesg:
> [...]
>        -sbufsize
>               use  a  buffer  of bufsize to query the kernel ring
>               buffer.  This is 8196 by default (this matches  the
>               default  kernel  syslog  buffer  size in 2.0.33 and
>               2.1.103).  If you have set  the  kernel  buffer  to
>               larger  than  the  default  then this option can be
>               used to view the entire buffer.
>
> So try dmesg -s 16384. That's good enough for me on a 4-way SMP
> box with lots of SCSI on-board (and trust me, SMP generates a *huge*
> amount of kernel logging).

Well, as I said, the (current) 16K buffer is overflowed before init is
started.  Being that I'd like to review the first page or two of boot
messages, I have to increase this limit all the time.  The above man page
needs updated, the buffer size in 2.4.0 is 16K and it doesn't matter how
large you set the dmesg -s parameter, the kernel's buffer size is the most
you can retrieve from it.

-d


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
