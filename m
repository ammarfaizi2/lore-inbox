Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270365AbTHLOU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHLOU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:20:57 -0400
Received: from web41103.mail.yahoo.com ([66.218.93.19]:907 "HELO
	web41103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270365AbTHLOUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:20:54 -0400
Message-ID: <20030812142053.99571.qmail@web41103.mail.yahoo.com>
Date: Tue, 12 Aug 2003 16:20:53 +0200 (CEST)
From: =?iso-8859-1?q?Davide=20Prina?= <davideprina@yahoo.com>
Subject: duplicate definition of EISA_bus compiling 2.4.22-rc2 with gcc 3.3.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1.] One line summary of the problem:    
Kernel compilation: duplicate definition of EISA_bus

[2.] Full description of the problem/report:
I'm compiling the kernel 2.4.22-rc2, I'm done a lot of compilation of that with
different parameters and only one time I have had that error: duplicate
definition of EISA_bus in:
.../include/linux/modules/i386_ksyms.ver
and
.../include/asm/processor.h

probably I have set something in .config that has generated it (I always create
.config with make xconfig)

I'm using gcc 3.3.1 on a Debian Woody

I have solved the problem changing the code of processor.h

#ifdef CONFIG_EISA
extern int EISA_bus;
#else
#define EISA_bus (0)
#endif

with the following

#ifdef CONFIG_EISA
extern int EISA_bus;
#else
#undef EISA_bus
#define EISA_bus (0)
#endif

because I don't have a EISA slot and I haven't select it in the .config file
Probably not always the CONFIG_EISA definition is set where the EISA_bus is
defined

[3.] Keywords (i.e., modules, networking, kernel):
kernel, compiling

[4.] Kernel version (from /proc/version):
I have 2.4.18 and I'm compiling 2.4.22-rc2

Ciao
Davide

=====
______________________________________________________________
OpenOffice: la migliore suite per l'ufficio                http://it.openoffice.org  
GNU/Linux: il miglior sistema operativo                 http://www.it.debian.org
______________________________________________________________

______________________________________________________________________
Yahoo! Mail: 6MB di spazio gratuito, 30MB per i tuoi allegati, l'antivirus, il filtro Anti-spam
http://it.yahoo.com/mail_it/foot/?http://it.mail.yahoo.com/
