Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUBPDry (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUBPDry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:47:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35481 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265352AbUBPDrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:47:51 -0500
Message-ID: <40303D59.4030605@pobox.com>
Date: Sun, 15 Feb 2004 22:47:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chip Salzenberg <chip@pobox.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com>
In-Reply-To: <20040216033740.GE3789@perlsupport.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> Still: I wonder if the occasional bad sector is really that bad.
> Shirley, at the unreal densities of today's drives, the development of
> bad sectors is inevitable?  (Especially in a laptop drive that's
> bounced around in normal use.)

Open argument :)

A lot of smart people will argue that a bad sector every now and again 
occurs, and "I've run my server's disks that way for years."

Other equally smart people argue that modern IDE disks reserve space for 
remapping bad sectors.  If you run out of sectors that the drive is 
willing to silently remap for you, you should toss the disk and buy a 
new one.

There is of course the caveat that it is impossible to avoid the drive 
returning "bad sector", instead of silently remapping, on reads.

Oh, and I just thought of something else.  Current Linux filesystems 
will, on a read error, usually mark it as a bad sector and move on. 
Really, they should attempt to write to the bad sector before 
considering it bad.

As a result, current kernels will AFAICT assume a sector is bad even 
when the drive politely swaps a good sector in place for you.

One for the todo list, I suppose...  a useable workaround for this is 
probably good ole 'e2fsck -c', i.e. badblocks...  That says "check again 
to see if this sector is bad", and -hopefully- will unmark bad blocks 
that were incorrectly marked bad.

	Jeff



