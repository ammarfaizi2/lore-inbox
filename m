Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWGAIjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWGAIjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 04:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWGAIjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 04:39:52 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:1720 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750816AbWGAIjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 04:39:51 -0400
Date: Sat, 1 Jul 2006 02:39:50 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@google.com>
Cc: Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
       cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-ID: <20060701083950.GB5355@schatzie.adilger.int>
Mail-Followup-To: Daniel Phillips <phillips@google.com>,
	Johann Lombardi <johann.lombardi@bull.net>, sho@tnes.nec.co.jp,
	cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060628205238sho@rifu.tnes.nec.co.jp> <20060628155048.GG2893@chiva> <20060628202421.GL5318@schatzie.adilger.int> <44A417A3.80001@google.com> <20060629202700.GD5318@schatzie.adilger.int> <44A450BB.60105@google.com> <20060630093113.GA2702@chiva> <44A56B45.6050506@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A56B45.6050506@google.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 30, 2006  11:19 -0700, Daniel Phillips wrote:
> OK, just to handle the 64K case, what is wrong with treating 0 as 64K?

Hmm, good question - it's impossible to have a valid rec_len of 0 bytes.
There would need to be some special casing in the directory handling code.
Also, it breaks some of the directory sanity checking, and since "0" is
a common corruption pattern it isn't great to use.  We could instead use
0xfffc to mean 0x10000 since they are virtually the same value and the
error checking is safe.  It isn't possible to have this as a valid value.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

