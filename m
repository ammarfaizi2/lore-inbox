Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFNS5x>; Fri, 14 Jun 2002 14:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSFNS5w>; Fri, 14 Jun 2002 14:57:52 -0400
Received: from ns.suse.de ([213.95.15.193]:65289 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S313508AbSFNS5v>;
	Fri, 14 Jun 2002 14:57:51 -0400
Date: Fri, 14 Jun 2002 20:57:52 +0200
From: Dave Jones <davej@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
Message-ID: <20020614205751.U16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	john stultz <johnstul@us.ibm.com>, marcelo@conectiva.com.br,
	lkml <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <1024079726.29929.131.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 11:35:26AM -0700, john stultz wrote:

 > This patch disables the TSCs when compiled for Multiquad NUMA hardware.
 > Due to the slower interconnect, the TSCs aren't being synced properly at
 > boot time. Even if they were synced, since the different nodes are
 > driven by different crystals, the TSCs still drift. 

-#ifndef CONFIG_X86_TSC
+#if !defined(CONFIG_X86_TSC)||defined(CONFIG_TSC_DISABLE)
+#ifdef CONFIG_TSC_DISABLE
+static int tsc_disable __initdata = 1;
+#else /*CONFIG_TSC_DISABLE*/
 static int tsc_disable __initdata = 0;
+#endif /*CONFIG_TSC_DISABLE*/

This looks *really horrible*
Why not just unset CONFIG_X86_TSC for those machines ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
