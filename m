Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266733AbSKZTrc>; Tue, 26 Nov 2002 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbSKZTrc>; Tue, 26 Nov 2002 14:47:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51980 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266733AbSKZTrb>;
	Tue, 26 Nov 2002 14:47:31 -0500
Date: Tue, 26 Nov 2002 20:54:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: john stultz <johnstul@us.ibm.com>
Cc: James.Bottomley@HansenPartnership.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Russell King <rmk@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] [PATCH] linux-2.5.49_subarch-cleanup_A2
Message-ID: <20021126195427.GB1525@mars.ravnborg.org>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>,
	James.Bottomley@HansenPartnership.com,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Russell King <rmk@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1038274857.959.10.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038274857.959.10.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 05:40:58PM -0800, john stultz wrote:
> If there are no further comments, I'll re-submit w/o the rfc bit. 

One detail..


> +#VISWS subarch support
> +mflags-$(CONFIG_VISWS) := -Iinclude/asm-i386/mach-visws
> +mcore-$(CONFIG_VISWS)  := mach-visws
> +#default subarch support
> +mflags-y += -Iinclude/asm-i386/mach-default
> +ifndef mcore-y
> +  mcore-y  := mach-default
>  endif
Move the "mcore-y := mach-default" assignment above the
block that deal with subarch. Then you do not need the "ifndef ..."

I recall that Linus previously have asked for shell commands
when moving files - so consider including only the patch below and
then a number of "mv arch/i386/X include/....".
This makes it much more visible what you actually change.

Another alternative it to do it in bitkeeper, then it is visible
from the cset that you move files (use bk mv).

	Sam
