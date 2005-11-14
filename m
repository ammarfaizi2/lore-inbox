Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVKNT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVKNT5L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKNT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:57:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:53740 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751267AbVKNT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:57:00 -0500
Date: Mon, 14 Nov 2005 12:56:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adrian Bunk <bunk@stusta.de>, Michael Buesch <mbuesch@freenet.de>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051114195639.GI3839@smtp.west.cox.net>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <200511122237.17157.mbuesch@freenet.de> <20051112215304.GB21448@stusta.de> <200511122257.05552.mbuesch@freenet.de> <20051112222045.GC21448@stusta.de> <1131834667.7406.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131834667.7406.49.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 09:31:06AM +1100, Benjamin Herrenschmidt wrote:
> 
> > ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> > any way.
> > 
> > _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.
> 
> Therse are old PREP stuffs
> 
> > But prep_init points to the real problem:
> > 
> > CONFIG_PPC_PREP requires code from arch/ppc/platforms/, but this 
> > directory is never visited.
> > 
> > What is the correct fix?
> > Migrate the code from arch/ppc/platforms/ to arch/powerpc/platforms/ ?
> 
> Yes, PREP need to be migrated, but that includes adding some minimum
> device-tree support for it among others. And few people still have PREP
> machines, I'm not even sure we have access to one here in ozlabs... I
> think for 2.6.15, we'd better just disable it in .config for
> ARCH=powerpc.

I think we really should just drop _prep_type from being exported.  the
uc* stuff doesn't look to be used, but we can clean that up as its
converted to arch/powerpc.  But I don't think anything out of tree uses
_prep_type (it's used at a very low level, it really couldn't be used at
the modular level).

As an occasional PReP monkey,
Acked-by: Tom Rini <trini@kernel.crashing.org>

-- 
Tom Rini
http://gate.crashing.org/~trini/
