Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUJGSfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUJGSfo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:32:53 -0400
Received: from holomorphy.com ([207.189.100.168]:61648 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267745AbUJGScI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:32:08 -0400
Date: Thu, 7 Oct 2004 11:32:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: macro@linux-mips.org
Subject: Re: [PATCH] APIC physical broadcast for i82489DX
Message-ID: <20041007183203.GW9106@holomorphy.com>
References: <200410071609.i97G9reQ003072@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410071609.i97G9reQ003072@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:24:23PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.2133, 2004/10/07 08:24:23-07:00, macro@linux-mips.org
> 	[PATCH] APIC physical broadcast for i82489DX
> 	The physical broadcast ID is determined incorrectly for the i82489DX,
> 	which uses 8-bit physical addressing (32-bit logical).
>  apic.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> diff -Nru a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
> --- a/arch/i386/kernel/apic.c	2004-10-07 09:10:03 -07:00
> +++ b/arch/i386/kernel/apic.c	2004-10-07 09:10:03 -07:00
> @@ -91,7 +91,7 @@
>  	unsigned int lvr, version;
>  	lvr = apic_read(APIC_LVR);
>  	version = GET_APIC_VERSION(lvr);
> -	if (version >= 0x14)
> +	if (!APIC_INTEGRATED(version) || version >= 0x14)
>  		return 0xff;
>  	else
>  		return 0xf;

This is the same as version <= 0xf || version >= 0x14; I'm rather
suspicious, as the docs have long since been purged, making this
hopeless for anyone without archives (or a good memory) dating back to
that time to check. All that's really needed is citing the version that
comes out of the version register and checking other APIC
implementations to verify they don't have versions tripping this check,
the latter of which is feasible for those relying on still-extant
documentation. Better yet would be dredging up the docs... So, what is
the range of the version numbers reported by i82489DX's?


-- wli
