Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUHEOWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUHEOWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUHEOT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 10:19:28 -0400
Received: from imap.gmx.net ([213.165.64.20]:993 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267723AbUHEOR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 10:17:57 -0400
Date: Thu, 5 Aug 2004 16:17:56 +0200 (MEST)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: sam@ravnborg.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: confirmed: kernel build for 2.6.8-rc3 is broken for at least i386
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <2695.1091715476@www33.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

thanks for your qualified hints.
I tried as you did suggest it to me and then it works in the subdir.
Then i retried with "make bzImage" and came to that point in 
compilation for the origin of the failure. (see appended log,
"noise" on language macros an similar stripped...)

As you, and possibly others can see,
the compilation happens from the arch/i386/kernel/timers subdir,
where we got lead to by th arch/i386/kernel subdir directly
and in this case the needed settings seem to lack despite they
were present in a former stage of the compilation.

Having a qualified fix done by a skilled person for that bad behaviour
in any future standard kernel would be nice thing. Thank you so far.

-Alex.
(please CC me in replys, i am not subscribed to this list)


make -f scripts/Makefile.build obj=scripts/basic                            
   
make -f scripts/Makefile.build obj=scripts                                  
   
make -f scripts/Makefile.build obj=scripts/mod                              
   
make -f scripts/Makefile.build obj=arch/i386/kernel
arch/i386/kernel/asm-offsets
.s                                                                          
   
arch/i386/kernel/Makefile:70: AFLAGS-lds=-P -C -Ui386                       
   
arch/i386/kernel/Makefile:71: aflags=
make -f scripts/Makefile.build obj=init
make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/i386/kernel                         
   
arch/i386/kernel/Makefile:70: AFLAGS-lds=                                   
   
arch/i386/kernel/Makefile:71: aflags=                                       
   
make -f scripts/Makefile.build obj=arch/i386/kernel/acpi                    
   
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu                     
   
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mcheck              
   
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/mtrr                
   
make -f scripts/Makefile.build obj=arch/i386/kernel/timers                  
   
  gcc -E -Wp,-MD,arch/i386/kernel/.vmlinux.lds.s.d -nostdinc -iwithprefix
includ
e -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ -Iinclude/asm-i386/mach-default
-tradit
ional     -o arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/vmlinux.lds.S
[...]

until it fails for the linking when using the generated lds.s file.

-- 
NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

