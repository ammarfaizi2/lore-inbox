Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWCAIqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWCAIqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 03:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWCAIqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 03:46:21 -0500
Received: from pat.uio.no ([129.240.130.16]:56779 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932102AbWCAIqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 03:46:21 -0500
Subject: Re: [RFC] vfs: cleanup of permission()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228052606.GA6494@MAIL.13thfloor.at>
References: <20060228052606.GA6494@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 00:45:44 -0800
Message-Id: <1141202744.11585.20.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.491, required 12,
	autolearn=disabled, AWL 1.51, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 06:26 +0100, Herbert Poetzl wrote:
> Hi Andrew! Christoph! Al!
> 
> after thinking some time about the oracle words
> (sent in reply to previous BME submissions) we 
> (Sam and I) came to the conclusion that it would 
> be a good idea to remove the nameidata introduced
> in September 2003 from the inode permission()
> checks, so that vfs_permission() can take care
> of them ...

Why? There may be perfectly legitimate reasons for the filesystem to
request information about the path. I can think of server failover
situations in NFSv4 where the client may need to look up the filehandle
for the file on the new server before it can service the ACCESS call.

> this is in two parts, the first one does the 
> removal and the second one fixes up nfs and fuse
> by passing the relevant nd_flags via the mask
> 
> Note: this is just a suggestion, so please let
>       us know what you think 

Firstly, the fact that the lookup intent flags happen not to collide
with MAY_* is a complete fluke, not a design. The numerical values of
either set of flags could change tomorrow for all you know.

Secondly, an intent is _not_ a permissions mask by any stretch of the
imagination.

IOW: at the very least make that intent flag a separate parameter.

Cheers,
  Trond

