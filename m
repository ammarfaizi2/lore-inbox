Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbRGORpL>; Sun, 15 Jul 2001 13:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbRGORpC>; Sun, 15 Jul 2001 13:45:02 -0400
Received: from geos.coastside.net ([207.213.212.4]:15501 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S266730AbRGORox>; Sun, 15 Jul 2001 13:44:53 -0400
Mime-Version: 1.0
Message-Id: <p0510031cb7778611bd3f@[207.213.214.37]>
In-Reply-To: <20010716032220.B10635@weta.f00f.org>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
 <0107142211300W.00409@starship> <20010715153607.A7624@weta.f00f.org>
 <01071515442400.05609@starship> <20010716023911.A10576@weta.f00f.org>
 <p05100317b7775fc2bd15@[207.213.214.37]>
 <20010716032220.B10635@weta.f00f.org>
Date: Sun, 15 Jul 2001 10:44:28 -0700
To: Chris Wedgwood <cw@f00f.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:22 AM +1200 2001-07-16, Chris Wedgwood wrote:
>On Sun, Jul 15, 2001 at 08:06:39AM -0700, Jonathan Lundell wrote:
>
>     At first glance, by the way, the only write barrier I see in the
>     SCSI command set is the synchronize-cache command, which completes
>     only after all the drive's dirty buffers are written out. Of
>     course, without write caching, it's not an issue.
>
>Is the spec you have distributable? I believe some of the early drafts
>were, but the final spec isn't.
>
>I'd really like to check it out myself, I alwasy assumed SCSI had the
>smarts for write-barriers and force-unit-access but I guess I was
>wrong.
>
>Anyhow, I'd like to see the spec for myself if it is something I can
>get hold of.

I was referring to IBM's spec, as implemented in their recent SCSI 
and FC drives. You can find a copy at 
http://www.storage.ibm.com/techsup/hddtech/prodspec/ddyf_spi.pdf

WRITE EXTENDED has a bit (FUA) that will let you force that 
particular write to go to disk immediately, independent of write 
caching, but there's no suggestion that it otherwise acts as a write 
barrier for cached writes.

WRITE VERIFY implies a CACHE SYNCHRONIZE, so it's a write barrier, 
but an expensive (because synchronous) one.
-- 
/Jonathan Lundell.
