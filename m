Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTIVVIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbTIVVIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:08:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:19103 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263303AbTIVVIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:08:35 -0400
Message-Id: <200309222108.h8ML8Tp22032@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Tom Rini <trini@kernel.crashing.org>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, cliffw@osdl.org
Subject: Re: 2.6.0-test5 - powermac compile problem "incorrect section 
 attributes for .plt"
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org> 
   of "Mon, 22 Sep 2003 09:21:57 PDT." <20030922162156.GI7443@ip68-0-152-218.tc.ph.cox.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Sep 2003 14:08:29 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 19, 2003 at 03:08:32PM -0700, Cliff White wrote:
> 
> > System is an iBook2,
> > distro is Debian unstable
> > kernel is 2.6.0-test5 or current from
> > bk://ppc.bkbits.net/linuxppc-2.5
> > 
> > gcc version 3.3.2 20030908 (Debian prerelease)
> > 
> > When compiling modules, i get this warning, repeatedly:
> >  CC [M]  sound/ppc/pmac.o
> > {standard input}: Assembler messages:
> > {standard input}:3: Warning: setting incorrect section attributes for .plt
> > 
> > Then, this failure:
> > 
> >   AS      arch/ppc/boot/common//util.o
> > arch/ppc/boot/common/util.S: Assembler messages:
> > arch/ppc/boot/common/util.S:220: Warning: setting incorrect section attributes 
> > for .relocate_code
> > arch/ppc/boot/common//util.o: File truncated
> > arch/ppc/boot/common/util.S:281: FATAL: Can't write 
> > arch/ppc/boot/common//util.o: File truncated
> > make[2]: *** [arch/ppc/boot/common//util.o] Error 1
> > make[1]: *** [arch/ppc/boot/common/] Error 2
> > 
> > Suggestions appreciated.
> 
> I suspect this is a binutils bug.  But can you try the following?  We
> shouldn't need a '.previous' here, as it is the end of the file anyhow.
> 
I believe this is a binutils bug. 
I tried this patch, did not change my symptoms.

I down-rev'd binutils from 2.14.90.0.6 -> 2.14.90.0.1, built
from source and i have a working kernel, however i still see the .plt 
errors on some modules.
cliffw

> ===== arch/ppc/boot/common/util.S 1.6 vs edited =====
> --- 1.6/arch/ppc/boot/common/util.S	Thu Aug 21 10:17:00 2003
> +++ edited/arch/ppc/boot/common/util.S	Mon Sep 22 09:21:37 2003
> @@ -277,6 +277,3 @@
>  	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
>  	bdnz	00b
>  10:	blr
> -
> -	.previous
> -
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/


