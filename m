Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbUKXNHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUKXNHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbUKXNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:06:42 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:31124 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262638AbUKXNAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:45 -0500
Subject: Suspend 2 merge: 4/51: Get module list.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101293104.5805.203.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This provides access to the list of loaded modules for suspend's
debugging output. When a cycle finishes, suspend outputs something the
following:

> Please include the following information in bug reports:
> - SUSPEND core   : 2.1.5.7
> - Kernel Version : 2.6.9
> - Compiler vers. : 3.3
> - Modules loaded : tuner bttv videodev snd_seq_oss snd_seq_midi_event
> snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm
> snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device
> snd soundcore visor usbserial usblp joydev evdev usbmouse usbhid
> uhci_hcd usbcore ppp_deflate zlib_deflate zlib_inflate bsd_comp
> ipt_LOG ipt_state ipt_MASQUERADE iptable_nat ip_conntrack
> ipt_multiport ipt_REJECT iptable_filter ip_tables ppp_async
> ppp_generic slhc crc_ccitt video_buf v4l2_common btcx_risc Win4Lin
> mki_adapter radeon agpgart parport_pc lp parport sg ide_cd sr_mod
> cdrom floppy af_packet e1000 loop dm_mod tsdev suspend_bootsplash
> suspend_text suspend_swap suspend_block_io suspend_lzf suspend_core
> - Attempt number : 9
> - Parameters     : 0 2304 32768 1 0 4096 5
> - Limits         : 261680 pages RAM. Initial boot: 252677.
> - Overall expected compression percentage: 0.
> - LZF Compressor enabled.
>   Compressed 922112000 bytes into 437892038 (52 percent compression).
> - Swapwriter active.
>   Swap available for image: 294868 pages.
> - Debugging compiled in.
> - Preemptive kernel.
> - SMP kernel.
> - Highmem Support.
> - I/O speed: Write 72 MB/s, Read 119 MB/s.

Including the modules loaded is very helpful for debugging problems.


diff -ruN 209-get-module-list-old/kernel/module.c 209-get-module-list-new/kernel/module.c
--- 209-get-module-list-old/kernel/module.c	2004-11-24 17:21:28.892423312 +1100
+++ 209-get-module-list-new/kernel/module.c	2004-11-24 17:21:20.619680960 +1100
@@ -2105,6 +2105,18 @@
 }
 EXPORT_SYMBOL(module_remove_driver);
 
+int print_module_list_to_buffer(char * buffer, int size)
+{
+	struct module *mod;
+	int pos = 0;
+
+	list_for_each_entry(mod, &modules, list)
+		if (mod->name)
+			pos += snprintf(buffer+pos, size-pos-1, 
+					"%s ", mod->name);
+	return pos;
+}
+
 #ifdef CONFIG_MODVERSIONS
 /* Generate the signature for struct module here, too, for modversions. */
 void struct_module(struct module *mod) { return; }
@@ -2115,3 +2127,5 @@
 struct list_head *kdb_modules = &modules;	/* kdb needs the list of modules */
 #endif	/* CONFIG_KDB */
 
+/* For Suspend2 */
+EXPORT_SYMBOL(print_module_list_to_buffer);


