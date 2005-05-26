Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVEZUwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVEZUwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVEZUtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:49:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13538 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261756AbVEZUqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:46:51 -0400
Date: Thu, 26 May 2005 13:46:35 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: Simon.Derr@bull.net, akpm@osdl.org, dino@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050526134635.4fd1b978.pj@sgi.com>
In-Reply-To: <20050526120859.GD29852@lnx-holt.americas.sgi.com>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
	<20050526120859.GD29852@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> Whenever the refcount reaches 0, we
> automatically remove the cpuset. 

If by this you mean replacing the usermodehelper callout to
/sbin/cpuset_release_agent, with a direct removal of the cpuset
in the kernel, then:
 * this changes a kernel API - not to be done lightly, and
 * adding an in-kernel way to nuke a cpuset, in addition to
   having the rmdir(2) system call do it, seems like it would
   present even thornier locking issues.

The usermodehelper callout is working just fine for us.

As to the rest of your post, proposing a per-cpuset spinlock,
see my previous reply to Simon.  

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
