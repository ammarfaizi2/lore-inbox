Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbREXLRN>; Thu, 24 May 2001 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbREXLRD>; Thu, 24 May 2001 07:17:03 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:1802 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261473AbREXLQz>; Thu, 24 May 2001 07:16:55 -0400
Date: Thu, 24 May 2001 12:16:34 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Manas Garg <mls@chakpak.net>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: O_TRUNC problem on a full filesystem
Message-ID: <20010524121634.O8080@redhat.com>
In-Reply-To: <20010523114318.A8336@cygsoft.com> <3B0B8924.F0B78288@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0B8924.F0B78288@uow.edu.au>; from andrewm@uow.edu.au on Wed, May 23, 2001 at 07:55:48PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 07:55:48PM +1000, Andrew Morton wrote:

> When you truncated your file, the blocks remained preallocated
> on behalf of the file, and were hence considered "used".  For
> some reason, a subsequent attempt to allocate blocks for the
> same file failed to use that file's preallocated blocks.

Nope.  ext2_truncate() calls ext2_discard_prealloc() to fix this up.
Both 2.2 and 2.4 do this correctly.

Cheers,
 Stephen
