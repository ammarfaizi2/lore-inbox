Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVCRQ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVCRQ0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCRQ0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:26:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:28354 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261677AbVCRQY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:24:29 -0500
Message-ID: <423B00B4.3080703@austin.ibm.com>
Date: Fri, 18 Mar 2005 10:24:20 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ppc64 build broke between 2.6.11-bk6 and 2.6.11-bk7
References: <445800000.1111127533@[10.10.2.4]>	<20050317224409.41f0f5c5.akpm@osdl.org> <16954.40800.839009.64848@alkaid.it.uu.se>
In-Reply-To: <16954.40800.839009.64848@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Andrew Morton writes:
>  > "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>  > >
>  > > drivers/built-in.o(.text+0x182bc): In function `.matroxfb_probe':
>  > > : undefined reference to `.mac_vmode_to_var'
>  > > make: *** [.tmp_vmlinux1] Error 1
>  > > 
>  > > Anyone know what that is?
>  > > 
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/broken-out/fbdev-kconfig-fix-for-macmodes-and-ppc.patch
>  > 
>  > should fix it.
> 
> It seems the culprit is "matroxfb-compile-error.patch" which unconditionally adds
> macmodes.o to the Makefile line for CONFIG_FB_MATROX. This obviously breaks on !ppc.
> The patch Andrew mentions above converts the Kconfig entry for FB_MATROX to do a
> "select FB_MACMODES if PPC_PMAC", so dropping matroxfb-compile-error.patch should suffice.
> 
> 

matroxfb-compile-error.patch was a valid fix for a compile problem. It 
was against 2.6.11-bk10, therefore wasn't in the 2.6.11-bk6 or 2.6.11bk7 
you had problems with and didn't cause this mess to begin with.

It appears the problem was more systemic than what I saw during my 
compile, thus the fbdev-kconfig-fix-for-macmodes-and-ppc.patch probably 
fixes the problem I fixed and a host of others.  Of course it conflicts 
with my patch.

Please drop the matroxfb-compile-error.patch and if the problem isn't 
truly fixed by fbdev-kconfig-fix-for-macmodes-and-ppc.patch I will 
resend it.
