Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291900AbSBNUzd>; Thu, 14 Feb 2002 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291889AbSBNUxJ>; Thu, 14 Feb 2002 15:53:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28685 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291900AbSBNUwI>;
	Thu, 14 Feb 2002 15:52:08 -0500
Message-ID: <3C6C2342.5044B738@zip.com.au>
Date: Thu, 14 Feb 2002 12:51:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alexander Moibenko <moibenko@fnal.gov>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
In-Reply-To: <Pine.SGI.4.31.0202140951330.3076325-100000@fsgi03.fnal.gov> from "Alexander Moibenko" at Feb 14, 2002 10:03:57 AM <E16bPqi-0000c5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > run my gdbm application and bonnie test on the same device.
> > When gdbm comes to the point when it calls fsync it delays for a long
> > time.
> 
> fsync on a very large file is very slow on the 2.2 kernels

This could very well be due to request allocation starvation.
fsync is sleeping in __get_request_wait() while bonnie keeps
on stealing all the requests.

Recall that patch you dropped on Tuesday? :)

> > result. IDE is even worse in our case. In the discussion it was also said
> > that fsync for 2.4.x is modified. But does it fix a problem?
> 
> 2.4 is a lot smarter about flushing only the things it needs to. That
> makes it dependant on the number of blocks to write not some embarrasingly
> large power of the file size

OBTW: It seems that fsync_inode_data_buffers() will livelock if
another process is writing to the same file.  gargh.

-
