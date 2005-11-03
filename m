Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVKCFgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVKCFgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVKCFgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:36:38 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:32949 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932225AbVKCFgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:36:37 -0500
X-ORBL: [69.149.117.103]
Date: Wed, 2 Nov 2005 23:32:58 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: Re: [PATCH 10/12: eCryptfs] Mmap operations
Message-ID: <20051103053258.GA32733@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103035530.GJ3005@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103035530.GJ3005@sshock.rn.byu.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 08:55:30PM -0700, Phillip Hellewell wrote:
> +static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
> +{
> ...
> +	ecryptfs_printk(1, KERN_NOTICE, "Copying page\n");
> +	memcpy(lower_kaddr, kaddr, crypt_stats->extent_size);

Note that this serves only to reduce the complexity of the execution
path while we try to pin down the kernel oops that shows up on certain
sets of concurrent gcc jobs. When actually encrypting, we are doing
extra page reads and writes with the underlying file to juggle the
initialization vectors. This part will, of course, need to be replaced
with the same crypto operations being done in ecryptfs_commit_write()
in order to encrypt the data on its way out via ecryptfs_writepage().
I will test the patch to do this and offer it as a follow-up once I am
satisfied that it does not regress any of our testcases; this patch
will also reduce the size of the ecryptfs_commit_write() function to
be closer to what it should be.

Thanks,
Mike
