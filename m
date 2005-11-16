Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030530AbVKPWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030530AbVKPWiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbVKPWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:38:20 -0500
Received: from pat.uio.no ([129.240.130.16]:54990 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030530AbVKPWiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:38:19 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: theonetruekenny@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1132179796.8811.70.camel@lade.trondhjem.org>
References: <20051116150141.29549.qmail@web34113.mail.mud.yahoo.com>
	 <1132163057.8811.15.camel@lade.trondhjem.org>
	 <20051116100053.44d81ae2.akpm@osdl.org>
	 <1132166062.8811.30.camel@lade.trondhjem.org>
	 <20051116110938.1bf54339.akpm@osdl.org>
	 <1132171500.8811.37.camel@lade.trondhjem.org>
	 <20051116133130.625cd19b.akpm@osdl.org>
	 <1132177785.8811.57.camel@lade.trondhjem.org>
	 <20051116141052.7994ab7d.akpm@osdl.org>
	 <1132179796.8811.70.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 17:38:08 -0500
Message-Id: <1132180688.8811.78.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.704, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 17:23 -0500, Trond Myklebust wrote:
> On Wed, 2005-11-16 at 14:10 -0800, Andrew Morton wrote:
> 
> > > How is the filesystem supposed to distinguish between the cases
> > > "VM->writepage()", and "VM->writepages->mpage_writepages->writepage()"?
> > > 
> > 
> > Via the writeback_control, hopefully.
> > 
> > For write_one_page(), sync_mode==WB_SYNC_ALL, so NFS should start the I/O
> > immediately (it appears to not do so).
> 
> Sorry, but so does filemap_fdatawrite(). WB_SYNC_ALL clearly does not
> discriminate between a writepages() and a single writepage() situation,
> whatever the original intention was.

IMHO, the correct way to distinguish between the two would be to use the
wbc->nr_to_write field. If all the instances of writepage() were to set
that field to '1', then the filesystems could do the right thing.

As it is, you have shrink_list() that sets it to the value
"SWAP_CLUSTER_MAX" for no apparent reason...

Cheers,
  Trond

