Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSGSA6E>; Thu, 18 Jul 2002 20:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318412AbSGSA6E>; Thu, 18 Jul 2002 20:58:04 -0400
Received: from mail.myrio.com ([63.109.146.2]:48114 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S315483AbSGSA6D>;
	Thu, 18 Jul 2002 20:58:03 -0400
Subject: Question regarding exported symbols
From: Nat Ersoz <nat.ersoz@myrio.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 18 Jul 2002 18:05:55 -0700
Message-Id: <1027040755.2586.430.camel@ersoz.et.myrio.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 19 Jul 2002 01:00:59.0402 (UTC) FILETIME=[BEC52EA0:01C22EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am trying to dynamically load a video frambuffer module, rather than
compile it into the kernel (it is the Geode framebuffer module).

=== 1. Prior to modification, I get the following error when performing
a "make modules_install":


find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.18-i3m;
fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-i3m/kernel/drivers/video/geode/geode.o
depmod:         PROC_CONSOLE
depmod:         set_all_vcs
make: *** [_modinst_post] Error 1

=== 2. I find that these functions are defined in the file:

linux-2.4.18/drivers/video/fbcon.c

So I add the following 2 lines to fbcon.c in order to export the functions for use
by geode.o:

EXPORT_SYMBOL(set_all_vcs);
EXPORT_SYMBOL(PROC_CONSOLE);


Once I recompile the kernel (make bzImage), I find that the System.map
is updated with the following entries:

c0185ed0 T PROC_CONSOLE
c0185f30 T set_all_vcs

So it appears that the kernel has proper (.text) entry points for my 2
newly exported functions.

=== 3. I then proceed with "make modules", and then "make
modules_install" - yet I still get the same error when make
modules_install completes:

depmod: *** Unresolved symbols in
/lib/modules/2.4.18-i3m/kernel/drivers/video/geode/geode.o
depmod:         PROC_CONSOLE
depmod:         set_all_vcs
make: *** [_modinst_post] Error 1


=== HELP!

Thanks,

Nat

-- 
_________________________________________
Nat Ersoz             Myrio Corporation    -o) 
nat.ersoz@myrio.com   Cell: 425-417-5182   /\\
Phone: 425.897.7278   Fax:  425.897.5600  _\_V
3500 Carillon Point   Kirkland, WA 98033 

