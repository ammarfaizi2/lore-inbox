Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUIMVBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUIMVBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUIMVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:01:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:26265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267703AbUIMVBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:01:02 -0400
Date: Mon, 13 Sep 2004 14:01:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Neil Horman <nhorman@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] close race condition in shared memory mapping/unmapping
Message-ID: <20040913140101.S1973@build.pdx.osdl.net>
References: <4146041F.2040106@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4146041F.2040106@redhat.com>; from nhorman@redhat.com on Mon, Sep 13, 2004 at 04:33:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Neil Horman (nhorman@redhat.com) wrote:
> Hey all-
> 	Found this the other day poking through the ipc code.  There appears to 
> be a race condition in the counter that records how many processes are 
> accessing a given shared memory segment.  In most places the shm_nattch 
> variable is protected by the shm_ids.sem semaphore, but there are a few 
> openings which appear to be able to allow a corruption of this variable 
> when run on SMP systems.  I've attached a patch to 2.6.9-rc2 for review. 
>   The locking may be a little over-aggressive (I was following examples 
> from other points in this file), but I figure better safe than sorry :).

Are you sure you've got this right?  I thought that the shmid_kernel
struct protects shm_nattch with a local (per structure) lock which is
embedded in kern_ipc_perm.  Did you find shm_nattch changes w/out
shm_lock/shm_unlock around it?  I believe shm_ids.sem is protecting the
id allocation, not per object data such as shm_nattch.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
