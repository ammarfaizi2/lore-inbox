Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbRE3M7G>; Wed, 30 May 2001 08:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbRE3M64>; Wed, 30 May 2001 08:58:56 -0400
Received: from zeus.kernel.org ([209.10.41.242]:13500 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262773AbRE3M6q>;
	Wed, 30 May 2001 08:58:46 -0400
Date: Wed, 30 May 2001 14:27:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Thomas <stephen.thomas@insignia.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] Re: Reproducible oops when loading ns558.o in 2.4.5-ac4
Message-ID: <20010530142747.A279@suse.cz>
In-Reply-To: <3B141DCD.C2CE9BCD@insignia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B141DCD.C2CE9BCD@insignia.com>; from stephen.thomas@insignia.com on Tue, May 29, 2001 at 11:08:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Here is the fix.

Alan, please add this to the input update. Thanks.

Vojtech

On Tue, May 29, 2001 at 11:08:13PM +0100, Stephen Thomas wrote:

> May 29 22:40:52 wycliffe kernel: Unable to handle kernel paging request at virtual address 3d83537a 
> May 29 22:40:52 wycliffe kernel: c01a8d27 
> May 29 22:40:52 wycliffe kernel: *pde = 00000000 
> May 29 22:40:52 wycliffe kernel: Oops: 0000 
> May 29 22:40:52 wycliffe kernel: CPU:    0 
> May 29 22:40:52 wycliffe kernel: EIP:    0010:[isapnp_find_dev+59/256] 
> May 29 22:40:52 wycliffe kernel: EFLAGS: 00010213 
> May 29 22:40:52 wycliffe kernel: eax: 3d835356   ebx: cc8a36e4   ecx: 00000000   edx: cc8a348c 
> May 29 22:40:52 wycliffe kernel: esi: 00000002   edi: 00000002   ebp: 00000100   esp: cb12dedc 
> May 29 22:40:52 wycliffe kernel: ds: 0018   es: 0018   ss: 0018 
> May 29 22:40:52 wycliffe kernel: Process modprobe (pid: 662, stackpage=cb12d000) 
> May 29 22:40:52 wycliffe kernel: Stack: cc8a36e4 cc8a348c 00000001 cc8a382c cc8a3000 cc8a3824 000000ff 0002382c  
> May 29 22:40:52 wycliffe kernel:        cc8a34f5 00000000 00000002 00000100 cc8a348c cc8a3000 cc8a348c c0114b28  
> May 29 22:40:52 wycliffe kernel:        cb12c000 0804b52b 08061d70 bfffc45c 00000001 cc8a1000 cc8a1000 cc8a3818  
> May 29 22:40:52 wycliffe kernel: Call Trace: [<cc8a36e4>] [<cc8a348c>] [<cc8a382c>] [<cc8a3000>] [<cc8a3824>]  
> May 29 22:40:52 wycliffe kernel:    [<cc8a34f5>] [<cc8a348c>] [<cc8a3000>] [<cc8a348c>] [sys_init_module+1424/1588] [<cc8a1000>]  
> May 29 22:40:52 wycliffe kernel:    [<cc8a1000>] [<cc8a3818>] [<cc8a1000>] [<cc8a3060>] [system_call+51/56]  
> May 29 22:40:52 wycliffe kernel: Code: 66 39 78 24 75 0a 66 39 68 26 0f 84 ab 00 00 00 31 c9 8d 70  

-- 
Vojtech Pavlik
SuSE Labs

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ns558.oops.diff"

diff -urN linux-2.4.5-ac4/drivers/char/joystick/ns558.c linux/drivers/char/joystick/ns558.c
--- linux-2.4.5-ac4/drivers/char/joystick/ns558.c	Tue May 29 19:48:14 2001
+++ linux/drivers/char/joystick/ns558.c	Wed May 30 14:23:33 2001
@@ -239,7 +239,7 @@
 	int i = 0;
 #ifdef NSS558_ISAPNP
 	struct isapnp_device_id *devid;
-	struct pci_device *dev;
+	struct pci_dev *dev = NULL;
 #endif
 
 /*

--ibTvN161/egqYuK8--
