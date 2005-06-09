Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVFINoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVFINoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFINnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:43:21 -0400
Received: from colin.muc.de ([193.149.48.1]:13585 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262390AbVFINlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:41:53 -0400
Date: 9 Jun 2005 15:41:50 +0200
Date: Thu, 9 Jun 2005 15:41:50 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, matt_domsch@dell.com
Subject: Re: 2.6.12?
Message-ID: <20050609134150.GN1683@muc.de>
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org> <394120000.1117895039@[10.10.2.4]> <20050604151120.46b51901.akpm@osdl.org> <418760000.1117983740@[10.10.2.4]> <971250000.1118168167@flay> <20050607122422.612759e4.akpm@osdl.org> <20050608125637.GL1683@muc.de> <549770000.1118260074@[10.10.2.4]> <1046820000.1118271896@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046820000.1118271896@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 04:04:56PM -0700, Martin J. Bligh wrote:
> >>> > >>> The one that worries me is that my x86_64 box won't boot since -rc3
> >>> > >>>  See:
> >>> > >>> 
> >>> > >>>  http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> >>> > 
> >>> > HA. Found it. binary search reveals it's patch 182 out of 2.6.12-rc2-mm2.
> >>> > And the winner is .... <drum roll please> ....
> >>> > 
> >>> > x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
> >>> > 
> >>> 
> >>> hrm.  No useful messages in dmesg?
> >>> 
> >>> Andi, do we revert it?
> >> 
> >> Ok. For now. 
> >> 
> >> Actually it fixes some other bugs (e.g. one from Matt D.), but they are not
> >> very high priority.
> >> 
> >> I would like to debug it, but I am not sure I will still make it this week.
> >> But Martin, can you please send me the dmesg again? Maybe it is something
> >> stupid.
> > 
> > All the logs are linked off here:
> > 
> > http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
> > 
> > Just click on the ABORT messages in hte left column. But I'm thinking maybe
> > I'm off by one, and it might be:
> 
> Nope, I was correct, just one of my scrawled notes was wrong. backing out
> 
> x86_64-use-the-e820-hole-to-map-the-iommu-agp-aperture.patch
> 
> does indeed fix it.

Most likely it is a BIOS bug and the Newisys BIOS puts something in 
the hole when it should be marked RESERVED in e820. Little we can do 
here :/

Note in theory it could blow up on i386 too if you have enough
mappings. 
-Andi
