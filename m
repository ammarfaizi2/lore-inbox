Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262748AbVHDWs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbVHDWs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVHDWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:46:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57050 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262707AbVHDWoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:44:44 -0400
Date: Thu, 4 Aug 2005 15:44:39 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: NUMA policy interface
Message-ID: <20050804224439.GC3933@w-mikek2.ibm.com>
References: <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net> <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net> <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net> <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net> <20050804214132.GF8266@wotan.suse.de> <Pine.LNX.4.62.0508041509330.10813@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0508041509330.10813@graphe.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 03:19:52PM -0700, Christoph Lameter wrote:
> This code already exist in the memory hotplug code base and Ray already 
> had a working implementation for page migration. The migration code will 
> also be necessary in order to relocate pages with ECC single bit failures 
> that Russ is working on (of course that will only work for some pages) and
> for Mel Gorman's defragmentation approach (if we ever get the split into 
> differnet types of memory chunks in).

Yup, we need page migration for memory hotplug.  However, for hotplug
we are not too concerned about where the pages are migrated to.  Our
primary concern is to move them out of the block/section that we want
to offline.  Suspect this is the same for pages with ECC single bit
failures.  In fact, this is one possible use of the hotplug code.
Notice a failure.  Migrate all pages off the containing DIMM.  Offline
section corresponding to DIMM.  Replace the DIMM.  Online section
corresponding to DIMM.  Of course, your hardware needs to be able to
do this.

-- 
Mike
