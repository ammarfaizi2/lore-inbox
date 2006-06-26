Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWFZQOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWFZQOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWFZQOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:14:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbWFZQON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:14:13 -0400
Date: Mon, 26 Jun 2006 18:14:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060626161411.GT23314@stusta.de>
References: <20060626151012.GR23314@stusta.de> <20060626153834.GA18599@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626153834.GA18599@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 11:38:35AM -0400, Dave Jones wrote:
> On Mon, Jun 26, 2006 at 05:10:12PM +0200, Adrian Bunk wrote:
>  > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
>  > on i386.
>  > 
>  > Without such warnings people will never update their code and fix 
>  > the errors in PPC64 builds.
> 
> .. and deprecating pm_send_all, cli, sti, restore_flags, check_region yadayada
> has really been a great success at motivating people to fix those up too.

It has been a success, look at the numbers:

2.6.0     : 36 options depending on BROKEN_ON_SMP
2.6.17-mm2: 17 options depending on BROKEN_ON_SMP

2.6.7-mm7 : 20 drivers with warnings due to check_region
2.6.17-mm2:  3 drivers with warnings due to check_region

It's not that everything was fixed immediately, but there is definitely 
some progress.

> How about we fix up some of the existing noise before we add more?
> A build log of a fedora kernel I had handy shows 165 deprecated warnings
> that have been there forever.  Your proposal will add over 500 warnings
> in drivers/ alone.

There are few drivers generating many warnings, e.g. stallion+istallion 
alone give 138 __deprecated warnings only for cli/sti/restore_flags 
usage. Most of the code doesn't have any problems.

And my main motivation for getting virt_to_bus/bus_to_virt removed is 
the following:

If the virt_to_bus/bus_to_virt are fixed, Andrew might finally accept my 
patch to add -Werror-implicit-function-declaration to the CFLAGS (which 
he only rejected since it turned link errors into compile errors in his 
ppc64 builds). 

And -Werror-implicit-function-declaration is important since it will 
turn some nasty to debug runtime stack corruptions into compile errors.

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

