Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279274AbRJaBtC>; Tue, 30 Oct 2001 20:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279112AbRJaBsm>; Tue, 30 Oct 2001 20:48:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:33541 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279105AbRJaBse>; Tue, 30 Oct 2001 20:48:34 -0500
Message-ID: <3BDF576F.3A797933@zip.com.au>
Date: Tue, 30 Oct 2001 17:44:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord from ext3
In-Reply-To: <20011031001846.A1840@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> 
> Hi all,
> 
> I have found a strange problem using cdrecord from an ext3 partition.
> When burning a cd image (about 500Mb), with cdrecord -v to see some info,
> after about 150Mb the percentage of fifo filled begins to drop, until the
> burning fails. I though it was related to some buffer/cache issue, but
> then I just copied the image to an ext2 partition (so the cache still
> filled more, just reaching my ram size), and burnt perfect from the
> ext2 partition.
> 
> So it looks like ext3 can not give a sustained read rate (not so much,
> burning was at 8x). Fifo from ext2 never dropped below 99%.
> 
> Is this a bug or the answer is just 'never toast from a journaled fs' ?

The ext3 read paths are basically identical to ext2.  The whole
journalling thing only gets involved with writes.

> Kernel: 2.4.13-ac5+bproc, controller is an Adaptec
> 

bproc?   scyld distributed process thing, or something else?

Something strange is happening.  Could you please investigate
further?  For example:

	dd if=/dev/zero of=foo bs-1024k count=600
	time cat foo > /dev/null

How long does the `cat' take on ext2 and ext3?

-
