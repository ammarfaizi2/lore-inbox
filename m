Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTFBUZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFBUZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:25:07 -0400
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:6664 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id S262373AbTFBUY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:24:26 -0400
Date: Mon, 2 Jun 2003 16:37:23 -0400
Message-Id: <200306022037.h52KbNVh012849@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Vivek Goyal" <vivek.goyal@wipro.com>
Cc: <trond.myklebust@fys.uio.no>, <indou.takao@jp.fujitsu.com>,
       <ezk@cs.sunysb.edu>, <viro@math.psu.edu>, <davem@redhat.com>,
       <nfs@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Disabling Symbolic Link Content Caching in NFS Client
In-Reply-To: <2BB7146B38D9CA40B215AB3DAAE24C080BA4F3@blr-m2-msg.wipro.com>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003 16:39:36 +0530, Vivek Goyal <vivek.goyal@wipro.com> wrote:

> I was following previous discussions in the mailing list and found that
> caching mechanism affected hlfsd behavior. It looks like the problem was
> resolved by updating mtime on every access. But still caching will lead
> to a problem if two accesses are taking place in same jiffy.

Yes, because the the nfs client is broken in this respect. noac 
should mean noac, but the nfs client will still cache attributes if the 
second access happens within the same jiffy as the previous access which 
updated the attribute cache.

Replacing a couple of time_after() calls with time_after_eq() calls 
fixes the issue, at least for hlfsd. Of course, running with noac might 
be very much unacceptable if all you want is to avoid caching symlinks.

> We are considering following design strategy to implement the parameter.
> 
> 1. Make nfs_symlink_caching dynamically tunable using /proc and sysctl
> interface.

No. Do it on a per-mount basis, like the other OS's do.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
