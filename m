Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWFSP6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWFSP6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWFSP6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:58:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64721 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932241AbWFSP6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:58:25 -0400
Date: Mon, 19 Jun 2006 16:58:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619155821.GA27867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619153109.817554000@candygram.thunk.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:20:08AM -0400, Theodore Tso wrote:
> This eliminates the i_blksize field from struct inode and uses default
> value in super->s_blksize.  Filesystems that want to provide a
> per-inode st_blksize can do so by providing their own getattr routine
> instead of using the generic_fillattr() function.
> 
> Note that some filesystems were providing pretty much random (and
> incorrect) values for i_blksize.

Blease don't add a field to the superblock for the optimal I/O size.
Any filesystem that wants to override it can do so directly in ->getattr.

