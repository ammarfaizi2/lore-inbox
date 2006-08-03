Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbWHCOfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWHCOfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHCOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:35:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15036 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932371AbWHCOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:35:50 -0400
Date: Thu, 3 Aug 2006 15:35:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 03/28] unlink: monitor i_nlink
Message-ID: <20060803143549.GC920@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, herbert@13thfloor.at
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235242.7B92A630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235242.7B92A630@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:52:42PM -0700, Dave Hansen wrote:
> 
> When a filesystem decrements i_nlink to zero, it means that a
> write must be performed in order to drop the inode from the
> filesystem.
> 
> We're shortly going to have keep filesystems from being remounted
> r/o between the time that this i_nlink decrement and that write
> occurs.  
> 
> So, add a little helper function to do the decrements.  We'll
> tie into it in a bit to note when i_nlink hits zero.

Looks good.  I wonder if we could find a better name for it.  Maybe just
dec_nlink?  And add a simple counterpart

static inline void inc_nlink(struct inode *inode)
{
	inode->i_nlink++;
}

for symmetry reasons.  After that the patch can go off to Andrew before
the series aswell.

> Should
> we also be checking all of the places where i_nlink is explicitly
> set to 0 in the unlink paths?

They'll definitly need some auditing.
