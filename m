Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTLTAvb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 19:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTLTAvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 19:51:31 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:6610 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263762AbTLTAv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 19:51:27 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200312200035.hBK0ZwWR005874@fsgi900.americas.sgi.com>
Subject: Re: [PATCH] Updating our sn code in 2.6
To: hch@infradead.org (Christoph Hellwig)
Date: Fri, 19 Dec 2003 18:35:57 -0600 (CST)
Cc: pfg@sgi.com (Pat Gefre), akpm@osdl.org, davidm@napali.hpl.hp.com,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031219114328.A26526@infradead.org> from "Christoph Hellwig" at Dec 19, 2003 11:43:28 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph,

Some general comments/questions and then the specifics follow.

First off, some of the changed/reorg'd code is foundation code for a
new ASIC that we are working on - so it now looks a little silly and
maybe a little like overkill, but we would like to start moving this
code into the community base.

I'm not sure where you are going with the IP27 idea. IP27 is mips so
the code doesn't belong in the ia64 directories - we also don't support
Bridge/Xbridge in our ia64 code which is why we'd like to get rid of it
and if you wanted to use the code as framework for other work I would
think you could archive a version of the tree now ? So I'm a bit
confused - there must be something I'm missing.

Also I did these patches sequentially (hence the numbering) - so in
some cases I may have taken out code that wasn't being used at the
time, but then added in back in when it was used.

Thanks for reviewing this for me - it sounds like we are making some
progress.

-- Pat

+ 004-fakeprom-update.patch
+ 
+ 	OK, but why is fakeprom in the kernel at all?

I took the fakeprom patch out.


+ 036-shub-redirect.patch
+ 
+ 	Wrong opening placement of first opening brace in
+ 	sn_shub_redirect_intr :)

OK - fixed.


+ 
+ 037-shub-redirect1.patch
+ 
+ 	What's the point point of these pcireq stuff?  And what's the
+ 	relation to the shub redirection?

The idea was to move this code into functions - making it more portable
(future changes just needed to be made to the function).  This
(037-shub-redirect1.patch) was actually a patch that was needed for the
previous patch (I had referenced these functions in the previous patch
but didn't have the functions themselves in the patch).  The redirect
code is for interrupt redirection - handling the interrupt on a
different cpu that it was being handled on.


+ 
+ 048-pci_provider.patch
+ 
+ 	At least better than the previous variant.. :)
+ 	set_sn_pci64() is bogus, I'm certain the qla2x00 driver
+ 	uses the right dma interface and if qlogicfc doesn't either
+ 	fix it or (better) don't use that broken old driver..

OK - I see your point - I pulled out the set_sn_pci64() code.


+ 
+ 051-cbrick.type.patch
+ 
+ 	Code is ok, but wrong brace placement again..

OK - fixed.


+ 071-xswitch.devfunc.patch
+ 
+ 	The whole indirection was develeted on a purpose.  Do you really
+ 	have different xswitches now?  (Don't seem to be in this patchkit).
+ 	If yes we'd better come up with a btter abstraction.
+ 

This is still up in the air here - as in it hasn't been decided yet -
so we can pass on this patch if you want.


+ 075-rename-reorg.patch
+ 
+ 	BRIDGE_TYPE_AND_PTR_GET is totally bogus..
+ 	Moving pcibr_attach2 to pic_attach2 is bogus and really wrong.
+ 	Even if _you_ don't support Bridge/Xbridge anyore it's still
+ 	common code for all of those.  While you're at it pic.c
+ 	really should move to the pcibr dir.
+ 	bridge.h -> pcibr_asic move seems really pointless to me, but
+ 	if you really want it..
+ 	BUT: Please remove the random renamaing of the include/asm/sn/pci
+ 	constants froms the patch, else it looks mostly okay (although
+ 	that's hard with such a large patch doing just code reorganization),
+ 	dito for the struct typedef names.  This really breaks anyone
+ 	doing work on Bridge/Xbridge without any purpose.

This is foundation work for the next ASIC. So hopefully at some point
in the future it will all make sense.


-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054
