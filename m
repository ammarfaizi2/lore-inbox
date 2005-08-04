Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbVHDLjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVHDLjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 07:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVHDLjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 07:39:42 -0400
Received: from mail.suse.de ([195.135.220.2]:27868 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262480AbVHDLjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 07:39:42 -0400
Date: Thu, 4 Aug 2005 13:39:41 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Cc: cr@sap.com, linux-mm@kvack.org
Subject: Getting rid of SHMMAX/SHMALL ?
Message-ID: <20050804113941.GP8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I noticed that even 64bit architectures have a ridiculously low 
max limit on shared memory segments by default:

#define SHMMAX 0x2000000                 /* max shared seg size (bytes) */
#define SHMMNI 4096                      /* max num of segs system wide */
#define SHMALL (SHMMAX/PAGE_SIZE*(SHMMNI/16)) /* max shm system wide (pages) */

Even on 32bit architectures it is far too small and doesn't
make much sense. Does anybody remember why we even have this limit?

IMHO per process shm mappings should just be controlled by the normal
process and global mappings with the same heuristics as tmpfs
(by default max memory / 2 or more if shmfs is mounted with more)
Actually I suspect databases will usually want to use more 
so it might even make sense to support max memory - 1/8*max_memory

I would propose to get rid of of shmmax completely
and only keep the old shmall sysctl for compatibility.

Comments?

-Andi
