Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933722AbWKQQyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933722AbWKQQyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933657AbWKQQyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:54:10 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:21654 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S932952AbWKQQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:54:08 -0500
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="88340275:sNHT46477485"
To: Steve Wise <swise@opengridcomputing.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH  11/13] Core Resource Allocation
X-Message-Flag: Warning: May contain useful information
References: <20061116035826.22635.61230.stgit@dell3.ogc.int>
	<20061116035923.22635.5397.stgit@dell3.ogc.int>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Nov 2006 08:54:06 -0800
Message-ID: <adaslgim2tt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Nov 2006 16:54:07.0065 (UTC) FILETIME=[FEC68C90:01C70A68]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static u32 next_random(u32 rand)
 > +{
 > +	u32 y, ylast;
 > +
 > +	y = rand;	
 > +	ylast = y;
 > +	y = (y * 69069) & 0xffffffff;
 > +	y = (y & 0x80000000) + (ylast & 0x7fffffff);
 > +	if ((y & 1))
 > +		y = ylast ^ (y > 1) ^ (2567483615UL);
 > +	else
 > +		y = ylast ^ (y > 1);
 > +	y = y ^ (y >> 11);
 > +	y = y ^ ((y >> 7) & 2636928640UL);
 > +	y = y ^ ((y >> 15) & 4022730752UL);
 > +	y = y ^ (y << 18);
 > +	return y;
 > +}

How about just using the kernel's random32()?

I haven't read the code really so I don't understand what's being
randomized here, but random32() should be more than good enough for a
typical randomized algorithm().

 - R.
