Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRCAMST>; Thu, 1 Mar 2001 07:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCAMR7>; Thu, 1 Mar 2001 07:17:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:60377 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129155AbRCAMRx>;
	Thu, 1 Mar 2001 07:17:53 -0500
Date: Thu, 1 Mar 2001 12:14:18 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Martin Rauh <martin.rauh@gmx.de>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Writing on raw device with software RAID 0 is slow
Message-ID: <20010301121418.A7647@redhat.com>
In-Reply-To: <3A9D1202.9A1C403E@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9D1202.9A1C403E@gmx.de>; from martin.rauh@gmx.de on Wed, Feb 28, 2001 at 03:58:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 28, 2001 at 03:58:11PM +0100, Martin Rauh wrote:
> 
> Writing to an software RAID 0 containing 4 SCSI discs is very fast.
> I get transfer rates of about 100 MBytes/s. The filesystem on the RAID
> is ext2.
> 
> Writing to the same RAID directly (that means on the raw device without
> a filesystem) works
> but gives low transfer rates of about 31 MBytes/s.
> 
> Any explanation for that?

Raw IO is always synchronous: it gets flushed to disk before the write
returns.  You don't get any write-behind with raw IO, so the smaller
the blocksize you write in, the slower things get.

--Stephen
