Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289149AbSAGIzN>; Mon, 7 Jan 2002 03:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289144AbSAGIzE>; Mon, 7 Jan 2002 03:55:04 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41480 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289146AbSAGIyt>; Mon, 7 Jan 2002 03:54:49 -0500
Message-ID: <3C39611A.F5C9BD3@zip.com.au>
Date: Mon, 07 Jan 2002 00:49:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <3C395A2C.B7A24844@zip.com.au> <Pine.LNX.4.33.0201070933590.4076-100000@lola.stud.fh-heilbronn.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Paukstadt wrote:
> 
> Heavy traffic on ext3 seems to cause short system freezes.

This could be due to disk request elevator latency and VM imbalance.
Your application has a page dropped due to the competing write activity,
and it takes ages to be restored, due to the write activity.
 
> Seems only to happen on 2 or more processor boxes.

In which case the above theory is wrong.
 
> I'm not deep into kernel nor ext3, but how is the journal flushed if
> full?

Nothing special, really - we just pump a stream of data out to disk.
While this is happening, other processes can still attach data to the
journal without getting blocked.  Up to a point.  Our handling of this
is a bit sudden at present.  Some people have reported benefit from
radically decreasing the buffer flushtimes. See Daniel Robbins' article
at http://www-106.ibm.com/developerworks/linux/library/l-fs8/ for this.
Yes, improvements are needed in this area.  Not only in ext3.

You haven't really defined "freeze", but it's certainly different
from Matti's freeze.

-
