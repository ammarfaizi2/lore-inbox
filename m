Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315526AbSECBWA>; Thu, 2 May 2002 21:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSECBV6>; Thu, 2 May 2002 21:21:58 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:9982 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315526AbSECBVX>; Thu, 2 May 2002 21:21:23 -0400
Message-ID: <3CD1E60B.2E9FDD6F@eyal.emu.id.au>
Date: Fri, 03 May 2002 11:21:15 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8: compile failure - umem.c, sdla_fr.c
In-Reply-To: <Pine.LNX.4.21.0205021845430.10896-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here goes the pre8. I plan just one more -pre before starting the -rc
> stage.

I do not have the time to investigate this, so just the failure reports
follow.


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=umem  -c -o umem.o umem.c
umem.c:955: warning: `set_bh_page' redefined
/data2/usr/local/src/linux-2.4-pre/include/linux/modules/buffer.ver:8:
warning: this is the location of the previous definition
umem.c:136: field `tasklet' has incomplete type
umem.c: In function `mm_start_io':
umem.c:343: warning: right shift count >= width of type
umem.c: In function `mm_unplug_device':
umem.c:386: warning: implicit declaration of function `local_bh_disable'
umem.c:388: warning: implicit declaration of function `local_bh_enable'
umem.c: In function `mm_interrupt':
umem.c:646: warning: implicit declaration of function `tasklet_schedule'
umem.c: In function `mm_pci_probe':
umem.c:1178: warning: implicit declaration of function
`tasklet_init_Ra5808bbf'
umem.c: In function `mm_pci_remove':
umem.c:1313: warning: implicit declaration of function
`tasklet_kill_R79ad224b'
make[2]: *** [umem.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/block'

I deselected CONFIG_BLK_DEV_UMEM


gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=sdla_fr  -c -o sdla_fr.o sdla_fr.c
sdla_fr.c: In function `process_route':
sdla_fr.c:2819: warning: unknown conversion type character `U' in format
sdla_fr.c:2819: warning: too many arguments for format
sdla_fr.c: In function `process_ARP':
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4351: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
sdla_fr.c:4353: structure has no member named `ida_list'
make[3]: *** [sdla_fr.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net/wan'

I deselected CONFIG_WANPIPE_FR


ufs fails to build, I applied the patch that was posted earlier to
the list.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
