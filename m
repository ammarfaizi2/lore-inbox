Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290125AbSBOQsl>; Fri, 15 Feb 2002 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290156AbSBOQsc>; Fri, 15 Feb 2002 11:48:32 -0500
Received: from pc-80-195-34-114-ed.blueyonder.co.uk ([80.195.34.114]:15747
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S290125AbSBOQs0>; Fri, 15 Feb 2002 11:48:26 -0500
Date: Fri, 15 Feb 2002 16:48:09 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Moibenko <moibenko@fnal.gov>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: fsync delays for a long time.
Message-ID: <20020215164809.A5074@redhat.com>
In-Reply-To: <3C6C2342.5044B738@zip.com.au> <E16bT7y-00017B-00@the-village.bc.nu> <3C6C2A39.38ED19B1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6C2A39.38ED19B1@zip.com.au>; from akpm@zip.com.au on Thu, Feb 14, 2002 at 01:20:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 14, 2002 at 01:20:57PM -0800, Andrew Morton wrote:

> I'm surprised.  ext2's fsync in 2.2 is in fact quite optimal: a single
> pass across the block tree, in probable-LBA-order.

Except that it pages the entire indirect tree into memory, which is
_really_ painful if you're just appending to the end of a 1GB file.
See ext2_sync_file(): in 2.2 it uses the indirect tree to locate all
possible buffer_heads which might need flushing, and then it does a
buffer cache lookup for every block in the file.  It's _way_
suboptimal for large files, just in terms of the CPU cost and memory
cost of maintaining and walking the block tree.

2.4 doesn't need to search physically for dirty buffers, so is much
much faster.

Cheers,
 Stephen
