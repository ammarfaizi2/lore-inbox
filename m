Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWDZFMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWDZFMu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWDZFMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:12:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:35814 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932368AbWDZFMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:12:49 -0400
To: "David Wilk" <davidwilk@gmail.com>
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Greg KH" <greg@kroah.com>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>, stable@kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [stable] 2.6.16.6 breaks java... sort of
References: <a4403ff60604191152u5a71e70fr9f54c104a654fc99@mail.gmail.com>
	<20060419192803.GA19852@kroah.com>
	<Pine.LNX.4.64.0604192046590.17491@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0604201706540.14395@blonde.wat.veritas.com>
	<a4403ff60604211208gf64dfe2v7282a493f4853c@mail.gmail.com>
	<20060421192743.GH3061@sorel.sous-sol.org>
	<a4403ff60604211456j46a2f69fw39606ffec42ec95d@mail.gmail.com>
	<Pine.LNX.4.64.0604231312450.2515@blonde.wat.veritas.com>
	<a4403ff60604241359q408a6ea7je620cb05d3dafe8@mail.gmail.com>
	<a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 26 Apr 2006 07:12:43 +0200
In-Reply-To: <a4403ff60604251108x7ed6d4e3q10cb3597ea27876c@mail.gmail.com>
Message-ID: <p73fyk09ayc.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Wilk" <davidwilk@gmail.com> writes:

> Ok, I think I need to apologize to everyone here.  I have found the
> problem, and it is not with your patch, Hugh.  For some reason, the
> config for my 2.6.16.7 source tree had a 1G/3G user/kernel split
> configured.  This is very bizaar as I copy my .config from tree to
> tree to avoid any changes in the configuration of my test kernels.

This just shows this dreaded VMSPLIT config was a bad idea in the first
place. There was a reason we didn't have it for such a long time (too
many users get it wrong) and such occurrences just show again that this
is still true.

IMHO it would be best to just remove that option again and require
users who really want to change this to patch their kernels again.

At the very least it should be probably made dependent on CONFIG_EMBEDDED.

-Andi

Mark VMSPLIT EMBEDDED

Too many users get it wrong.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -466,7 +466,7 @@ endchoice
 
 choice
 	depends on EXPERIMENTAL && !X86_PAE
-	prompt "Memory split"
+	prompt "Memory split" if EMBEDDED
 	default VMSPLIT_3G
 	help
 	  Select the desired split between kernel and user memory.
