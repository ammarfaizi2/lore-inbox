Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUHKXUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUHKXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUHKXSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:18:07 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1229 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268339AbUHKXOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:14:45 -0400
Date: Thu, 12 Aug 2004 00:13:14 +0100
From: Dave Jones <davej@redhat.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
Message-ID: <20040811231314.GA32106@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Deepak Saxena <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20040811224117.GA6450@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811224117.GA6450@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 03:41:17PM -0700, Deepak Saxena wrote:

 > - Do we want to standardize on a set of attributes that all CPUs
 >   must provide to sysfs? bogomips, L1 cache size/type/sets/assoc (when
 >   available), L2 cache (L3..L4), etc?

For x86 at least, this can be entirely decoded in userspace using
the /dev/cpu/x/cpuid interface. See x86info for example of this.

 > - Instead of dumping the "flags" field, should we just dump cpu
 >   registers as hex strings and let the user decode (as the comment
 >   for the x86_cap_flags implies.

ditto.

As these require arch specific parsers anyway, I don't think it makes
too much sense making a kernel abstraction trying to make them all
look 'the same', and if it can be done in userspace, why bother ?

The only other concern I have is the further expansion of sysfs with
no particular gain over what we currently have. The sysfs variant
*will* use more unreclaimable RAM than the proc version.

/proc/cpuinfo has done well enough for us for quite a number of years
now, what makes it so urgent to kill it now that sysfs is the
virtual-fs-de-jour ?

		Dave

