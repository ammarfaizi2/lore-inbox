Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTKSNyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTKSNyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:54:18 -0500
Received: from holomorphy.com ([199.26.172.102]:48809 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264069AbTKSNyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:54:16 -0500
Date: Wed, 19 Nov 2003 05:54:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
Message-ID: <20031119135409.GU22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1069246427.5257.12.camel@localhost.localdomain> <20031119130220.GT22764@holomorphy.com> <1069248455.5257.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069248455.5257.26.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 14:02, William Lee Irwin III wrote:
>> What sound card?

On Wed, Nov 19, 2003 at 02:27:36PM +0100, Ronny V. Vindenes wrote:
> Hercules Fortissimo III (snd-cs46xx), there's also a Terratec EWX24/96
> (snd-ice1712) installed but it's not in active use.

Any chance you can try this?

This might help pinpoint the problem.


-- wli


diff -prauN mm4-2.6.0-test9-1/arch/i386/mm/fault.c mm4-2.6.0-test9-dbg-1/arch/i386/mm/fault.c
--- mm4-2.6.0-test9-1/arch/i386/mm/fault.c	2003-11-19 00:07:03.000000000 -0800
+++ mm4-2.6.0-test9-dbg-1/arch/i386/mm/fault.c	2003-11-19 05:51:51.000000000 -0800
@@ -354,6 +354,10 @@ good_area:
 		case VM_FAULT_OOM:
 			goto out_of_memory;
 		default:
+			if (vma->vm_ops && vma->vm_ops->nopage)
+				print_symbol(KERN_CRIT "bad nopage %s\n",
+						vma->vm_ops->nopage);
+			printk(KERN_CRIT "handle_mm_fault() returned bad status\n");
 			BUG();
 	}
 
