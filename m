Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWFOMCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWFOMCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWFOMCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:02:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49537 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030270AbWFOMCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:02:33 -0400
Date: Thu, 15 Jun 2006 13:02:30 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs_fill_super() %s abuses
Message-ID: <20060615120230.GP27946@ftp.linux.org.uk>
References: <20060615110355.GH27946@ftp.linux.org.uk> <jever2aayc.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jever2aayc.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 01:56:59PM +0200, Andreas Schwab wrote:
> Al Viro <viro@ftp.linux.org.uk> writes:
> 
> > %s is valid only on NUL-terminated arrays, damnit!
> 
> Unless it specifies an approriate precision.

... and that precision does not exceed the size of array.  Here we have
AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0] as precision and
AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1 as pointer.  Which is closer
to the end of object than 256 bytes.
