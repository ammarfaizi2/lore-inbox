Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUFCRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUFCRdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFCRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:31:35 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:26926 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264367AbUFCRbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:31:17 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: Stock IA64 kernel on SGI Altix 350
Date: Thu, 3 Jun 2004 10:30:36 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040603170147.GK10708@fi.muni.cz>
In-Reply-To: <20040603170147.GK10708@fi.muni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031030.36181.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, June 3, 2004 10:01 am, Jan Kasprzak wrote:
> I have a SGI Altix 350 IA64 machine (running SLES 8) for testing before
> it goes to the production use. I have succeeded recompiling and booting
> the SuSE distribution kernel (2.4.21+patches) from sources, but I have
> failed to compile/run any stock kernel from ftp.kernel.org (+ patches from
> kernel/ports/ia64/v2.[46]).

The 2.6 kernel, as of 2.6.0-test10 iirc, should work ok.  Recent kernels 
contain an 'sn2_defconfig' file that you can use to build a usable kernel:
  # tar zxf linux-2.6.6.tar.gz
  # cd linux-2.6.6
  # make sn2_defconfig
  # make -j<some high number> compressed
  # boot your kernel

But don't forget that you need to pass 'console=ttyS0' on your kernel boot 
line (it's easiest to add this to your elilo.conf file).

> 	Firstly, is there any Linux IA64-specific mailing list?
> The MAINTAINERS file points to www.linuxia64.org, which is probably
> expired (please update the MAINTAINERS file).

Yep, linux-ia64@vger.kernel.org

> 	Now the detailed description:
>
> ---------------------
> The 2.6.6 kernel + linux-2.6.6-ia64-040521.diff.bz2 patch compiled and
> linked correctly, but failed to boot (it did not print anything to the
> console):
>
> ELILO boot: 2.6.6 console=ttyS0
> Uncompressing Linux... done
>
> (and without "console=ttyS0" it was the same).

Is this with the sn2_defconfig file?  What PROM are you running?

>
> ---------------------
> The 2.4.26 kernel + linux-2.4.26-ia64-040510.diff.bz2 patch failed to link
> on my box with <asm/sn/idle.h> missing:

Stock (i.e. non-SGI or non-SuSE) 2.4 kernels won't work on Altix.  You need 
2.6.

> 	My .configs are at http://www.fi.muni.cz/~kas/tmp/ia64/.
> So is it possible to use stock kernel on Altix 350? Is there a better
> list to report this than lkml?

It should work fine.  And linux-ia64 is probably a better list (more chance of 
me seeing your message).

Jesse
