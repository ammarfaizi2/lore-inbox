Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVIAO7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVIAO7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVIAO7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:59:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62172 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965179AbVIAO7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:59:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali N Iyer <mniyer@us.ibm.com>
Subject: Re: [PATCH,RFC] Move Cell platform code to arch/powerpc
Date: Thu, 1 Sep 2005 17:00:17 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org, linuxppc64-dev-bounces@ozlabs.org,
       Paul Mackerras <paulus@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>
References: <OF16E84E87.433792E2-ON8625706F.001777A1-8625706F.00180C3A@us.ibm.com>
In-Reply-To: <OF16E84E87.433792E2-ON8625706F.001777A1-8625706F.00180C3A@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200509011700.20759.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 01 September 2005 06:22, Murali N Iyer wrote:
> Architecture "cell" seems to be fine. What is your thought on supporting
> multiple different hardware configurations under cell. I think this patch
> has been tested only in CPBW hardware.  For example "+++

My general idea about future Cell based products is that we make the
changes to the platform code at the time we add new code. Of course,
a number of companies are working on designs that I have no insight in,
so I'll just wait what comes, but at least I've tried to make it
easy to add the stuff that I know about.

> linux-cg/arch/ppc64/kernel/bpa_nvram.c" assumes one particular hardware
> which may not be true for different hardware configurations.

Yes, this one is a bit odd. On the one hand, it is very generic and could
be used for any future open firmware or flat device tree based system
(even non-PowerPC). On the other hand, it works only on one particular
board design currently.

I don't really care about where this is put, ranging from:

arch/{ppc64,powerpc}/kernel/of_nvram.c, meaning that everyone using the
	flat device tree can just add an "nvram" node that will work with
	this driver.

arch/powerpc/platforms/cell/cellblade_nvram.c, to keep it specific to
	the one design that we have, assuming that future Cell based
	designs will use something else.

	Arnd <><
