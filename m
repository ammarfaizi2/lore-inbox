Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUEEQs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUEEQs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUEEQs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:48:57 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:31769 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264731AbUEEQs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:48:56 -0400
Date: Wed, 5 May 2004 09:47:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org, hch@lst.de
Subject: Re: [PATCH] NUMA API for Linux 5/ Add VMA hooks for policy
Message-Id: <20040505094748.40bb7493.pj@sgi.com>
In-Reply-To: <20040505163934.GA14963@wotan.suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
	<20040406153713.52a64a26.ak@suse.de>
	<20040505090531.51ad5c89.pj@sgi.com>
	<20040505163934.GA14963@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps you missed a patch? (several of the patches depended on each other) 

No - perhaps Christoph Hellwig removed the include.

See the patch small-numa-api-fixups.patch in 2.6.6-rc3-mm2:

========================= snip =========================
From: Christoph Hellwig <hch@lst.de>

- don't include mempolicy.h in sched.h and mm.h when a forward delcaration
  is enough.  Andi argued against that in the past, but I'd really hate to add
  another header to two of the includes used in basically every driver when we
  can include it in the six files actually needing it instead (that number is
  for my ppc32 system, maybe other arches need more include in their
  directories)

- make numa api fields in tast_struct conditional on CONFIG_NUMA, this gives
  us a few ugly ifdefs but avoids wasting memory on non-NUMA systems.

... details omitted ...
========================= snip =========================

Christoph did add the needed #include's of mempolicy.h in the
generic files that needed it, but not in the ia64 files, more
or less.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
