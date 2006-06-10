Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWFJC0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWFJC0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 22:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFJC0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 22:26:43 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:31948 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932346AbWFJC0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 22:26:42 -0400
Date: Fri, 9 Jun 2006 20:26:48 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610022648.GV5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A23B2.5080004@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  21:43 -0400, Jeff Garzik wrote:
> >???  Can you please be specific in what the performance penalty is, and
> >what specifically is "not sized optimally" after a resize?  How exactly
> >does inode allocation strategy relate to anything at all to online 
> >resizing.
> 
> Inodes per group / inode blocks per group, as I've already stated.

As Stepen and Ted already replied (though I can understand if you missed
it, it seems this is a popular thread :-)- the inode count per group
is a fixed parameter for the whole filesystem that even online resizing
cannot change.

The only things that can change on a per-group basis (with either online or
offline resizing, or with mke2fs -R stride=N, or if there are bad block
on disk) is that the relative offset within the group of the inode and
block bitmaps can change, and the relative location of the inode table
within the group can change.  The size of the inode table per group (and
hence number of inodes per group) is always constant, since it is stored
in the superblock and affects the inode number->group mapping.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

