Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbTAEIy4>; Sun, 5 Jan 2003 03:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTAEIy4>; Sun, 5 Jan 2003 03:54:56 -0500
Received: from otaku.freeshell.org ([207.202.214.131]:60922 "EHLO
	sdf.lonestar.org") by vger.kernel.org with ESMTP id <S264010AbTAEIyz>;
	Sun, 5 Jan 2003 03:54:55 -0500
Date: Sun, 5 Jan 2003 01:03:21 -0800
From: Kannan Soundarapandian <isildur@sdf.lonestar.org>
To: groudier@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: sym_glue.c file typo
Message-ID: <20030105090320.GA10622@sdf.lonestar.org>
References: <20030105073229.GA9592@sdf.lonestar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105073229.GA9592@sdf.lonestar.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm having a problem with the sym53c8xx_2 driver.

I'm getting pretty much nowhere mucking around by myself. I don't know if I'm missing something very simple, but the sym53c8xx_2 driver (built into the kernel) seems to just completely ignore my onboard LSI 53C1010-33 controller.

It was working perfectly with the 2.4 series of kernels.  My parameters are as follows:

Linux kernel : 2.5.53
Machine Specs: Dual P-III 1GHz SMP
Motherboard  : Asus CUR-DLS with Serverwrks LE chipset
Controller chip: LSI 53C1010-33
HDD : Quantum Atlas 10K2

During Boot-up I get an error like so:

HBA driver sym53c8xx didn't set a release method, please fix the template

but looking at the source in hosts.c, this seems to be more of a warning than an error, since a default value is being set anyway.

Setting the boot time verbosity parameter to 2 (maximum) causes the configuration parameters to be echoed by the sym53c8xx driver during boot-up but nothing more.

I'm quite confused now. This driver used to work quite well with the 2.4 series kernels. Another thing is that doing a diff on the files sym_hipd.c in the 2.4.19 sources and the 2.5.53 sources shows the following:

diff sym_hipd.c ../../../../linux-2.5.53/drivers/scsi/sym53c8xx_2/sym_hipd.c
53c53
< #define SYM_DRIVER_NAME       "sym-2.1.17a"
---
> #define SYM_DRIVER_NAME       "sym-2.1.16a"


ie.. the newer kernel has the lower version number. IS this how its supposed to be? I did apply some patches (I lost track of which) a while ago to my 2.4.19 kernel though.. I don't know if that updated any drivers.

Anyways, can someone please point me to where I can find the latest version of this driver please? or let me know if any solution occurs to you. I'd be happy to furnish any other details.

Thanks a lot in advance. Kindly CC any replies to this address

Kannan


On Sat, Jan 04, 2003 at 11:32:29PM -0800, Kannan Soundarapandian wrote:
> Hi,
> 
> There's a non-critical typo in the file sym_glue.c in the new 2.5 series kernels on line 2221. It says
>                 "verb:%d,debug:0x%x,setlle_delay:%d\n",
> should be:
>                 "verb:%d,debug:0x%x,settle_delay:%d\n",
> in file :
> linux/drivers/scsi/sym53c8xx_2/sym_glue.c
> 
> I am having a lot of trouble getting my scsi card to be detected by the kernel. I am testing version 2.5.53 right now and have compiled in support for sym53c8xx_2, sd and generic scsi into the kernel. 
> 
> During boot up the scsi driver shows signs of life when I use a verbosity level of 2 but doesn't seem to recognise my card. I am still trying out everything and anything. I will get back to you if I really hit the bottom.
> 
> fyi, My machine is a Dual processor P-III 1GHz machine with the Serverworks LE chipset. If you can think of anything please do let me know.
> 
> Thanks very much for your work and time :-) Great driver btw. It works perfectly with the 2.4 series kernels.
> 
> -- 
> ---------------------------------------------------------------
> Kannan Soundarapandian, 
> OSU, Corvallis, OR-97330.
> ---------------------------------------------------------------
> SDF Public Access UNIX System - Powered by NetBSD 1.5!
> 
> 
> 
> 
> 
> ~~~

-- 
---------------------------------------------------------------
Kannan Soundarapandian, 
OSU, Corvallis, OR-97330.
---------------------------------------------------------------
SDF Public Access UNIX System - Powered by NetBSD 1.5!





~~~
