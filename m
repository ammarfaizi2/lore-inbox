Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbTIPAew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTIPAew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:34:52 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:31721 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261703AbTIPAes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:34:48 -0400
Message-ID: <3F6659DF.1090508@us.ibm.com>
Date: Mon, 15 Sep 2003 17:31:27 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, wli@holomorphy.com
Subject: Re: [PATCH] you have how many nodes??
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
but that patch is utterly useless now.  At Martin's urging I've created 
a new series of patches to resolve this.

01 - Make sure MAX_NUMNODES is defined in one and only one place. 
Remove superfluous definitions.  Instead of defining MAX_NUMNODES in 
asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
turn that NODES_SHIFT value into MAX_NUMNODES.

02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
places, and it's incorrectly used in all those places as far as I can 
tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
value to check NODES_SHIFT is appropriate.  A possible future patch 
should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.

03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
MAX_NUMNODES instead.

04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
straightforward replacement of NR_NODES with standard MAX_NUMNODES.

05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. 
This code made my head hurt.  I think I may have gotten it right. 
Totally untested.

Cheers!

-Matt

Jesse Barnes wrote:
> On Wed, Sep 10, 2003 at 04:46:40PM -0700, Martin J. Bligh wrote:
> 
>>Yes, it's a turgid mess.
>>
>>I'd prefer to define things in terms of MAX_NUMNODES, and derive the shifts
>>from that if possible - much more intuitive to maintain.
>>But other than that I agree completely with you.
> 
> 
> Yeah, I don't mind switching, should just be a search and replace.
> 
> 
>>>Could you please get together with Martin Bligh, come up with something
>>>which works on NUMAQ and your 128 CPU PDA and also cast an eye across the
>>>other architectures (sparc64, sh, ...)?  It all needs a bit of thought and
>>>a spring clean.
>>
>>I'll have a look, I'm sure we can come up with something between us.
> 
> 
> Cool, thanks.
> 
> Jesse
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


