Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288821AbSAQOXw>; Thu, 17 Jan 2002 09:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSAQOXq>; Thu, 17 Jan 2002 09:23:46 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:5577 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S288810AbSAQOWL>; Thu, 17 Jan 2002 09:22:11 -0500
Date: Thu, 17 Jan 2002 14:22:09 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: linux-kernel@vger.kernel.org
Subject: probably very irrelevant oops
Message-ID: <Pine.LNX.4.44.0201171404410.7764-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I built a fairly pathological kernel based on 2.4.17 with sched-O1-H7,
ext3-0.9.17, XFS, jfs-1.0.12 and Intel's e100. (Things are orthogonal
enough that they patch together easily :)

It boots fine (but not with devfs) and I can use all four journaled
filesystems together happily. So I thought I'd try two very stupid stress
tests.

find /lib/modules/2.4.17-expt/kernel/ -type f|while read i; do insmod $i; done

[Great. A few hundred modules load, no doubt some clashing with others.
However, lsmod seems to suggest we've overrun a buffer as the output
looks truncated (my find produced 597 lines, but lsmod only 300 or so)]

awk '{print $1}' /proc/modules|while read i; do rmmod $i; done

[BOOM. But I was asking for it.. the first three warnings are the modules
in my initrd]

ksymoops 2.4.1 on i686 2.4.17-expt.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-expt/ (default)
     -m /boot/System.map-2.4.17-expt (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (expand_objects): object /lib/modules/2.4.17-expt/kernel/fs/reiserfs/reiserfs.o for module reiserfs has changed since load
Warning (expand_objects): object /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
Warning (expand_objects): object /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
Warning (compare_ksyms_lsmod): module ip_conntrack is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module nls_cp9 is in lsmod but not in ksyms, probably no symbols exported
Error (compare_ksyms_lsmod): module nls_cp950 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nls_big5 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nls_cp1255 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nls_cp1251 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module hfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module fat is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module efs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module bfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module e100 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module xfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module xfs_dmapi is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module xfs_support is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module pagebuf is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nfsd is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module lockd is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module sunrpc is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module ext3 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module jbd is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module nls_iso8859-1 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module aic7xxx is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module sd_mod is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module scsi_mod is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module jfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module autofs4 is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module af_packet is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module mousedev is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module hid is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module usbmouse is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module input is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module usb-uhci is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module usbcore is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module unix is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module reiserfs is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module ide-disk is in ksyms but not in lsmod
Error (compare_ksyms_lsmod): module ide-mod is in ksyms but not in lsmod
Warning (compare_maps): mismatch on symbol irlan_state  , irlan says d0ee5900, /lib/modules/2.4.17-expt/kernel/net/irda/irlan.o says d0ee58b8.  Ignoring /lib/modules/2.4.17-expt/kernel/net/irda/irlan.o entry
Warning (compare_maps): mismatch on symbol proc_irda  , irda says d0ed6084, /lib/modules/2.4.17-expt/kernel/net/irda/irda.o says d0ed56c4.  Ignoring /lib/modules/2.4.17-expt/kernel/net/irda/irda.o entry
Warning (compare_maps): mismatch on symbol icmpv6_socket  , ipv6 says d0ebeb40, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc7e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol icmpv6_statistics  , ipv6 says d0ebea40, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc6e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_dev_count  , ipv6 says d0ebe5a0, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc240.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_ifa_count  , ipv6 says d0ebe5a4, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc244.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inet6_protos  , ipv6 says d0ebe9c0, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc660.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol inetsw6  , ipv6 says d0ebe540, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc1e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ip6_ra_chain  , ipv6 says d0ebe840, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc4e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol ipv6_statistics  , ipv6 says d0ebe740, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc3e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol raw_v6_htable  , ipv6 says d0ebe940, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc5e0.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol rt6_stats  , ipv6 says d0ebe708, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc3a8.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol udp_stats_in6  , ipv6 says d0ebe8c0, /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o says d0ebc560.  Ignoring /lib/modules/2.4.17-expt/kernel/net/ipv6/ipv6.o entry
Warning (compare_maps): mismatch on symbol vxfs_inode_cachep  , freevxfs says d0e2733c, /lib/modules/2.4.17-expt/kernel/fs/freevxfs/freevxfs.o says d0e26ee0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/freevxfs/freevxfs.o entry
Warning (compare_maps): mismatch on symbol cii_cache  , coda says d0dab608, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa7a8.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_cache_inv_stat  , coda says d0dab7c8, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa968.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_callstats  , coda says d0dab6e0, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa880.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_comms  , coda says d0dab540, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa6e0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_debug  , coda says d0dab6bc, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa85c.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_fake_statfs  , coda says d0dab6c4, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa864.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_hard  , coda says d0dab520, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa6c0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_hasmknod  , coda says d0dab620, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa7c0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_permission_stat  , coda says d0dab7c0, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa960.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_print_entry  , coda says d0dab6c0, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa860.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_upcall_stat  , coda says d0dab800, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa9a0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol coda_vfs_stat  , coda says d0dab780, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa920.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol cred_cache  , coda says d0dab60c, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa7ac.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol proc_fs_coda  , coda says d0dab9bc, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daab5c.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol upc_cache  , coda says d0dab610, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa7b0.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol use_coda_close  , coda says d0dab624, /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o says d0daa7c4.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/coda/coda.o entry
Warning (compare_maps): mismatch on symbol presto_sym_fops  , intermezzo says d0d8f920, /lib/modules/2.4.17-expt/kernel/fs/intermezzo/intermezzo.o says d0d8de20.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/intermezzo/intermezzo.o entry
Warning (compare_maps): mismatch on symbol proc_fs_intermezzo  , intermezzo says d0d8f900, /lib/modules/2.4.17-expt/kernel/fs/intermezzo/intermezzo.o says d0d8de00.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/intermezzo/intermezzo.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d0bb39f0, /lib/modules/2.4.17-expt/kernel/fs/lockd/lockd.o says d0bb2e58.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d0ba6a44, /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o says d0ba6724.  Ignoring /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d0ba6a48, /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o says d0ba6728.  Ignoring /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d0ba6a4c, /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o says d0ba672c.  Ignoring /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d0ba6a40, /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o says d0ba6720.  Ignoring /lib/modules/2.4.17-expt/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol journal_enable_debug  , jbd says d0ae129c, /lib/modules/2.4.17-expt/kernel/fs/jbd/jbd.o says d0ae1288.  Ignoring /lib/modules/2.4.17-expt/kernel/fs/jbd/jbd.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_detect_complete  , aic7xxx says d0ad41a4, /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o says d0ad1a64.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_no_probe  , aic7xxx says d0ad41a0, /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o says d0ad1a60.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_periodic_otag  , aic7xxx says d0ad41b0, /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o says d0ad1a70.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol aic7xxx_verbose  , aic7xxx says d0ad41a8, /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o says d0ad1a68.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/aic7xxx/aic7xxx.o entry
Warning (compare_maps): mismatch on symbol sd  , sd_mod says d0a14aec, /lib/modules/2.4.17-expt/kernel/drivers/scsi/sd_mod.o says d0a14980.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d0ab3b68, /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o says d0ab2310.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d0ab3b94, /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o says d0ab233c.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d0ab3b90, /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o says d0ab2338.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d0ab3b98, /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o says d0ab2340.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d0ab3b64, /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o says d0ab230c.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says d09f6fe8, /lib/modules/2.4.17-expt/kernel/net/packet/af_packet.o says d09f6de4.  Ignoring /lib/modules/2.4.17-expt/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d091f2f4, /lib/modules/2.4.17-expt/kernel/drivers/usb/usbcore.o says d091edb4.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says d08f2520, /lib/modules/2.4.17-expt/kernel/net/unix/unix.o says d08f2140.  Ignoring /lib/modules/2.4.17-expt/kernel/net/unix/unix.o entry
Warning (compare_maps): mismatch on symbol ide_devfs_handle  , ide-mod says d0812e00, /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o says d0811fec.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol ide_hwifs  , ide-mod says d0810f60, /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o says d081014c.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o entry
Warning (compare_maps): mismatch on symbol ide_probe  , ide-mod says d0810f40, /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o says d081012c.  Ignoring /lib/modules/2.4.17-expt/kernel/drivers/ide/ide-mod.o entry
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address d11cd2a0
c017184d
*pde = 0563e067
Oops: 0002
CPU:    0
EIP:    0010:[<c017184d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
eax: d11cd2a0   ebx: d1191000   ecx: 00000000   edx: cf005f64
esi: d1197540   edi: 00000000   ebp: 00000003   esp: c3b27f04
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 5881, stackpage=c3b27000)
Stack: d1191000 00000003 00000003 d11968ca d1197540 00000000 d1191000 00000003
       00000003 d1191000 c0115945 d119763c c0ff4000 00006580 c05da000 00000060
       ffffffea 00000006 cb8e1214 00000060 d118d000 d1191060 00006680 00000000
Call Trace: [<d11968ca>] [<d1197540>] [<c0115945>] [<d119763c>] [<d1191060>]
   [<c0106ebb>]
Code: 89 30 8b 1d 28 6a 1e c0 81 fb 28 6a 1e c0 74 23 8d 76 00 53

>>EIP; c017184d <pci_register_driver+1d/60>   <=====
Trace; d11968ca <[es1371]init_es1371+2a/50>
Trace; d1197540 <[es1371]es1371_driver+0/3f>
Trace; c0115945 <sys_init_module+525/5e0>
Trace; d119763c <[es1371].data.end+bd/dae1>
Trace; d1191060 <[es1371]wait_src_ready+0/3c>
Trace; c0106ebb <system_call+33/38>
Code;  c017184d <pci_register_driver+1d/60>
00000000 <_EIP>:
Code;  c017184d <pci_register_driver+1d/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c017184f <pci_register_driver+1f/60>
   2:   8b 1d 28 6a 1e c0         mov    0xc01e6a28,%ebx
Code;  c0171855 <pci_register_driver+25/60>
   8:   81 fb 28 6a 1e c0         cmp    $0xc01e6a28,%ebx
Code;  c017185b <pci_register_driver+2b/60>
   e:   74 23                     je     33 <_EIP+0x33> c0171880 <pci_register_driver+50/60>
Code;  c017185d <pci_register_driver+2d/60>
  10:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0171860 <pci_register_driver+30/60>
  13:   53                        push   %ebx


60 warnings and 36 errors issued.  Results may not be reliable.


