Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285065AbRLLDPH>; Tue, 11 Dec 2001 22:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285063AbRLLDO6>; Tue, 11 Dec 2001 22:14:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20744 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284812AbRLLDOq>; Tue, 11 Dec 2001 22:14:46 -0500
Message-ID: <3C16CA8F.722CB6BB@zip.com.au>
Date: Tue, 11 Dec 2001 19:10:07 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt <matt@progsoc.uts.edu.au>
CC: Berend De Schouwer <bds@jhb.ucs.co.za>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za> <3C16ADB1.F9E847E9@zip.com.au>,
		<3C16ADB1.F9E847E9@zip.com.au>; from akpm@zip.com.au on Tue, Dec 11, 2001 at 05:06:57PM -0800 <20011212135713.M5809@ftoomsh.progsoc.uts.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> 
> speaking of living in module memory, a similar thing happens with the
> via-rhine driver. after my machine has been up for a few hours the
> "via-rhine" string in /proc/iomem and /proc/ioports gets over written
> and prints garbage. since this has never been the cause for an oops on
> my machine i never bothered reporting it. if anyone wants details i'll
> provide.
> 

I think it _could_ oops.  Would it be correct to assume that
you're linking the driver into the kernel, rather than using it
as a module?

--- linux-2.4.17-pre8/drivers/net/via-rhine.c	Mon Dec 10 13:46:21 2001
+++ linux-akpm/drivers/net/via-rhine.c	Tue Dec 11 19:08:17 2001
@@ -161,7 +161,7 @@ static char version[] __devinitdata =
 KERN_INFO "via-rhine.c:v1.10-LK1.1.12  03/11/2001  Written by Donald Becker\n"
 KERN_INFO "  http://www.scyld.com/network/via-rhine.html\n";
 
-static char shortname[] __devinitdata = "via-rhine";
+static char shortname[] = "via-rhine";
 
 
 /* This driver was written to use PCI memory space, however most versions
