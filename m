Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSFNWSo>; Fri, 14 Jun 2002 18:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314551AbSFNWSn>; Fri, 14 Jun 2002 18:18:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50133 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314548AbSFNWSn>;
	Fri, 14 Jun 2002 18:18:43 -0400
Subject: Re: [Patch] tsc-disable_A5
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: davej@suse.de, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, marcelo@conectiva.com.br
In-Reply-To: <200206142153.XAA03026@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Jun 2002 15:11:37 -0700
Message-Id: <1024092697.29929.195.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-06-14 at 14:53, Mikael Pettersson wrote:
> Unless my memory is failing me, I believe the simplest approach
> is to (1) don't set CONFIG_X86_TSC, and (2) pass "notsc" as a
> kernel boot parameter.

Correct, and this patch basically does both of the above. 

The problem is that CONFIG_X86_TSC is enabled on PPro and above cpus.
The machines which are having this problem are multi-node P3 or P4
systems. Each cpu has a working TSC, its just that because they are not
synced they should not be used. 

So the patch adds a CONFIG_DISABLE_TSC which is then checked where
earlier just CONFIG_X86_TSC was used. Additionally, if
CONFIG_DISABLE_TSC is set, the flag set by "notsc" is also set.

The usage of CONFIG_X86_TSC took me a bit to get my head around
initially, so your clarification is helpful.

Thanks
-john




