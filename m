Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136703AbREJOzR>; Thu, 10 May 2001 10:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136707AbREJOzH>; Thu, 10 May 2001 10:55:07 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:20747 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S136703AbREJOyw>; Thu, 10 May 2001 10:54:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Pekka Pietikainen <pp@evil.netppl.fi>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Date: Thu, 10 May 2001 16:42:50 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200105092125.f49LPew13300@jen.americas.sgi.com> <20010510131945.B11927@netppl.fi>
In-Reply-To: <20010510131945.B11927@netppl.fi>
MIME-Version: 1.0
Message-Id: <01051016425003.06492@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 May 2001 12:19, Pekka Pietikainen wrote:
> Here's some very unscientific numbers I've measured (ancient 4G SCSI
> drive on a dual pII/450), XFS 1.0-pre2 and reiserfs is
> the version in that kernel. The first bit is from tiobench, the
> multiple files one is a simple 30-line program that creates tons of
> 1k files and then removes them.
>
> XFS
>
> Create 20000 files: 116.882449
> Unlink 20000 files: 47.449201
>
> reiserfs
>
> Create 20000 files: 17.862143
> Unlink 20000 files: 9.487520
>
> ext2
>
> Create 20000 files: 248.758925
> Unlink 20000 files: 2.287174

Whoops!  The create test is exactly the case my index patch 
accelerates, trying it is highly recommended:

  http://nl.linux.org/~phillips/htree/dx.testme-2.4.3-3

To apply:

    cd source/tree
    zcat ext2-dir-patch-S4.gz | patch -p1
    cat dx.pcache-2.4.4 | patch -p0

Or for the all-in-page-cache version (needs Al Viro's patch, see the 
READ.ME at http://nl.linux.org/~phillips/htree/):

  http://nl.linux.org/~phillips/htree/dx.pcache-2.4.4-4

The testme version is easier to apply but the pcache version is more 
like what the final form will be (waiting for Al's patch to get into 
Linus's tree so I can de-fork this).

--
Daniel

