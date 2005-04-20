Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVDTVZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDTVZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDTVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:25:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261798AbVDTVY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:24:59 -0400
Date: Wed, 20 Apr 2005 17:24:57 -0400
From: Dave Jones <davej@redhat.com>
To: Alice Corbin <ali@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: video drivers, agp, mtrr, and write-combining
Message-ID: <20050420212457.GF1763@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alice Corbin <ali@axian.com>, linux-kernel@vger.kernel.org
References: <20050420211238.GA15379@zaphod.axian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420211238.GA15379@zaphod.axian.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 02:12:38PM -0700, Alice Corbin wrote:

 > I've noticed that some, though no all, video drivers add their video memory
 > to MTRR as 'write-combining' if both MTRR and AGP are configured in.
 > 
 > Is there a reason that all video drivers don't do this?  Is it all would 
 > benefit from write-combining memory, but that some simply haven't been 
 > updated to take advantage of it?  Or could write-combining actually be 
 > detrimental to some video drivers?  

Either the drivers dont do it (for whatever reason), or the system 
doesnt have any spare MTRRs, or the system has broken WC MTRRs.
Got a specific example of a failing system ?

 > (And if the former, would it make
 > more sense to do the mtrr_add in a central location, say agpgart?)

It *could*, though it's not always straight-forward.
Here's an example of one awkward situation..

Matrox G550: Prefetchable memory behind bridge: f8000000-f9ffffff (31MB)
As MTRRs need to be a power-of-2, thats non-fun.

An NVIDIA GeForce256 --
Prefetchable memory behind bridge: d0000000-d7ffffff (127MB)

Ok, looks like a pattern but some systems with onboard gfx do this..
Prefetchable memory behind bridge: d8000000-dc0fffff (64MB)

There also exist some AGP cards which don't seem to use AGP features,
and have their range listed as fff00000-000fffff, which means
"I have no RAM" iirc.

The heuristics to get all this right would likely be a real mess,
so I feel its better to do it in the gfx card specific driver.

 
An even better solution would be to get PAT support into the kernel
so we can forget MTRRs ever existed.

		Dave

