Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbTGJWsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269668AbTGJWsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:48:39 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:46977 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269662AbTGJWsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:48:37 -0400
Subject: Re: My own 3.5G patch plus question on Ingo's 4G/$G patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Chuck Luciano <chuck@mrluciano.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <NFBBKNADOLMJPCENHEALKEAHGBAA.chuck@mrluciano.com>
References: <NFBBKNADOLMJPCENHEALKEAHGBAA.chuck@mrluciano.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057878139.1413.11.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jul 2003 16:02:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 12:09, Chuck Luciano wrote:
> I've been working on a patch for 2.4.18 that allows PAGE_OFFSET
> to be set on boundarys other then 1GB multiples. I started with
> a patch that I got from Martin Bligh and back ported it to 2.4.18.

I stole the configurable PAGE_OFFSET code from Andrea, made it work with
partial kernel pmds, and stuck it in Martin's tree.  There are several
parts to it, and I'm not sure which ones you got.

> http://www.mrluciano.com/chuck/linux-2.4.18-unaligned.patch
> 
> I'll apologize in advance for not having figured out how the configure
> system works, so, when you apply this patch it's on. Also, you have to
> edit vmlinux.lds AND page.h to move the boundary.

Here's the 2.5 patch to do the configuration: 
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.73/2.5.73-mjb1/102-config_page_offset
You'll have to adapt the arch/i386/Kconfig stuff to 2.4, but there's a
good example of it here:
http://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc8aa1/00_3.5G-address-space-5
(which is where I stole the code from to begin with)

Instead of changing _all_ of the loops which touch PMDs, I suggest you
clean it up inside of the pmd function themselves.  All of these are
confusing:
+		if (start + PGDIR_SIZE < start)
+			break;


-- 
Dave Hansen
haveblue@us.ibm.com

