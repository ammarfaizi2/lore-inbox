Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267549AbRGNAvs>; Fri, 13 Jul 2001 20:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbRGNAvi>; Fri, 13 Jul 2001 20:51:38 -0400
Received: from intranet.resilience.com ([209.245.157.33]:33480 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S267491AbRGNAvW>; Fri, 13 Jul 2001 20:51:22 -0400
Mime-Version: 1.0
Message-Id: <p0510030ab77546a455f2@[10.128.7.49]>
In-Reply-To: <200107132204.f6DM4TR3014602@webber.adilger.int>
In-Reply-To: <200107132204.f6DM4TR3014602@webber.adilger.int>
Date: Fri, 13 Jul 2001 17:49:55 -0700
To: Andreas Dilger <adilger@turbolinux.com>, Chris Wedgwood <cw@f00f.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:04 PM -0600 2001-07-13, Andreas Dilger wrote:
>**) As I said in my previous posting, it depends on if/how MD RAID does
>    write ordering of I/O to the data sector and the parity sector.  If
>    it holds back the parity write until the data I/O(s) are complete, and
>    trusts the data over parity on recovery, you should be OK unless you
>    have multiple failures (i.e. bad disk + crash).  If it doesn't do this
>    ordering, or trusts parity over data, then you are F***ed (I doubt it
>    would have this problem).

That wouldn't help, would it, if >1 data sectors were being written.

The fault mode of a sector simply not being written seems like a real 
weak point of both RAID-1 and RAID-5. Not that RAID-5 parity ever 
gets checked, I think, under normal circumstances, nor RAID-1 mirrors 
get compared, but if they were check and there was an parity or 
mirror-compare error and no other indication of a fault (eg CRC), 
there's no way to recover correct data.
-- 
/Jonathan Lundell.
