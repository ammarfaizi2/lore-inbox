Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268289AbUHKWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268289AbUHKWlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUHKWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:41:53 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:18819 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268289AbUHKWlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:41:18 -0400
Date: Wed, 11 Aug 2004 15:41:17 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811224117.GA6450@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following this email will be a set of patches that provide a first pass
at exporting information currently in /proc/cpuinfo to sysfs for i386 and 
ARM. There are applications that are dependent on /proc/cpuinfo atm, so we 
can't just kill it, but we should agree on a kill date and require all
arches & apps to transition by that point. I've added code to
proc_misc.c to remind the user that the cpuinfo interface is going
away (currently using arbitrary date ~1 year from now). I've also
added a pointer to struct cpu that can be used by arch code to 
store any information that might be needed during attribute printing.

Couple of questions:

- Do we want to standardize on a set of attributes that all CPUs
  must provide to sysfs? bogomips, L1 cache size/type/sets/assoc (when
  available), L2 cache (L3..L4), etc? This would make the output be the 
  same across architectures for those features and would simply require
  adding some fields to struct cpu to carry this data and some generic
  ATTR entries to drivers/base/cpu.c.  I am all for standardized
  interfaces so I'll do a first pass at this if desired.

- On an HT setup, do we want link(s) pointing to sibling(s)?

- Currently the bug and feature fields on x86 have "yes" and "no".
  Do we want the same in sysfs or 1|0?

- Instead of dumping the "flags" field, should we just dump cpu
  registers as hex strings and let the user decode (as the comment
  for the x86_cap_flags implies.

I'll try to do MIPS, SH, and PPC when I get a chance (all I have access 
to), but have other things to do for a while, so want comments on above 
questions first. 

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
