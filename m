Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263753AbRFLXB0>; Tue, 12 Jun 2001 19:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263756AbRFLXBR>; Tue, 12 Jun 2001 19:01:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47629 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263753AbRFLXBC>; Tue, 12 Jun 2001 19:01:02 -0400
Date: Wed, 13 Jun 2001 01:00:17 +0200
From: Jan Kara <jack@suse.cz>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan@redhat.com
Subject: Re: [PATCH] Inode quota allocation loophole (2.4)
Message-ID: <20010613010017.B28910@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E159jIv-0004W5-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E159jIv-0004W5-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Tue, Jun 12, 2001 at 01:13:36AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Currently, dquot_initialize() is a no-op if the inode being initialized
> isn't a regular file, directory or symlink. This means that calling
> DQUOT_ALLOC_INODE() on a named pipe or AF_UNIX socket has no effect (the
> same applies to devices, but this is less likely to be a problem as
> random users can't create them); as a result a user can exhaust the
> filesystem's inodes even when they have a quota limit. This problem is
> exploitable in 2.2.19 and 2.4.2, and appears to be present in all kernel
> versions that I've looked at.
> 
> I presume that the reason for not putting quotas on pipes and sockets is
> that it's slightly more efficient not to do so. If that's the case, then
> the simplest solution would be to remove the checks in fs/dquot.c (patch
> below for 2.4.5 - patch for 2.2 in following email). Are there any
> undesirable consequences to pipes, sockets and devices having non-NULL
> pointers in i_dquot[]?
  I must admit that I don't know why we don't count quotas also for device/pipe/socket
inodes. This behaviour was there for ages :). Maybe it's time to change it.
I can't think of any problems which can be with it... Your patch seems to be fine.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs
