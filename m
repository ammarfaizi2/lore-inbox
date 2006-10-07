Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWJGR11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWJGR11 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWJGR10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 13:27:26 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:56783
	"EHLO saville.com") by vger.kernel.org with ESMTP id S932360AbWJGR10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 13:27:26 -0400
Message-ID: <4527E384.3010607@saville.com>
Date: Sat, 07 Oct 2006 10:27:32 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Debugging startup/frame buffer problem in 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm proceeding to debug the frame buffer problem I mentioned here, http://lkml.org/lkml/2006/10/5/22, I've added printk's and modified *_console_sem (see <Console output> & <Modifications> below) but I end up blind as debug output eventually stops. I then changed my kernel command line so it outputs to two consoles:

/boot/vmlinuz root=/dev/sda2 ro splash initcall_debug console=tty0 console=ttyS0,115200n8 loglevel=7

Still no output after trying to acquire the console sem. Anyway at this point it looks like I need to debug at a lower level. I was thinking of writing directly to the serial port or maybe there is a better choice?

Thanks,

Wink Saville


<Console output>

[   40.267852] Calling initcall 0xffffffff8074eedc: fb_console_init+0x0/0x12c()
[   40.275097] acquire_console_sem: drivers/video/console/fbcon.c:fb_console_init:3266
[   40.282956] acquire_console_sem: GOT IT FOR drivers/video/console/fbcon.c:fb_console_init:3266
[   40.282958] fb_register_client E
[   40.282960] notifier_chain_register: E nl=ffffffff8069c9f8 n=ffffffff8069d070
[   40.282962] notifier_chain_register: X nl=ffffffff8069c9f8 n=ffffffff8069d070
[   40.282963] fb_register_client X
[   40.282985] release_console_sem: drivers/video/console/fbcon.c:fb_console_init:3282
[   40.320818] Calling initcall 0xffffffff8043ed31: nvidiafb_init+0x0/0x258()
[   40.327889] nvidiafb_setup START
[   40.331251] nvidiafb_probe START
[   40.334604] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[   40.342354] nvidiafb: Device ID: 10de0391
[   40.359248] nvidiafb: CRTC0 analog found
[   40.379285] nvidiafb: CRTC1 analog not found
[   40.383684] nvidiafb: CRTC 0 appears to have a CRT attached
[   40.389362] nvidiafb: Using CRT on CRTC 0
[   40.393550] nvidia_set_fbinfo START
[   40.397153] nvidia_set_fbinfo END
[   40.400585] nvidiafb_check_var START
[   40.404278] nvidiafb_check_var END
[   40.407796] nvidia_save_vga START
[   40.411308] nvidia_save_vga END
[   40.414568] register_framebuffer: ENTER
[   40.418520] register_framebuffer: num_registered_fb=1
[   40.423710] register_framebuffer: call fb_var_to_videomode
[   40.429306] register_framebuffer: call fb_add_videomode
[   40.434640] register_framebuffer: call fb_notifier_call_chain
[   40.440495] fb_notifier_call_chain E
[   40.444187] notifier_call_chain: E nl=ffffffff8069c9f8 val=0x5 v=ffff81007ff1fcd0
[   40.451872] notifier_call_chain: notifier_call nb=ffffffff8069d070 val=0x5 v=ffff81007ff1fcd0
[   40.460598] fbcon_event_notify: E notifier_block=ffffffff8069d070 action=0x5 data=ffff81007ff1fcd0
[   40.469756] fbcon_fb_registerd: -1 E idx=0
[   40.473968] fbcon_fb_registerd: toploop i=0
[   40.478307] fbcon_fb_registerd: info_idx = idx = 0 break
[   40.482291] notifier_call_chain: E nl=ffffffff80671d48 val=0xc v=ffff81007ff58ef8
[   40.482293] notifier_call_chain: notifier_call nb=ffffffff8067b590 val=0xc v=ffff81007ff58ef8
[   40.482296] notifier_call_chain: notifier_call ret=0x0 nb=ffffffff8067b590 val=0xc v=ffff81007ff58ef8
[   40.482298] notifier_call_chain: X ret=0x0 nl=ffffffff80671d48 val=0xc v=ffff81007ff58ef8
[   40.482300] notifier_call_chain: E nl=ffffffff80671d48 val=0x5 v=ffff81007ff58eb8
[   40.482302] notifier_call_chain: notifier_call nb=ffffffff8067b590 val=0x5 v=ffff81007ff58eb8
[   40.482305] notifier_call_chain: notifier_call ret=0x0 nb=ffffffff8067b590 val=0x5 v=ffff81007ff58eb8
[   40.482307] notifier_call_chain: X ret=0x0 nl=ffffffff80671d48 val=0x5 v=ffff81007ff58eb8
[   40.552088] fbcon_fb_registerd: info_idx=0 call fbcon_takeover(1)
[   40.558286] fbcon_takeover: E show_logo=1
[   40.562407] fbcon_takeover: call take_over_console show_logo=1
[   40.568350] take_over_console: E csw=ffffffff805d8600 first=0, last=62, deflt=1
[   40.575859] register_con_driver: acquire_console_sem
[   40.580933] acquire_console_sem: drivers/char/vt.c:register_con_driver:3156
[   40.588000] acquire_console_sem: GOT IT FOR drivers/char/vt.c:register_con_driver:3156
[   40.588001] register_con_driver: acquire_console_sem GOT IT
[   40.588484] notifier_call_chain: E nl=ffffffff80671d38 val=0x1 v=0000000000000000
[   40.588486] notifier_call_chain: X ret=0x0 nl=ffffffff80671d38 val=0x1 v=0000000000000000
[   40.588491] notifier_call_chain: E nl=ffffffff80677118 val=0x0 v=ffff81007f65a810
[   40.588493] notifier_call_chain: X ret=0x0 nl=ffffffff80677118 val=0x0 v=ffff81007f65a810
[   40.588499] notifier_call_chain: E nl=ffffffff80671d38 val=0x2 v=0000000000000000
[   40.588501] notifier_call_chain: X ret=0x0 nl=ffffffff80671d38 val=0x2 v=0000000000000000
[   40.588503] notifier_call_chain: E nl=ffffffff80671d38 val=0x1 v=0000000000000000
[   40.588506] notifier_call_chain: X ret=0x0 nl=ffffffff80671d38 val=0x1 v=0000000000000000
[   40.588507] register_con_driver: release_console_sem
[   40.588509] release_console_sem: drivers/char/vt.c:register_con_driver:3211
[   40.590594] notifier_call_chain: E nl=ffffffff80671d38 val=0x2 v=0000000000000000
[   40.590596] notifier_call_chain: X ret=0x0 nl=ffffffff80671d38 val=0x2 v=0000000000000000
[   40.678628] notifier_call_chain: E nl=ffffffff80677128 val=0x0 v=ffff81007f65b0c0
[   40.678631] notifier_call_chain: X ret=0x0 nl=ffffffff80677128 val=0x0 v=ffff81007f65b0c0
[   40.710263] take_over_console: call bind_con_driver csw=ffffffff805d8600 first=0, last=62, deflt=1
[   40.719419] bind_con_driver: E
[   40.722586] bind_con_driver: acquire_console_sem
[   40.727319] acquire_console_sem: drivers/char/vt.c:bind_con_driver:2742
</Console output>

<Modifications>

drivers/char/vt.c:
2727 static int bind_con_driver(const struct consw *csw, int first, int last,
2728                            int deflt)
2729 {
2730         struct module *owner = csw->owner;
2731         const char *desc = NULL;
2732         struct con_driver *con_driver;
2733         int i, j = -1, k = -1, retval = -ENODEV;
2734
2735         printk("bind_con_driver: E\n");
2736         if (!try_module_get(owner)) {
2737                 printk("bin_con_driver: err try_module_get\n");
2738                 return -ENODEV;
2739         }
2740
2741         printk("bind_con_driver: acquire_console_sem\n");
2742         acquire_console_sem();
2743         printk("bind_con_driver: acquire_console_sem GOT IT\n");

kernel/printk.c:
 752 void acquire_console_sem_real(void)
 753 {
 754         BUG_ON(in_interrupt());
 755         if (console_suspended) {
 756                 down(&secondary_console_sem);
 757                 return;
 758         }
 759         down(&console_sem);
 760         console_locked = 1;
 761         console_may_schedule = 1;
 762 }
 763 EXPORT_SYMBOL(acquire_console_sem_real);
 764
 765 void acquire_console_sem_dbg(const char *file, const char *function, int line)
 766 {
 767         printk("acquire_console_sem: %s:%s:%d\n", file, function, line);
 768         acquire_console_sem_real();
 769         printk("acquire_console_sem: GOT IT FOR %s:%s:%d\n", file, function, line);
 770 }
 771 EXPORT_SYMBOL(acquire_console_sem_dbg);
 772

include/linux/console.h:
125 #define acquire_console_sem() acquire_console_sem_dbg(__FILE__, __FUNCTION__, __LINE__)
126 #define try_acquire_console_sem() try_acquire_console_sem_dbg(__FILE__, __FUNCTION__, __LINE__)
127 #define release_console_sem() release_console_sem_dbg(__FILE__, __FUNCTION__, __LINE__)

</Modifications>
