Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUAJBjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 20:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUAJBjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 20:39:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20433 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264507AbUAJBjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 20:39:49 -0500
Date: Sat, 10 Jan 2004 02:39:44 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, ralf@gnu.org
Subject: [2.4 patch] fix CONFIG_DS1742 Config.in entry
Message-ID: <20040110013944.GI25089@fs.tum.de>
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2EAB3.1090001@xss.co.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 04:26:43PM +0100, Andreas Haumer wrote:
> 
> Hi!

Hi Andreas!

> Marcelo Tosatti wrote:
> > Hi,
> >
> > Here goes -pre3. It contains a PPC32/SPARC update, some i2c cleanups, LVM
> > update, network update, a new WAN driver, amongst others.
> >
> Great!
> 
> > It should show up in ftp.kernel.org in a few minutes.
> >
> Here's a first report:
> 
> *) (small) problems with "make xconfig"
>    - "Dallas DS1742 RTC support" can be selected on x86 platform,
>      though it can't be compiled
>...

Thanks for this report.

This was due to a small syntax error introduced by the MIPS char driver 
update.

The following patch fixes this issue:

--- linux-2.4.25-pre4-full/drivers/char/Config.in.old	2004-01-10 02:33:41.000000000 +0100
+++ linux-2.4.25-pre4-full/drivers/char/Config.in	2004-01-10 02:35:48.000000000 +0100
@@ -323,7 +323,7 @@
 if [ "$CONFIG_SGI_IP27" = "y" ]; then
    bool 'SGI M48T35 RTC support' CONFIG_SGI_IP27_RTC
 fi
-if [ "$CONFIG_TOSHIBA_RBTX4927" = "y" -o "$CONFIG_TOSHIBA_JMR3927" ]; then
+if [ "$CONFIG_TOSHIBA_RBTX4927" = "y" -o "$CONFIG_TOSHIBA_JMR3927" = "y" ]; then
    tristate 'Dallas DS1742 RTC support' CONFIG_DS1742
 fi
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

