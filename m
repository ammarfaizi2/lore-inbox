Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbSIRU3l>; Wed, 18 Sep 2002 16:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268261AbSIRU3l>; Wed, 18 Sep 2002 16:29:41 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:14588 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268253AbSIRU3j>; Wed, 18 Sep 2002 16:29:39 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 18 Sep 2002 14:32:47 -0600
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support tera byte disk
Message-ID: <20020918203247.GS13929@clusterfs.com>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20020918131120.A5120@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918131120.A5120@lucon.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2002  13:11 -0700, H. J. Lu wrote:
> For a 1.8TB SCSI HD, kernel reports:
> 
> SCSI device sda: -773086208 512-byte hdwr sectors (-395819 MB)
> 
> Here is a patch to fix it. BTW, I don't think it will work with > 2TB,
> which requires bigger changes.

There's also a limit where statfs() overflows at 16TB for 4kB block
filesystems...  Ask me how I noticed this ;-)

Luckily, it is easy to upshift f_blksz and downshift f_blocks, f_bfree,
and f_bavail to get the data through the statfs interface, and df does
the reverse on the other side.  It makes sense to show a larger block
size anyways, so apps potentially do larger I/O requests.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

