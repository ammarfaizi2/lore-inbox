Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263602AbTHZL1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 07:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263604AbTHZL1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 07:27:18 -0400
Received: from angband.namesys.com ([212.16.7.85]:39040 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263602AbTHZL1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 07:27:18 -0400
Date: Tue, 26 Aug 2003 15:27:16 +0400
From: Oleg Drokin <green@namesys.com>
To: Christoph Hellwig <hch@angband.namesys.com>, marcelo@hera.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backport iget_locked from 2.5/2.6
Message-ID: <20030826112716.GA14680@namesys.com>
References: <20030825140714.GA17359@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825140714.GA17359@lst.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helllo!

On Mon, Aug 25, 2003 at 04:07:14PM +0200, Christoph Hellwig wrote:

> Provide an iget variant without unlocking the inode and ->read_inode
> call.  This is needed for XFS and IIRC the reiserfs folks wanted it,
> too.

No. This patch is useless for our purposes. (and coda/nfs ).
We wanted to get rid of a race where inode allocation and
filling fs specific parts are done non-atomically.
The patch below does not achieve this. We still fill inode private part
outside of inode_lock locked region.

Bye,
    Oleg
