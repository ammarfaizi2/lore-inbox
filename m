Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVCQNIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVCQNIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 08:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVCQNIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 08:08:39 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:55311 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262056AbVCQNIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 08:08:37 -0500
Date: Thu, 17 Mar 2005 14:07:14 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Berkley Shands <berkley@cs.wustl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devices/Partitions over 2TB
Message-ID: <20050317130714.GA5439@pclin040.win.tue.nl>
References: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:44:31AM -0600, Berkley Shands wrote:

> 	With a Broadcom BC4852 and suitable Sata drives, it is easy to create
> functional devices with well in excess of 2TB raw space. This presents a severe
> problem to partitioning tools, such as fdisk/cfdisk and the like as the
> kernel partition structure has a 32 bit integer max for sector counts. Since
> the read_int() function combined with cround() overflows, ...

You should not read fdisk source but think about the DOS-type partition table.
An entry in such a table describes partition start and end in CHS terms
using 24 bits for start and end, and describes partition start and size
in LBA terms using 32 bits for start and size. If you use sectors of size
512, that limits the use of DOS-type partition tables to disks of at most
2^41 bytes, that is, 2 TiB.

What to do afterwards? Last year I made a hack, reserving type 88 hex for
a Linux plaintext partition table. You must be able to find the kernel patch
somewhere on Google, otherwise ask. No fdisk required, the partition table
is just plaintext that you edit using emacs or vi.
The idea here is to use an ordinary DOS-type partition table for the start
of the disk, and let the type 88 partition describe the rest.

There is also the EFI/GPT disk descriptor that is common on IA64, but not much
used elsewhere. Maybe parted supports it.

Andries
