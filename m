Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUBPTao (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBPTao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:30:44 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:54444 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265851AbUBPT1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:27:55 -0500
Date: Mon, 16 Feb 2004 12:27:41 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chip Salzenberg <chip@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Message-ID: <20040216192741.GA22218@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Chip Salzenberg <chip@pobox.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com> <40303D59.4030605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40303D59.4030605@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15 at 22:47, Jeff Garzik wrote:
>Chip Salzenberg wrote:
>>Still: I wonder if the occasional bad sector is really that bad.
>>Shirley, at the unreal densities of today's drives, the development of
>>bad sectors is inevitable?  (Especially in a laptop drive that's
>>bounced around in normal use.)
>
>Open argument :)
>
>A lot of smart people will argue that a bad sector every now and again 
>occurs, and "I've run my server's disks that way for years."
>
>Other equally smart people argue that modern IDE disks reserve space for 
>remapping bad sectors.  If you run out of sectors that the drive is 
>willing to silently remap for you, you should toss the disk and buy a 
>new one.

Yes, definitely.  There are a *lot* of spare sectors on a modern IDE
drive -- Running out of spares is an extremely rare event, and usually
indicates that the drive has been operating in severe conditions for
its lifetime.  (>55C + vibe sorts of things)

>There is of course the caveat that it is impossible to avoid the drive 
>returning "bad sector", instead of silently remapping, on reads.

Yes, because at that point, there's nothing to remap.  If the drive
couldn't read it, and knows it isn't in its 2/8MB cache, remapping is
pointless until there is known-good data to apply.  Therefore, only on
the write is there a good reason to examine and possibly remap an LBA.

>Oh, and I just thought of something else.  Current Linux filesystems 
>will, on a read error, usually mark it as a bad sector and move on. 
>Really, they should attempt to write to the bad sector before 
>considering it bad.
>
>As a result, current kernels will AFAICT assume a sector is bad even 
>when the drive politely swaps a good sector in place for you.
>
>One for the todo list, I suppose...  a useable workaround for this is 
>probably good ole 'e2fsck -c', i.e. badblocks...  That says "check again 
>to see if this sector is bad", and -hopefully- will unmark bad blocks 
>that were incorrectly marked bad.

Agreed.

In most cases, a simpe write to the supposedly-defective LBA will get
the drive to resolve whether it is a permanent media defect that needs
to be remapped, or else functional media that has gone bad for some
other reason. (of which there are several... excessive cold/heat,
vibration, poor power, etc)


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

