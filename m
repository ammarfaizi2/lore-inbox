Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318349AbSGZSzY>; Fri, 26 Jul 2002 14:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318412AbSGZSzX>; Fri, 26 Jul 2002 14:55:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318349AbSGZSzX>;
	Fri, 26 Jul 2002 14:55:23 -0400
Message-ID: <3D419B59.E99F74DC@zip.com.au>
Date: Fri, 26 Jul 2002 11:56:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Steven Cole <scole@lanl.gov>
Subject: Re: 2.5.28, dbench results with ext3 significantly lower than with ext2.
References: <1027701923.3148.10.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> I found that dbench gives significantly lower numbers when
> the partition on which it is run is mounted as ext3.
> 

ext2 will force writeback when 40% of ZONE_NORMAL is dirty.
That's normally >300 megabytes.

ext3 will force writeback when 75% of the journal space is 
consumed by metadata.  That's normally 24 megabytes.

dbench generates a storm of metadata and data and then deletes it all.
It consumes the journal space almost immediately and forces ext3
to do a lot of writeback.  ext2 benefits because most of the metadata
and data are deleted before they ever touch disk.

If your application generates unusually high volumes of metadata
and data and then immediately deletes it, ext3 may not be an
appropriate filesystem.

-
