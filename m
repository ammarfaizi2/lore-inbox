Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRBAPa0>; Thu, 1 Feb 2001 10:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130611AbRBAPaQ>; Thu, 1 Feb 2001 10:30:16 -0500
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:37116 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S130280AbRBAPaG>;
	Thu, 1 Feb 2001 10:30:06 -0500
Date: Thu, 1 Feb 2001 15:30:01 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Serious reproducible 2.4.x kernel hang
Message-ID: <20010201153000.C27009@sable.ox.ac.uk>
In-Reply-To: <Pine.LNX.4.30.0102011406210.14706-100000@ferret.lmh.ox.ac.uk> <20010201144052.B27009@sable.ox.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010201144052.B27009@sable.ox.ac.uk>; from mbeattie@sable.ox.ac.uk on Thu, Feb 01, 2001 at 02:40:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malcolm Beattie writes:
> Chris Evans writes:
> > I've just managed to reproduce this personally on 2.4.0. I've had a report
> > that 2.4.1 is also affected. Both myself and the other person who
> > reproduced this have SMP i686 machines, which may or may not be relevant.
> > 
> > To reproduce, all you need to do is get my vsftpd ftp server:
> > ftp://ferret.lmh.ox.ac.uk/pub/linux/vsftpd-0.0.9.tar.gz
[...]
> As in Chris' case, vzftpd was a zombie (so Foo-ScrollLock told me) and
> all other processes were looking OK in R or S state.

Mapping the addresses from whichever ScrollLock combination produced
the task list to symbols produces the call trace
 do_exit <- do_signal <- tcp_destroy_sock <- inet_ioctl <- signal_return

The inet_ioctl is odd there--vsftpd doesn't explicitly call ioctl
anywhere at all and the next function before it in memory is
inet_shutdown which looks more believable. I have checked I'm looking
at the right System.map but I suppose I may have mis-transcribed the
address when writing it down. vsftpd doesn't make use of signal
handlers except to unset some existing ones and a SIGALRM handler
which I don't think would have triggered. Something like a seg fault
may have caused it (I should have seen an oops if it had happened in
kernel space) perhaps?

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
