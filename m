Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJKLnN>; Thu, 11 Oct 2001 07:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276069AbRJKLnH>; Thu, 11 Oct 2001 07:43:07 -0400
Received: from [195.66.192.167] ([195.66.192.167]:18439 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S276097AbRJKLmx>; Thu, 11 Oct 2001 07:42:53 -0400
Date: Thu, 11 Oct 2001 14:41:58 +0200
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <15519828632.20011011144158@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <49983926.20011010164710@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <Pine.LNX.3.95.1011010084118.8134B-100000@chaos.analogic.com>
 <49983926.20011010164710@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what is going into bzImage:
#objdump -O binary -R .note -R .comment -S vmlinux vmlinux.binary

To see lengths of the symbols:
#objdump -R .note -R .comment vmlinux vmlinux.stripped
#nm vmlinux.stripped |
 grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' |
 sort >System.stripped.map
 (well, I see exactly this grep in the Makefile.
  If mail-mangled, look there to restore)
# ./gensize <System.stripped.map >System.stripped.size.map
# sort -r <System.stripped.size.map >System.stripped.sorted.map

gensize script (very silly) is at bottow of my email.
Top lines from my System.stripped.sorted.map follow.
I wonder: are all these have to be that big?
Anybody spots something unusual?

(size)   (ofs)    t (name)
00010000 c034d4a0 B mmu_gathers
00009380 c037c1e0 B blk_dev
000085c0 c035d4c0 B kstat
00007d83 c0292a00 T stext_lock
00007a7d c029a783 A _etext
00006b40 c02a9aa0 r devfsd_buf_size
00005e40 c02d27e0 R timer_bug_msg
000059b8 c02c89a8 R ahc_num_pci_devs
0000567f c02bdc01 r vendor
00005472 c02a3244 r Unused_offset
00004c00 c033a980 d pci_vendor_list
00004800 c0398960 B net_statistics
00004400 c038c9e0 B fb_display
00004000 c0367320 b log_buf
0000378a c02b640d r ide_hwif_to_major
00002f00 c02f14a0 d rs_table
00002da0 c02b2f40 r days_in_mo
0000247b c02d0365 r prio2band
00002400 c03715a0 b raw_devices
00002000 c03966c0 B icmp_statistics
00002000 c0343800 D init_tss
00002000 c0302000 D init_task_union
00001fe0 c038a060 B ide_hwifs
00001fe0 c0386980 b ro_bits
00001ed0 c01bf930 T vt_ioctl
00001d80 c0290c80 T rwsem_wake
00001d2c c02c5fe8 R num_critical_sections
00001ce5 c02ce680 R fb_con
00001c00 c0345800 D irq_desc
00001b14 c02c42c0 r RCSid
00001900 c0340200 D linux_logo
00001800 c0392fa0 B ip_statistics
000017e0 c02523e0 T tcp_sendmsg
000016c0 c02ba3e0 R sense_key_texts
000015e0 c0202350 T ahc_handle_seqint
000015b0 c02e28f0 A __start___ex_table
00001500 c034bf60 b irq_2_pin
00001400 c0347400 D cpu_data
00001376 c02a872a r start_ind_dev.7
00001320 c0209740 T ahc_init
00001040 c02c3280 r RCSid
00001000 c039d700 b swap_buffer
00001000 c0394900 B tcp_statistics
00001000 c0379d20 B con_buf
00001000 c0377ca0 b ptm_state
00001000 c0375320 b pty_state
00001000 c0365aa0 B pidhash
00001000 c02fc600 d fontdata_8x16
00001000 c02a2200 r tvecs
00001000 c0104000 T empty_zero_page
00001000 c0103000 T pg1
00001000 c0102000 T pg0
00001000 c0101000 T swapper_pg_dir
00000fd0 c0221380 t cdrom_ioctl
00000fb0 c01c5d50 t do_con_trol
00000f40 c01a8320 t ntfs_alloc_mft_record
00000f00 c0203930 T ahc_handle_scsiint
00000ee0 c024eb60 T ip_getsockopt
00000ea0 c02bbaa0 R sense_data_texts
00000ea0 c01e27e0 t ide_ioctl
00000e80 c0155d80 T path_walk
00000e60 c01ff940 t ahc_linux_queue_recovery_cmd
00000e60 c0176e60 t fat_readdirx
00000e40 c02b19c0 r twist_table.0
00000e20 c02f7fa0 d additional
00000dc0 c0321440 d script0
00000db0 c0254240 T tcp_recvmsg
00000da0 c02f99e0 d seqprog
00000d84 c010027c T gdt
00000d60 c0222500 t mmc_ioctl
00000d40 c02bca20 R scsi_device_types
00000d30 c01da1e0 t fd_ioctl
00000d20 c0255300 T tcp_close

gensize (don't laugh. I don't know sed/awk/perl/...)
-------
#!/bin/sh
prevline=""
prevofs=0xc0100000
read prevline
prevofs=0x`echo $prevline | cut -d " " -f 1 -`
read line
while test "$line"; do
    ofs=0x`echo $line | cut -d " " -f 1 -`
    diff=$(($ofs - $prevofs))
    printf "%08x $prevline\n" $diff
    prevofs=$ofs
    prevline=$line
    read line
done
printf "======== $prevline\n"
-- 
Best regards, vda
mailto:vda@port.imtp.ilyichevsk.odessa.ua


