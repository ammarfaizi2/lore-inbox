Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTD1W2T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTD1W2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:28:19 -0400
Received: from holomorphy.com ([66.224.33.161]:23496 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261322AbTD1W2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:28:18 -0400
Date: Mon, 28 Apr 2003 15:40:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428224025.GW30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de> <3EAD5C44.103@us.ibm.com> <483810000.1051549109@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483810000.1051549109@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Dave Hansen wrote:
>> Each one of those needs to be audited before pgcl is acceptable to a
>> wide audience.  We've already seen plenty of stuff that breaks.  ext2/3
>> look to be all right, but I know that JFS is broken.

On Mon, Apr 28, 2003 at 09:58:31AM -0700, Martin J. Bligh wrote:
> Well, the upside is that he's only doing s/PAGE_SIZE/MMU_PAGESIZE/
> in most places, which are normally both 4K. So it will have no effect
> whatsoever unless you explicitly turn it on.

The JFS issue is general to PAGE_SIZE > 4KB, pgcl-induced or not. shaggy
et al are already aware of it.

Most of the driver stuff I've seen is ioremap() of O(PAGE_SIZE) which
just gets denied so it fails to probe. IDE was worse (as usual), and
AGP needed an unusual amount of tweaking, which probably will be
typical for the graphics drivers in general. Block stuff seems to be
well-abstracted, so basically the only semantically significant needed
fix for block drivers is for 512*q->max_len < PAGE_SIZE (not yet done).


-- wli
