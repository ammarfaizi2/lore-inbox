Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRJTGiR>; Sat, 20 Oct 2001 02:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274544AbRJTGiH>; Sat, 20 Oct 2001 02:38:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:20229 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S273588AbRJTGiD>;
	Sat, 20 Oct 2001 02:38:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL 
In-Reply-To: Your message of "Fri, 19 Oct 2001 13:07:37 MST."
             <Pine.LNX.4.40.0110191257070.9276-100000@dlang.diginsite.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Oct 2001 16:38:25 +1000
Message-ID: <28610.1003559905@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001 13:07:37 -0700 (PDT), 
David Lang <david.lang@digitalinsight.com> wrote:
>the problem posted is that a BSD no adv licence is GPL compatable and
>source may be available and therefor BSD no adv modules should not taint
>the kernel, on the other hand it's possible to have a BSD no adv licensed
>module that the source is not available for and therefor it should taint
>the kernel.

Do not cc: me on this thread.

Check module.h and insmod.c before making statements like that.  The
BSD no advert license is not considered GPL compatible in the kernel.
Only Dual BSD/GPL is non-tainting, because the code is also available
under the GPL.  Anybody taking advantage of the BSD no adv license to
create a binary only module will be tainted.

That causes a problem for some modules in the kernel tree that have the
BSD no advert license.  Ideally these should be changed to dual BSD/GPL
but that may not be possible.  Since their source code is always
available, we might change them to

  "BSD without advertisement clause, source is in the kernel tree"

and add that string to the non-tainting list.  BSD no advert code that
is not in the kernel tree can either switch to dual BSD/GPL or be
tainted, at the choice of the supplier.

The affected code in the kernel tree is

drivers/net/bsd_comp.c
drivers/net/pcmcia/wavelan_cs.c
drivers/net/ppp_deflate.c
drivers/net/slhc.c
drivers/net/strip.c
drivers/scsi/advansys.c
drivers/scsi/dpt_i2o.c
drivers/scsi/pci2000.c
drivers/scsi/pci2220i.c
drivers/scsi/u14-34f.c
fs/nls/nls_cp1251.c
fs/nls/nls_cp1255.c
fs/nls/nls_cp437.c
fs/nls/nls_cp737.c
fs/nls/nls_cp775.c
fs/nls/nls_cp850.c
fs/nls/nls_cp852.c
fs/nls/nls_cp855.c
fs/nls/nls_cp857.c
fs/nls/nls_cp860.c
fs/nls/nls_cp861.c
fs/nls/nls_cp862.c
fs/nls/nls_cp863.c
fs/nls/nls_cp864.c
fs/nls/nls_cp865.c
fs/nls/nls_cp866.c
fs/nls/nls_cp869.c
fs/nls/nls_cp874.c
net/ipv4/netfilter/ipchains_core.c

