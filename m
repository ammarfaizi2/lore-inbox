Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317819AbSHHShZ>; Thu, 8 Aug 2002 14:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317785AbSHHShZ>; Thu, 8 Aug 2002 14:37:25 -0400
Received: from Klinzha.ghb.fh-furtwangen.de ([141.28.227.241]:20491 "EHLO
	klinzha.ghb.fh-furtwangen.de") by vger.kernel.org with ESMTP
	id <S317819AbSHHShX>; Thu, 8 Aug 2002 14:37:23 -0400
Date: Thu, 8 Aug 2002 20:42:26 +0200
To: linux-kernel@vger.kernel.org
Subject: error in kernel source
Message-ID: <20020808184226.GA9549@klinzha.ghb.fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Alexander Martinez <alex@klinzha.ghb.fh-furtwangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please forgive me, if I'm at the wrong place for this error report and send
it to the right place for further notice.

There's an error in kernel source for linux-2.5.30 in file
sound/oss/viavia82cxxx_audio.c when compiling via audio as a module.

This is the exact error message:
gcc -Wp,-MD,./.via82cxxx_audio.o.d -D__KERNEL__
-I/usr/src/linux-2.5.29/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc
-iwithprefix include -DMODULE -include
/usr/src/linux-2.5.29/include/linux/modversions.h
-DKBUILD_BASENAME=via82cxxx_audio   -c -o via82cxxx_audio.o via82cxxx_audio.c
via82cxxx_audio.c:824: macro synchronize_irq' used without args
make[2]: *** [via82cxxx_audio.o] Error 1
make[2]: Leaving directory /usr/src/linux-2.5.29/sound/oss'
make[1]: *** [oss] Error 2


when I change line 824 in via82cxxx_audio.c from

synchronize_irq();

to

synchronize_irq(&card->irq);

then the compile succeeds. After installing the new kernel and rebooting the
via sound chip works, so I think that I've done it right.

I just wanted to report this error, so somebody can fix it in the official
kernel source.


Output of scripts/ver_linux follows (just in case that it's useful ...)

Greetings,

Alex

-------------------------------------------------------------------------------

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
 Linux stovokor 2.5.29 #1 Thu Aug 8 17:22:59 CEST 2002 i686 unknown unknown
GNU/Linux
 
 Gnu C                  2.95.4
 Gnu make               3.79.1
 util-linux             2.11n
 mount                  2.11n
 modutils               2.4.15
 e2fsprogs              1.27
 PPP                    2.4.1
 Linux C Library        2.2.5
 Dynamic linker (ldd)   2.2.5
 Procps                 2.0.7
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               2.0.12
 Modules Loaded         ipt_ttl ipt_tos ipt_tcpmss ipt_owner ipt_multiport
ipt_mark ipt_mac ipt_limit ipt_length ipt_esp ipt_unclean ipt_ah ipt_ULOG
ipt_TCPMSS ipt_REJECT ipt_REDIRECT ipt_MIRROR ipt_MASQUERADE iptable_nat
ip_conntrack ipt_LOG ip_tables uhci-hcd thermal processor fan button battery
ac zlib_inflate zlib_deflate nls_utf8 ext3 jbd sr_mod 8139too mii crc32
parport_pc lp parport loop nbd sg ide-scsi scsi_mod r128 agpgart
via82cxxx_audio soundcore ac97_codec scanner mousedev keybdev hid usbcore
evdev input nls_iso8859-15 nls_iso8859-1 nls_cp850 nls_cp437 smbfs vfat fat

------------------------------------------------------------------------------
