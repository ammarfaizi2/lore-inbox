Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUECRyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUECRyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUECRyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:54:38 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:64145 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263804AbUECRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:54:28 -0400
Date: Mon, 3 May 2004 11:54:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mcs@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040503175425.GL1334@schnapps.adilger.int>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mcs@stanford.edu,
	Madanlal S Musuvathi <madan@stanford.edu>,
	"David L. Dill" <dill@cs.stanford.edu>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU> <20040427074455.GD30529@schnapps.adilger.int> <20040503141001.GA23656@wohnheim.fh-wedel.de> <20040503161606.GJ1334@schnapps.adilger.int> <20040503173320.GA10655@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040503173320.GA10655@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 03, 2004  19:33 +0200, Jörn Engel wrote:
> On Mon, 3 May 2004 10:16:06 -0600, Andreas Dilger wrote:
> > If that's what you want, then mount the filesystem with "errors=remount-ro"
> > and you will get it.  You can even mount it with "errors=panic" so that the
> > node reboots and does a full fsck immediately.  For users that have a few
> > bad blocks on their disk and can't afford to throw the whole disk away this
> > is a reasonable course of action.
> 
> Ok, "errors=remount-ro" is good enough for me.  For the record, do
> non-historic disks with a few bad blocks still exist?  I though the
> driver firmware already detected those and used spare blocks at one
> side of the disk as a replacement.  Nicely visible when sequential
> read performance over the whole disk has a few non-continuous spots.

AFAIK, even modern disks will only remap blocks at write time and not
at read time.  That is why it is possible to get an IO error, but when
someone runs e.g. "badblocks" on the disk they are confused when it
doesn't report any errors.

Things like allowing the directory to be removed when there is a read
error actually helps such situations because when the block is re-used
it will first be written to and that will cause the remapping to happen.
Otherwise you have this useless directory that you don't want and can't
remove.  It doesn't help anyone to refuse removing it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

