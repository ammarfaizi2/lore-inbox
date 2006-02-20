Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWBTRsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWBTRsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWBTRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:48:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4106 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161076AbWBTRsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:48:03 -0500
Date: Mon, 20 Feb 2006 18:48:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some fixups for the X86_NUMAQ dependencies
Message-ID: <20060220174802.GF4661@stusta.de>
References: <20060219232621.GC4971@stusta.de> <43F9EF43.3020709@mbligh.org> <20060220170827.GD4661@stusta.de> <43F9FEDA.3030205@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9FEDA.3030205@mbligh.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 09:39:38AM -0800, Martin J. Bligh wrote:
> >>>config X86_NUMAQ
> >>>	bool "NUMAQ (IBM/Sequent)"
> >>>+	select SMP
> >>>	select NUMA
> >>>	help
> >>>	  This option is used for getting Linux to run on a (IBM/Sequent) 
> >>>	  NUMA
> >>>@@ -419,6 +420,7 @@
> >>
> >>Surely NUMA should select SMP, not NUMA-Q?
> >
> >NUMA depends on SMP.
> >
> >Therefore, if you select NUMA, you have to ensure that SMP is enabled.
> 
> Yes. but that should link SMP -> NUMA -> NUMA-Q, not SMP directly to 
> NUMA-Q, surely?

The problem is that a select bypasses the dependencies of the select'ed 
symbol.

> >NUMAQ can't be hidden since it doesn't has any dependencies.
> >And this isn't what this comment is talking about (note the the 
> >comment is only shown if NUMAQ was already select'ed).
> >
> >NUMAQ didn't fulfill the contract that when select'ing NUMA, it has to 
> >ensure the dependencies of NUMA are fulfilled. My patch solves this 
> >properly instead of telling the user through a comment that he ran into 
> >this bug.
> 
> Yes, if that works, it's much cleaner. Perhaps we just had insufficient
> config-fu to figure it out ... it looks good - I suppose I'd better test 
> it, and make sure we don't hit the same thing we did before.

:-)

> m.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

