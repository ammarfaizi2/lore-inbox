Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWJSXdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWJSXdp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWJSXdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:33:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:13244 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751619AbWJSXdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:33:44 -0400
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
Cc: Olaf Hering <olaf@aepfle.de>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <45377ED3.9030001@bplan-gmbh.de>
References: <20061019122802.GA26637@aepfle.de>
	 <45377ED3.9030001@bplan-gmbh.de>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 09:33:28 +1000
Message-Id: <1161300808.10524.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 15:34 +0200, Nicolas DET wrote:
> Olaf Hering wrote:
>  > I get irq warnings with current Linus tree on Pegasos.
>  > The EDID handling for radeonfb appears to be broken as well,
>  > but thats a different story:
>  >
> 
> This patch enables chrp_pcibios_fixup() for bPlan's machine. however, 
> this function should NOT be called as thoses platforms.
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26c5032eaa64090b2a01973b0c6ea9e7f6a80fa7
> 
> An upcomming patch will "ppc_md.pcibios_fixup = NULL;" for every bPlan's 
> platforms.

Ugh ?

I'm not sure what the patch you pointed to has to do with fixups :)

Anyway, the irq code should work with Pegasos. I think the problem is
that it's missing a call to irq_set_default_host() on the i8259 when no
MPIC is present. It's strange, I though I had it... BriQ needs it too.

Ben.


