Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUDSVIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUDSVIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUDSVIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:08:32 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:6016 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261239AbUDSVI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:08:27 -0400
Subject: Re: [PATCH 2.6.6rc1-mm1] NFS sysctlized - readahead tunable
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Fabian Frederick <Fabian.Frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082407753.18853.12.camel@bluerhyme.real3>
References: <1082407753.18853.12.camel@bluerhyme.real3>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082408907.3360.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 17:08:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 16:49, Fabian Frederick wrote:
> Trond,
> 
> 	Here is a patch to have nfs to sysctl although Maxreadahead is tunable
> under nfs init only.Do you have an idea and do you think it's acceptable
> to make it applicable directly i.e. would it be readahead reduction
> tolerant ?
> 
> btw, is this inode.c an issue for V4 ?
> 

The lockd module has already registered the name /proc/sys/fs/nfs, so
your scheme will end up corrupting the sysctl list. Sorting out the
/proc namespace issue is the main reason why this hasn't been done
before.
Personally, I'd prefer renaming the lockd module into
/proc/sys/fs/lockd, but it will have to be up to Andrew to decide
whether he wants to allow that during a stable kernel cycle.

Also note that putting initializers into a ".h" file is horrible style.
".h" files should be for forward declarations only.

Cheers,
  Trond
