Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbVAYXnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbVAYXnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 18:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAYXmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 18:42:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55570 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262217AbVAYXj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 18:39:57 -0500
Date: Tue, 25 Jan 2005 23:39:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: Ian Molton <spyro@f2s.com>, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050125233949.C30094@flint.arm.linux.org.uk>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Ian Molton <spyro@f2s.com>, akpm@osdl.org, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <41F6CFF2.7010907@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41F6CFF2.7010907@f2s.com>; from spyro@f2s.com on Tue, Jan 25, 2005 at 11:02:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:02:10PM +0000, Ian Molton wrote:
> Anton Blanchard wrote:
> 
>  > As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:
>  >
>  > include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1

I don't think Anton can count.  (and for some reason I seem to be missing
his mail at the moment.)

include/asm-arm/pgtable.h:#define FIRST_USER_PGD_NR     1

there's two.  FIRST_USER_PGD_NR was created specifically for ARM because
many of our CPUs place their hardware vector tables at *virtual* address
zero.  Unmapping this virtual page would be rather bad for the system -
consider the effect of unmapping the code for *all* CPU exceptions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
