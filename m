Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTIJOF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 10:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTIJOF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 10:05:28 -0400
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:28319 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264500AbTIJOFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 10:05:22 -0400
Subject: Re: [ANNOUNCE] New hardware - SGA155D dual STM-1/OC3 PCI ad
From: Stewart Smith <stewart@linux.org.au>
To: Horvath Gyorgy <HORVAATH@tmit.bme.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1063119321.30379.19.camel@dhcp23.swansea.linux.org.uk>
References: <200309091428.h89ES0Oe015172@alpha.ttt.bme.hu>
	 <1063119321.30379.19.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1063202707.7632.25.camel@willster>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 11 Sep 2003 00:05:08 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-10 at 00:55, Alan Cox wrote:
> > 4. Optionally - and if I have enough time - I'd like
> >    to develop a twin-linear filesystem driver for
> >    time-stamped capture/playback for multiple channels
> >    of data - like a multi-band magnetic tape.
> >    BTW do you know an existing one?
> 
> I've seen people do this in user space (just interleaving the disk in
> big chunks in the app and driving it with O_DIRECT raw access) but not
> in kernel file system space.

(from memory) I think that ext2/ext3 does (or at least did) this - they
lacked any smart logic for rapid allocations - at least for inodes in
the same cylinder group. I think this was mentioned in the "Journaling
the ext2 filesystem" paper.

This could probably be faked by taking out any intelligence in block
allocation (allocate last block+1 or some such thing). Even as a mount
option (seq_alloc), this could be useful (for this type of streaming).
This will give you great write throughput, but if you don't read things
off the same way you read them - reading is going to suck.

I read in a discussion of multimedia filesystems (for PVRs) that a block
size of 256KB helped in throughput when playback configurations weren't
known (the more data you read before seeking the better). google for
"multimedia filesystems" - you'll find a fair few papers on such things.

Things like XFS were designed for large, high bandwidth systems, so
that's also worth looking into as a zero-effort approach :)

