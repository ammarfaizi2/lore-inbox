Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbTIPQsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbTIPQsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 12:48:17 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:11816 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261966AbTIPQsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 12:48:15 -0400
Date: Tue, 16 Sep 2003 09:47:57 -0700
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up MAX_NR_NODES/NUMNODES/etc. [5/5]
Message-ID: <20030916164757.GA17359@sgi.com>
Mail-Followup-To: Matthew Dobson <colpatch@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20030910153601.36219ed8.akpm@osdl.org> <41000000.1063237600@flay> <20030911000303.GA20329@sgi.com> <3F6659DF.1090508@us.ibm.com> <3F665B5B.3000409@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F665B5B.3000409@us.ibm.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 05:37:47PM -0700, Matthew Dobson wrote:
> Matthew Dobson wrote:
> >Ok, I made an attempt to clean up this mess quite a while ago (2.5.47), 
> >but that patch is utterly useless now.  At Martin's urging I've created 
> >a new series of patches to resolve this.
> >
> >01 - Make sure MAX_NUMNODES is defined in one and only one place. Remove 
> >superfluous definitions.  Instead of defining MAX_NUMNODES in 
> >asm/numnodes.h, we define NODES_SHIFT there.  Then in linux/mmzone.h we 
> >turn that NODES_SHIFT value into MAX_NUMNODES.
> >
> >02 - Remove MAX_NR_NODES.  This value is only used in a couple of 
> >places, and it's incorrectly used in all those places as far as I can 
> >tell.  Replace with MAX_NUMNODES.  Create MAX_NODES_SHIFT and use this 
> >value to check NODES_SHIFT is appropriate.  A possible future patch 
> >should make MAX_NODES_SHIFT vary based on 32 vs. 64 bit archs.
> >
> >03 - Fix up the sh arch.  sh defined NR_NODES, change sh to use standard 
> >MAX_NUMNODES instead.
> >
> >04 - Fix up the arm arch.  This needs to be reviewed.  Relatively 
> >straightforward replacement of NR_NODES with standard MAX_NUMNODES.
> >
> >05 - Fix up the ia64 arch.  This *definitely* needs to be reviewed. This 
> >code made my head hurt.  I think I may have gotten it right. Totally 
> >untested.

Can you send me a patch that contains everything (or just the generic
code plus the ia64 stuff)?  The stuff you posted looks good, and I'd
like to test ia64, but I have to merge your patch into the latest
discontig stuff I've been working on to do so.

Thanks,
Jesse
