Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVG1Udm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVG1Udm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVG1Ub0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:31:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:777 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262186AbVG1U3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:29:45 -0400
Date: Thu, 28 Jul 2005 22:29:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050728202943.GA4790@stusta.de>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42E957B5.8040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E957B5.8040606@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 10:09:57PM +0000, Michael Thonke wrote:

> Hello Andrew,
> 
> I have some questions :-)
> Reiser4:
> 
> why there are undefined functions implemented that currently not in use?
> This messages appeared first time in 2.6.13-rc3-mm2.
> 
> Any why it complains even CONFIG_REISER4_DEBUG is not set?
> Please have a look at  the -->snip

These aren't functions, these are #if FOO where FOO isn't #define'd.
In most such cases, changing the #if ti #ifdef fixes the issue (and in 
some rare cases these warnings fix bugs).

Since 2.6.13-rc3-mm2 the gcc Warning for such things was activated.

> SCSI:
> 
> CONFIG_SCSI_QLA2XXX=y ? I haven't choose that one..I never did..and 
> where is the config located?
> In the place where it is..is no option marked.

It's located in drivers/scsi/qla2xxx/Kconfig.

It shouldn't [1] activate any code, it's simply a helper option that 
tells whether the QLA* options should be shown.

> Thanks for help,
> 
> Greets
>    Michael
> 
> 
> --> snip
> fs/reiser4/plugin/item/static_stat.c:1158:5: warning: 
> "REISER4_DEBUG_OUTPUT" is not defined
> fs/reiser4/plugin/item/static_stat.c:1176:5: warning: 
> "REISER4_DEBUG_OUTPUT" is not defined
> fs/reiser4/plugin/item/static_stat.c:1194:5: warning: 
> "REISER4_DEBUG_OUTPUT" is not defined
> fs/reiser4/plugin/item/static_stat.c:1213:5: warning: 
> "REISER4_DEBUG_OUTPUT" is not defined
>  CC      fs/reiser4/plugin/item/sde.o
> In file included from fs/reiser4/plugin/item/../plugin.h:26,
>                 from fs/reiser4/plugin/item/sde.c:11:
> fs/reiser4/plugin/item/../node/node40.h:83:5: warning: "GUESS_EXISTS" is 
> not defined
> fs/reiser4/plugin/item/sde.c:21:5: warning: "REISER4_DEBUG_OUTPUT" is 
> not defined
>  CC      fs/reiser4/plugin/item/cde.o
> In file included from fs/reiser4/plugin/item/../plugin.h:26,
>                 from fs/reiser4/plugin/item/cde.c:65:
> fs/reiser4/plugin/item/../node/node40.h:83:5: warning: "GUESS_EXISTS" is 
> not def

cu
Adrian

[1] that's currently not completely true, but the problem will soon be
    fixed

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

