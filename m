Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUD3UsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUD3UsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUD3UrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:47:03 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:30482 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S265244AbUD3UmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:42:05 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 30 Apr 2004 15:41:57 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with recent changes to fs/dcache.c
Message-ID: <20040430204157.GD23466@artsapartment.org>
References: <20040430020525.GI27793@artsapartment.org> <20040429203901.4cd21fdc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429203901.4cd21fdc.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 08:39:01PM -0700, Andrew Morton wrote:
> "Art Haas" <ahaas@airmail.net> wrote:
> >
> >  [ ... snip boot problem report on Sparc with 2.6.6-rc ... ]
> > 
> >  The possiblity of nr_free_pages() being larger than mempages looks like
> >  a silent bug that was tripped. If not, then another bug in the Sparc
> >  port may be responsible for values being used in these functions. The
> >  memory-management gurus can take a peek and see what they find.
> 
> Yes, something's bust in the sparc port's calculation of num_physpages. 
> Clearly it should be larger than nr_free_pages().

I'm still trying to debug this, so I've cloned a 2.6.5 tree and added
some printk() bits to see what it reported. Here's the top of the
'dmesg' output. Notice the 'num_phspages' is 45829, so the value I was
getting in the 2.6.6-rc3 bootup of 46073 is very similar, which suggests
that the problem _might_ be with the nr_free_pages() call - which leads
down in the the mmzone code. Here's the dmesg output:

.......
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz).
Patching kerne l for srmmu[TI Viking/MXCC]/iommu
319MB HIGHMEM available.
On node 0 totalpages: 130409
  DMA zone: 48666 pages, LIFO batch:11
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 81743 pages, LIFO batch:16
Power off control detected.
Built 1 zonelists
Kernel command line: root=/dev/sda1
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
calling mem_init()
Memory: 509676k available (1352k kernel code, 312k data, 116k init,
   326972k high mem) [f0000000,1ff4f000]
num_physpages: 45829
Calibrating delay loop... 59.80 BogoMIPS
calling fork_init(45829)
calling vfs_caches_init(45829)
vfs_caches_init(): 45829 mempages
...

Could one or two of the VM gurus mail me offlist with some suggestions
for debugging this? I'm still more than a bit lost wandering through the
code trying to find just where various values are set and where the
functions are that are doing the setting.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
