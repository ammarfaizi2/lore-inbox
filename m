Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAPQaa>; Tue, 16 Jan 2001 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130202AbRAPQaU>; Tue, 16 Jan 2001 11:30:20 -0500
Received: from saloma.stu.rpi.edu ([128.113.199.230]:28164 "EHLO incandescent")
	by vger.kernel.org with ESMTP id <S129868AbRAPQaD>;
	Tue, 16 Jan 2001 11:30:03 -0500
Date: Tue, 16 Jan 2001 11:29:25 -0500
To: zab@zabbo.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] maestro3 oops + fix (for ac9!)
Message-ID: <20010116112925.A1941@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux incandescent 2.4.1-pre7 
From: Andres Salomon <dilinger@mp3revolution.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The maestro3 driver in ac9 oopses, due to trying to deref an
unitialized pointer.  Here's the oops:

ksymoops 2.3.7 on i686 2.4.1-pre7.  Options used
     -v /boot/vmlinuz (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre7/ (default)
     -m /boot/System.map (specified)

Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is /boot/vmlinuz a valid vmlinux file?
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/drivers/sound/maestro3.o for module maestro3 has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/drivers/sound/soundcore.o for module soundcore has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/drivers/sound/ac97_codec.o for module ac97_codec has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/drivers/net/pcmcia/xirc2ps_cs.o for module xirc2ps_cs has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/fs/nls/nls_iso8859-1.o for module nls_iso8859-1 has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/fs/nls/nls_cp437.o for module nls_cp437 has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/fs/vfat/vfat.o f
or module vfat has changed since load
Warning (expand_objects): object /lib/modules/2.4.1-pre7/kernel/fs/fat/fat.o for
 module fat has changed since load
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c7036951
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c7036951>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000004b   ebx: 00000000   ecx: c5618000   edx: c023b648
esi: c5044000   edi: c5043e00   ebp: c5043f9c   esp: c4d53ec8
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 378, stackpage=c4d53000)
Stack: c7038b2c c5faa800 c7038ce0 00000000 c5043e00 c5043f28 c5043f54 00000000
       00000000 00000001 00bb1028 c01a3b2e c5faa800 c7038b2c c5faa800 c7038ce0
       00000000 00005ee0 c01a3b94 c7038ce0 c5faa800 c7033000 00000002 00000002
Call Trace: [<c7038b2c>] [<c7038ce0>] [<c01a3b2e>] [<c7038b2c>] [<c7038ce0>] [<c01a3b94>] [<c7038ce0>]
       [<c7033000>] [<c7036b4a>] [<c7038ce0>] [<c01157fd>] [<c7031000>] [<c7033060>] [<c0108d5f>]
Code: 89 7b 0c 57 e8 22 fc ff ff 57 e8 20 c9 ff ff 8b 44 24 28 50

>>EIP; c7036951 <[maestro3]m3_probe+3b1/498>   <=====
Trace; c7038b2c <[maestro3]m3_id_table+1c/70>
Trace; c7038ce0 <[maestro3]m3_pci_driver+0/1f>
Trace; c01a3b2e <pci_announce_device+36/54>
Trace; c7038b2c <[maestro3]m3_id_table+1c/70>
Trace; c7038ce0 <[maestro3]m3_pci_driver+0/1f>
Trace; c01a3b94 <pci_register_driver+48/60>
Trace; c7038ce0 <[maestro3]m3_pci_driver+0/1f>
Trace; c7033000 <[maestro3]__module_kernel_version+0/1a>
Trace; c7036b4a <[maestro3]m3_init_module+2a/64>
Trace; c7038ce0 <[maestro3]m3_pci_driver+0/1f>
Trace; c01157fd <sys_init_module+4f5/598>
Trace; c7031000 <[ac97_codec].data.end+11dd/123d>
Trace; c7033060 <[maestro3]ld2+0/20>
Trace; c0108d5f <system_call+33/38>
Code;  c7036951 <[maestro3]m3_probe+3b1/498>
00000000 <_EIP>:
Code;  c7036951 <[maestro3]m3_probe+3b1/498>   <=====
   0:   89 7b 0c                  mov    %edi,0xc(%ebx)   <=====
Code;  c7036954 <[maestro3]m3_probe+3b4/498>
   3:   57                        push   %edi
Code;  c7036955 <[maestro3]m3_probe+3b5/498>
   4:   e8 22 fc ff ff            call   fffffc2b <_EIP+0xfffffc2b> c703657c <[maestro3]m3_enable_ints+0/24>
Code;  c703695a <[maestro3]m3_probe+3ba/498>
   9:   57                        push   %edi
Code;  c703695b <[maestro3]m3_probe+3bb/498>
   a:   e8 20 c9 ff ff            call   ffffc92f <_EIP+0xffffc92f> c7033280 <[maestro3]m3_assp_continue+0/20>
Code;  c7036960 <[maestro3]m3_probe+3c0/498>
   f:   8b 44 24 28               mov    0x28(%esp,1),%eax
Code;  c7036964 <[maestro3]m3_probe+3c4/498>
  13:   50                        push   %eax


9 warnings and 1 error issued.  Results may not be reliable.


Looking at m3_probe:
static int __init m3_probe(struct pci_dev *pci_dev, const struct pci_device_id *
{
<snip>
    struct pm_dev *pmdev;
<snip>
    pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), m3_pm_callback);

    if( pmdev == NULL) {
        printk(KERN_WARNING PFX "couldn't register pm callback, suspend/resume m
ight not work.\n");
        /* XXX do error stuff :) */
    }

    pmdev->data = card;

    m3_enable_ints(card);
    m3_assp_continue(card);
<snip>
}


D'oh, looks like if power management is disabled, pmdev is NULL (I get
that message when I load the module), but we try to derefence it anyways.
The fix is obvious:

    pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), m3_pm_callback);

    if (pmdev)
        pmdev->data = card;
    else {
        printk(KERN_WARNING PFX "couldn't register pm callback, suspend/resume m
ight not work.\n");
        /* XXX do error stuff :) */
    }

    m3_enable_ints(card);
    m3_assp_continue(card);


Patch is also attached.

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maestro3.c.diff"

diff -urN linux.old/drivers/sound/maestro3.c linux/drivers/sound/maestro3.c
--- linux.old/drivers/sound/maestro3.c	Tue Jan 16 11:23:31 2001
+++ linux/drivers/sound/maestro3.c	Tue Jan 16 11:15:58 2001
@@ -2692,12 +2692,13 @@
 
     pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pci_dev), m3_pm_callback);
 
-    if ( pmdev == NULL) {
+    if (pmdev)
+        pmdev->data = card;
+    else {
         printk(KERN_WARNING PFX "couldn't register pm callback, suspend/resume might not work.\n");
         /* XXX do error stuff :) */
     }
 
-    pmdev->data = card;
 
     m3_enable_ints(card);
     m3_assp_continue(card);

--8t9RHnE3ZwKMSgU+--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
