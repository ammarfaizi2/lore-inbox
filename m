Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVKOMeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVKOMeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKOMeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:34:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25303 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932422AbVKOMeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:34:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.54692.917859.828838@alkaid.it.uu.se>
Date: Tue, 15 Nov 2005 13:33:40 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] ppc: Fix boot with yaboot with ARCH=ppc
In-Reply-To: <1132039305.5646.17.camel@gaston>
References: <1132039305.5646.17.camel@gaston>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > The merge of machine types broke boot with yaboot & ARCH=ppc due to the
 > old code still retreiving the old-syle machine type passed in by yaboot.
 > This patch fixes it by translating those old numbers. Since that whole
 > mecanism is deprecated, this is a temporary fix until ARCH=ppc uses the
 > new prom_init that the merged architecture now uses for both ppc32 and
 > ppc64 (after 2.6.15)
 > 
 > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This fixed my eMac, thanks.

Acked-by: Mikael Pettersson <mikpe@csd.uu.se>

 > 
 > Index: linux-work/arch/ppc/kernel/setup.c
 > ===================================================================
 > --- linux-work.orig/arch/ppc/kernel/setup.c	2005-11-15 18:15:23.000000000 +1100
 > +++ linux-work/arch/ppc/kernel/setup.c	2005-11-15 18:18:37.000000000 +1100
 > @@ -602,7 +602,19 @@
 >  #endif /* CONFIG_BLK_DEV_INITRD */
 >  #ifdef CONFIG_PPC_MULTIPLATFORM
 >  		case BI_MACHTYPE:
 > -			_machine = data[0];
 > +			/* Machine types changed with the merge. Since the
 > +			 * bootinfo are now deprecated, we can just hard code
 > +			 * the appropriate conversion here for when we are
 > +			 * called with yaboot which passes us a machine type
 > +			 * this way.
 > +			 */
 > +			switch(data[0]) {
 > +			case 1: _machine = _MACH_prep; break;
 > +			case 2: _machine = _MACH_Pmac; break;
 > +			case 4: _machine = _MACH_chrp; break;
 > +			default:
 > +				_machine = data[0];
 > +			}
 >  			break;
 >  #endif
 >  		case BI_MEMSIZE:
 > 
 > 
 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
 > 
