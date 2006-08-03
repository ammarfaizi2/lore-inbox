Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWHCOmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWHCOmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWHCOmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:42:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16343 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932530AbWHCOmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:42:51 -0400
Date: Thu, 3 Aug 2006 15:42:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 27/28] elevate writer count for custom 'struct file'
Message-ID: <20060803144249.GE920@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, herbert@13thfloor.at
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235300.321FABDD@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235300.321FABDD@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:53:00PM -0700, Dave Hansen wrote:
> 
> Some filesystems forego the vfs and may_open() and create their
> own 'struct file's.  Any of these users which set the write flag
> on the file will cause an extra mnt_drop_write() on __fput(),
> thus dropping the reference count too low.
> 
> These users tend to have artifical in-kernel vfsmounts which
> aren't really exposed to userspace and can't be remounted, but
> this patch is included for completeness and so that the warnings
> don't trip over these cases.

Please add a helper to create these files so all this happens in just
one place.  There's a fare bit of code duplication already that this will
cleanup.  Another nice cleanup you should push out first before doing
the actual feature :)

