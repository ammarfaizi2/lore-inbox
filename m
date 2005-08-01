Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVHAGgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVHAGgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVHAGgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:36:14 -0400
Received: from ozlabs.org ([203.10.76.45]:19933 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262342AbVHAGgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:36:12 -0400
Date: Mon, 1 Aug 2005 16:35:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olaf Hering <olh@suse.de>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove another fixed address constraint
Message-ID: <20050801063554.GC13052@localhost.localdomain>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
References: <20050725061635.GD19817@localhost.localdomain> <20050801062929.GA22102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801062929.GA22102@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 08:29:29AM +0200, Olaf Hering wrote:
>  On Mon, Jul 25, David Gibson wrote:
> 
> > Presently the LparMap, one of the structures the kernel shares with
> > the legacy iSeries hypervisor has a fixed offset address in head.S.
> > This patch changes this so the LparMap is a normally initialized
> > structure, without fixed address.  This allows us to use macros to
> > compute some of the values in the structure, which wasn't previously
> > possible because the assembler always uses signed-% which gets the
> > wrong answers for the computations in question.
> > 
> > Unfortunately, a gcc bug means that doing this requires another
> > structure (hvReleaseData) to be initialized in asm instead of C, but
> > on the whole the result is cleaner than before.
> 
> I think this change caused this compile error in rc4:
> 
> {standard input}: Assembler messages:
> {standard input}:254: Error: value of 4000000000002080 too large for field of 4 bytes at 0000000000002108
> make[1]: *** [arch/ppc64/kernel/LparData.o] Error 1
> 
> binutils-2.16.91.0.2
> gcc-4.0.2_20050727

Hrm.. definitely works here.  Is this with any other patches?  Can you
send the .s file?  That might help be debug it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
