Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRHQRZj>; Fri, 17 Aug 2001 13:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271696AbRHQRZ3>; Fri, 17 Aug 2001 13:25:29 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:48630 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269387AbRHQRZS>; Fri, 17 Aug 2001 13:25:18 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 17 Aug 2001 11:25:25 -0600
To: Marc SCHAEFER <schaefer@alphanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Message-ID: <20010817112525.A17372@turbolinux.com>
Mail-Followup-To: Marc SCHAEFER <schaefer@alphanet.ch>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01081709381000.08800@haneman> <200108171632.SAA00941@vulcan.alphanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108171632.SAA00941@vulcan.alphanet.ch>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2001  18:32 +0200, Marc SCHAEFER wrote:
> Special care, as far as I understand it, must be taken when allocating
> fs data blocks. The following sequence must be followed:
> 
>    1. reserve them
>    2. clear them
>    3. mark them as allocated.
> 
> if 2 is too expensive, maybe it's sufficient to mark them as dirty
> and zero them in memory. But what happens if the system crashes, with
> the metadata to the disk (block allocated), but the data block not
> yet filled/zeroed ?

Ext2 and ext3 both do this already (with caveats).  Since ext2 doesn't
impose write ordering constraints, there is not a hard guarantee that
the data block makes it to disk before the metadata is updated.  If
you run ext3 in data=ordered or data=journal mode, then you do have
such a guarantee. 

If you run in data=writeback mode, you basically have the same
situation as ext2 (data may be written before or after the metadata).
This is the same as the _current_ reiserfs code, but there are
apparently patches available which allow data=ordered mode also.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

