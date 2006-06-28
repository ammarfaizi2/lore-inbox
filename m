Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWF1UYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWF1UYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWF1UYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:24:23 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:32724 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751357AbWF1UYW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:24:22 -0400
Date: Wed, 28 Jun 2006 14:24:21 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Johann Lombardi <johann.lombardi@bull.net>
Cc: sho@tnes.nec.co.jp, cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-ID: <20060628202421.GL5318@schatzie.adilger.int>
Mail-Followup-To: Johann Lombardi <johann.lombardi@bull.net>,
	sho@tnes.nec.co.jp, cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628155048.GG2893@chiva>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2006  17:50 +0200, Johann Lombardi wrote:
> ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
> with 64KB blocksize.  This patch prevent from overflow by limiting
> rec_len to 65532.

Having a max rec_len of 65532 is rather unfortunate, since the dir
blocks always need to filled with dir entries.  65536 - 65532 = 4, and
the minimum ext3_dir_entry size is 8 bytes.  I would instead make this
maybe 64 bytes less so that there is room for a filename in the "tail"
dir_entry.


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

