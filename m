Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVAYDZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVAYDZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVAYDZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:25:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:55229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261781AbVAYDZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:25:47 -0500
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <16885.13185.849070.479328@alkaid.it.uu.se>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	 <1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	 <16885.13185.849070.479328@alkaid.it.uu.se>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 14:25:14 +1100
Message-Id: <1106623515.6244.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 18:42 +0100, Mikael Pettersson wrote:
> Benjamin Herrenschmidt writes:
>  > On Sun, 2005-01-23 at 11:43 +1100, Benjamin Herrenschmidt wrote:
>  > 
>  > > I know about this problem, I'm working on a proper fix. Thanks for your
>  > > report.
>  > 
>  > Can you send me the PVR value for both of these CPUs
>  > (cat /proc/cpuinfo) ? I can't find right now why they would lock up
>  > unless the default idle loop is _not_ run properly, that is for some
>  > reason, NAP or DOZE mode end up not beeing enabled. Can you send me
>  > your .config as well ?
> 
> === cpuinfo.emac ===
> processor	: 0
> cpu		: 7447/7457, altivec supported
> clock		: 1249MHz
> revision	: 1.1 (pvr 8002 0101)
> bogomips	: 830.66
> machine		: PowerMac6,4
> motherboard	: PowerMac6,4 MacRISC3 Power Macintosh 
> detected as	: 287 (Unknown Intrepid-based)
> pmac flags	: 00000000
> L2 cache	: 512K unified
> memory		: 256MB
> pmac-generation	: NewWorld

Ok, it's normal that the Beige G3 doesn't do NAP, and the 7455 cannot do
DOZE, so I suspect it's all normal and my patch fixes it.

However, the eMac should have been doing NAP. Can you check what's up in
arch/ppc/plaform/pmac_feature.c with powersave_nap ? is it set at all ?
It should be visible from userland at /proc/sys/kernel/powersave-nap
and should be set to 1 by default on your machine... unless your cpu
node in the device-tree has the "flush-on-lock" property...
 
Ben.


