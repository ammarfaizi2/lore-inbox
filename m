Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbRETCKQ>; Sat, 19 May 2001 22:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRETCJz>; Sat, 19 May 2001 22:09:55 -0400
Received: from lpce017.lss.emc.com ([168.159.62.17]:9220 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261330AbRETCJr>; Sat, 19 May 2001 22:09:47 -0400
Date: Sat, 19 May 2001 12:51:23 -0600
Message-Id: <200105191851.f4JIpNK00364@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu (Alexander Viro), clausen@gnu.org (Andrew Clausen),
        bcrl@redhat.com (Ben LaHaise), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E1517Jf-0008PV-00@the-village.bc.nu>
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu>
	<E1517Jf-0008PV-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > ioctls are evil, period. At least with these names you can use normal
> > scripting and don't need any special tools. Every ioctl means a binary
> > that has no business to exist.
> 
> That is not IMHO a rational argument. It isn't my fault that your
> shell does not support ioctls usefully. If you used perl as your
> login shell you would have no problem there.

There is another reason to use ioctl(2): when you need to send data to
the kernel/driver and wait for a response. It supports transactions,
which read(2) and write(2) cannot. Therefore it remains useful.

Al, if you really want to kill ioctl(2), then perhaps you should
implement a transaction(2) syscall. Something like:
    int transaction (int fd, void *rbuf, size_t rlen,
		     void *wbuf, size_t wlen);

Of course, there wouldn't be any practical gain, since we already have
ioctl(2). Any gain would be aesthetic.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
