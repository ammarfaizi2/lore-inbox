Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268856AbUIXPp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268856AbUIXPp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUIXPp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:45:57 -0400
Received: from mx01.netapp.com ([198.95.226.53]:47539 "EHLO mx01.netapp.com")
	by vger.kernel.org with ESMTP id S268856AbUIXPmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:42:05 -0400
Message-ID: <4154404B.3070705@netapp.com>
Date: Fri, 24 Sep 2004 11:42:03 -0400
From: David Wysochanski <davidw@netapp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: reiserfs and SCSI oops seen in 2.6.9-rc2 with local SCSI disk
 IO
References: <4154372C.7070506@netapp.com> <20040924151828.GC16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040924151828.GC16153@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Sep 24, 2004 at 11:03:08AM -0400, David Wysochanski wrote:
>  > I can reproduce this pretty easily with local disk.
>  >
>  > Here's some details about my setup (attached is the
>  > full kernel config):
>  > - dell 2650 (dual xeon, hyperthreading disabled)
>  > - 1 local SCSI disk (root volume)
>  > - 2 local SCSI disks (data), each with 10 partitions
>  > of 100MB each, 6 of them reiserfs filesystems, 3 of them
>  > ext3, and 3 of them ext2 (total of 20 unique filesystems)
>  > - one instance of test program running on each of the
>  > 20 filesystems
> 
> I don't think this is a SCSI problem.  Your backtrace doesn't include
> anything in the SCSI subsystem (this doesn't _prove_ anything, but does
> suggest you should look elsewhere first).  You also didn't mention what
> SCSI controller you were using.  If you can reproduce the oops without
> using reiserfs at all, that would suggest the problem doesn't lie in
> reiserfs, but that's where I'd blame first ;-)
> 

I've been seeing a lot of problems with reiserfs that I
don't see on ext2 or ext3, so I would tend to agree with you.
Do you know where I could post for the reiserfs folks?

Did you see the backtrace for the second CPU?  It does
include SCSI and block subsystem components.


The controller on board the dell 2650 is Adaptec:

0000:02:06.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 24
         BIST result: 00
         I/O ports at cc00 [disabled] [size=fcc00000]
         Memory at fcd01000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at 00020000 [disabled]
         Capabilities: <available only to root>

0000:02:06.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
         Subsystem: Adaptec AHA-3960D U160/m
         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 25
         BIST result: 00
         I/O ports at c800 [disabled] [size=fcc00000]
         Memory at fcd00000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at 00020000 [disabled]
         Capabilities: <available only to root>

