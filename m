Return-Path: <linux-kernel-owner+w=401wt.eu-S1422779AbXAMU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422779AbXAMU7V (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbXAMU7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:59:21 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60097 "EHLO hera.cwi.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422779AbXAMU7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:59:20 -0500
Date: Sat, 13 Jan 2007 21:58:38 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Kris Karas <ktk@bigfoot.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.6 Partitioning bug with LILO
Message-ID: <20070113205838.GA2875@apps.cwi.nl>
References: <45A81728.6060405@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A81728.6060405@bigfoot.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 06:18:00PM -0500, Kris Karas wrote:
> Hello Andries,
> 
> I noticed you're listed as the maintainer for the disk
> geometry/partitioning logic in the 2.6 kernel, so I'm sending this to
> you, as I think this bug is most likely in that part of the code, ...
> 
> I've been bug-hunting with John Coffman to solve an issue where running
> LILO trashes the ext2 metadata on my /boot partition.  The consensus so
> far is that it's not LILO at all, but rather some subtle bug in the
> kernel that's the culprit.  I can reproduce it easily enough on 2.6, but
> not on 2.4, which further suggests its kernel-related.
> 
> If one does:
> 
> 	umount /boot
> 	e2fsck -f -y /dev/hda1
> 	mount /dev/hda1 /boot
> 	lilo
> 	umount /boot
> 	e2fsck -f -y /dev/hda1
> 
> the second run of e2fsck will report fixable block bitmap errors.

It is easy to see the cause of this.
There is an old problem with the Linux whole disk device /dev/hda
namely that there is aliasing with /dev/hdaN.
I don't know whether there exist kernels that fix this problem -
as far as I know this has been a problem since ancient times.

But, given the fact that this is a well-known problem of the kernel,
a utility should be careful to avoid problems and flush buffers
at appropriate times.

Now that lilo is one of the few utilities to write to /dev/hda,
it should be fixed.

[And yes, also the kernel should be fixed.]

Andries

[let me cc linux-kernel]
