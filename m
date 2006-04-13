Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWDMBJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWDMBJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWDMBJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:09:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:46979 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932396AbWDMBJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:09:43 -0400
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture
	independent manner V2
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Mel Gorman <mel@skynet.ie>, davej@codemonkey.org.uk, tony.luck@intel.com,
       linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bob.picco@hp.com, Linux Memory Management List <linux-mm@kvack.org>
In-Reply-To: <200604130257.00203.ak@suse.de>
References: <20060412232036.18862.84118.sendpatchset@skynet>
	 <200604130153.08604.ak@suse.de>
	 <Pine.LNX.4.64.0604130058210.18950@skynet.skynet.ie>
	 <200604130257.00203.ak@suse.de>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 18:08:48 -0700
Message-Id: <1144890528.31255.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 02:56 +0200, Andi Kleen wrote:
> The problem is not memory consumption but complexity of code/data structures.
> Keeping information in two places is usually a good cue that something 
> is wrong. This code is also fragile and hard to test. 

Part of the motivation for these patches is that we really duplicate a
lot of functionality across architectures.  For instance, on x86, we
have limit_regions() to fiddle with the e820 or efi tables to make them
look right after a mem= on the command-line.

We end up doing the same kind of fiddling on powerpc, but on LMBs,
instead.  This code is error-prone, and every one of these
implementations gets it wrong.  I believe I've seen and fixed bugs in at
least two of them.  Add in NUMA things or hotplug boot-time zone sizing,
and you get an even worse mess. 

The motivation for Mel's patches is to keep the architectures from
getting it wrong.  If we let them do it themselves, they _will_ get it
wrong, and any bugfixes will not help anybody else.

If we do it in common code, we will certainly have bugs for a while.  By
sharing code, we narrow the bugs down to one place, and only have to fix
them once.

-- Dave "guy who hates the same bugs in many arches" Hansen

