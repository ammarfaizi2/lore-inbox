Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSJNOaK>; Mon, 14 Oct 2002 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJNOaK>; Mon, 14 Oct 2002 10:30:10 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:10892 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261664AbSJNO3l>;
	Mon, 14 Oct 2002 10:29:41 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: cdrom_sysctl_register uses LOTS of CPU, and no cdrom is attached (2.4.20-pre10)
Date: Mon, 14 Oct 2002 16:39:08 +0200
User-Agent: KMail/1.4.1
Cc: Harald Dankworth <harald@pronto.tv>,
       Atle =?iso-8859-1?q?Sj=F8n=F8st?= <atle@pronto.tv>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ"
Message-Id: <200210141639.08832.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi

I have these server nodes, doing video streaming.
and
running a server benchmark with 20 concurrent client connections. hardwar=
e is=20
4 IDE drives. kernel is 2.4.20-pre10 + ext3 O_DIRECT support. filesystem =
is=20
ext3.

The only system call that seems to eat any system time of importance is=20
'cdrom_sysctl_register'

problem is: there is no cdrom on the system!

attached is the .config and these three readprofile output files (pro[123=
]).=20
see time to see the interval they have been created in

bash-2.05# ls -l pro[1-3]
-rw-r--r--    1 root     root        13965 Jan 29 00:05 pro1
-rw-r--r--    1 root     root        14193 Jan 29 00:06 pro2
-rw-r--r--    1 root     root        15162 Jan 29 00:09 pro3

roy

--=20
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ
Content-Type: text/plain;
  charset="us-ascii";
  name="pro1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pro1"

     4 _stext                                     0.0833
    27 huft_build                                 0.0147
    76 inflate_codes                              0.0731
     1 inflate_dynamic                            0.0006
     7 gunzip                                     0.0055
    36 dump_thread                                0.1250
     7 __switch_to                                0.0337
   138 alignment_check                           11.5000
     1 page_fault                                 0.0833
     1 machine_check                              0.0833
     1 spurious_interrupt_bug                     0.0833
     3 show_trace                                 0.0125
   936 save_v86_state                             1.9500
    64 sys_ipc                                    0.1176
    30 do_open                                    0.1442
     6 free_initrd_mem                            0.0469
   170 do_page_fault                              0.1382
    12 remap_area_pages                           0.0268
    28 sys_sched_getparam                         0.1094
     1 sys_sched_get_priority_min                 0.0208
     7 sys_sched_rr_get_interval                  0.0230
    54 show_task                                  0.1467
    12 render_sigset_t                            0.0938
    45 reparent_to_init                           0.1480
    10 daemonize                                  0.0893
     1 wake_up_process                            0.0133
    13 request_dma                                0.2031
   121 lookup_exec_domain                         0.7562
    98 register_exec_domain                       1.2250
     3 do_syslog                                  0.0038
     1 emit_log_char                              0.0089
     1 printk                                     0.0035
     1 console_unblank                            0.0156
     1 sys_create_module                          0.0025
     1 qm_modules                                 0.0033
     1 sys_query_module                           0.0028
     1 exit_notify                                0.0016
     1 sys_sysinfo                                0.0031
    21 sys_settimeofday                           0.1010
   296 tasklet_hi_action                          2.6429
     1 tasklet_init                               0.0208
     2 __run_task_queue                           0.0208
     2 ksoftirqd                                  0.0114
     3 cpu_raise_softirq                          0.0517
     1 __request_resource                         0.0125
     1 release_resource                           0.0625
     1 check_resource                             0.0125
     1 update_wall_time_one_tick                  0.0057
     1 update_wall_time                           0.0156
    93 timer_bh                                   0.1076
    29 do_timer                                   0.2589
    55 sys_alarm                                  0.6875
     4 sys_geteuid                                0.1250
     3 sys_getgid                                 0.0938
     4 collect_signal                             0.0179
    30 bad_signal                                 0.2083
     5 send_signal                                0.0195
     2 deliver_signal                             0.0208
     2 send_sig_info                              0.0125
     1 force_sig_info                             0.0069
     1 kill_pg_info                               0.0089
     2 wake_up_parent                             0.0312
    17 sys_rt_sigaction                           0.0531
    28 sys_ssetmask                               0.3500
    10 kill_proc_info                             0.0694
     2 exec_usermodehelper                        0.0022
     1 call_usermodehelper                        0.0048
     2 vmtruncate_list                            0.0208
     9 vmtruncate                                 0.0312
     1 do_anonymous_page                          0.0045
    16 handle_mm_fault                            0.0833
     1 vmalloc_to_page                            0.0132
     1 unlock_vma_mappings                        0.0625
     1 get_unmapped_area                          0.0037
     5 find_vma                                   0.0521
    10 find_vma_prev                              0.0521
   488 find_extend_vma                            2.7727
    69 unmap_fixup                                0.2270
    15 do_brk                                     0.0312
     4 exit_mmap                                  0.0139
     1 insert_vm_struct                           0.0079
     9 .text.lock.mmap                            0.1385
     1 add_page_to_hash_queue                     0.0208
     1 __remove_inode_page                        0.0125
     1 invalidate_inode_pages                     0.0069
     1 truncate_list_pages                        0.0024
     1 invalidate_list_pages2                     0.0031
     1 generic_buffer_fdatasync                   0.0052
     1 __find_lock_page_helper                    0.0089
     5 find_or_create_page                        0.0240
     1 do_generic_file_read                       0.0010
     1 generic_file_direct_IO                     0.0021
     6 do_readahead                               0.0417
    14 madvise_willneed                           0.0461
     3 read_cache_page                            0.0099
    49 generic_file_write                         0.0300
  1056 change_protection                          3.0000
     5 mprotect_fixup                             0.0049
     3 kmem_cache_create                          0.0037
     1 remove_exclusive_swap_page                 0.0048
    54 try_to_unuse                               0.0823
   145 sys_swapoff                                0.2665
     7 get_swaphandle_info                        0.0365
    22 valid_swaphandles                          0.1630
     2 Letext                                     0.2222
     1 int_sqrt                                   0.0156
    16 badness                                    0.0833
    25 shmem_file_write                           0.0340
     4 do_shmem_file_read                         0.0167
    43 shmem_statfs                               0.5375
     2 shmem_mknod                                0.0179
    43 shmem_rename                               0.3359
     4 shmem_symlink                              0.0083
    14 shmem_follow_link                          0.1250
    32 shmem_parse_options                        0.0588
     3 sys_truncate64                             0.0078
     1 remove_super                               0.0069
     1 sys_ustat                                  0.0042
     1 get_anon_super                             0.0045
    14 kill_super                                 0.0625
     3 .text.lock.super                           0.0129
    85 do_open                                    0.2530
   247 blkdev_put                                 1.2865
     2 sys_stat64                                 0.0179
     1 sys_fstat64                                0.0093
     2 copy_strings                               0.0046
     1 exec_mmap                                  0.0035
     2 flush_old_exec                             0.0033
     1 compute_creds                              0.0030
     1 pipe_read                                  0.0018
     1 sys_poll                                   0.0014
     1 flock64_to_posix_lock                      0.0035
     7 locks_insert_lock                          0.1094
    12 locks_delete_lock                          0.0536
     4 posix_lock_file                            0.0034
     1 locks_remove_posix                         0.0030
     1 lock_get_status                            0.0022
     1 Letext                                     0.0030
     1 free_kiobuf_bhs                            0.0125
     1 expand_kiobuf                              0.0057
    56 show_vfsmnt                                0.0625
     6 umount_tree                                0.0312
    34 do_umount                                  0.1328
    11 sys_umount                                 0.0625
     1 sys_oldumount                              0.0312
     9 copy_tree                                  0.0469
     1 graft_tree                                 0.0039
     8 do_loopback                                0.0227
     6 do_remount                                 0.0375
     4 do_move_mount                              0.0076
     1 bm_entry_read                              0.0039
     5 load_elf_binary                            0.0017
     2 proc_root_link                             0.0208
     1 proc_pid_environ                           0.0125
     1 mem_read                                   0.0030
     1 do_proc_readlink                           0.0045
     2 ext3_free_data                             0.0060
     1 ext3_do_update_inode                       0.0011
     1 ext3_setattr                               0.0024
     2 ext3_change_inode_journal_flag             0.0066
     4 ext3_find_entry                            0.0057
     2 ext3_create                                0.0069
     3 ext3_mkdir                                 0.0037
     3 empty_dir                                  0.0063
   188 ext3_orphan_add                            0.3790
     2 count_tags                                 0.0250
     1 ext2_read_super                            0.0006
     1 zlib_fs_inflate_codes                      0.0005
     1 parse_rock_ridge_inode_internal            0.0006
  1872 autoconfig                                 1.8571
     1 pci_siig10x_fn                             0.0089
     2 pci_siig20x_fn                             0.0179
     2 serial_remove_one                          0.0125
    47 register_serial                            0.0773
    25 setledstate                                0.3125
    12 register_leds                              0.1500
    10 kbd_bh                                     0.0541
    12 Letext                                     0.1875
     6 pckbd_translate                            0.0208
     1 interpret_errors                           0.0016
     1 user_reset_fdc                             0.0078
     1 raw_cmd_ioctl                              0.0010
    37 fd_ioctl                                   0.0126
    23 compute_loop_size                          0.1797
     9 do_nbd_request                             0.0352
     7 nbd_ioctl                                  0.0072
    22 eepro100_init_one                          0.0417
    73 speedo_found1                              0.0415
    15 do_eeprom_cmd                              0.0721
     1 ide_scan_devices                           0.0052
     1 ide_dmafunc_verbose                        0.0063
     1 pdc202xx_tune_chipset                      0.0012
     2 pdc202xx_new_tune_chipset                  0.0020
     1 piix_get_info                              0.0009
     1 piix_tune_drive                            0.0023
    18 cdrom_sysctl_handler                       0.0750
 45678 cdrom_sysctl_register                    407.8393
     8 pci_find_subsys                            0.0625
     2 pci_find_class                             0.0417
     6 call_policy                                0.0134
     1 usb_start_wait_urb                         0.0026
     4 usb_get_device_descriptor                  0.1250
    45 usb_get_status                             0.5625
    17 usb_get_protocol                           0.2125
     1 usb_open                                   0.0042
     1 usb_hub_configure                          0.0016
     1 usb_hcd_pci_resume                         0.0063
    58 hcd_submit_urb                             0.0755
     1 periodic_unlink                            0.0048
    63 td_submit_urb                              0.0743
    16 dl_transfer_length                         0.0714
     4 dl_del_urb                                 0.0417
     1 raid5_end_write_request                    0.0026
    18 xor_pII_mmx_5                              0.0341
     6 get_spare                                  0.0417
     1 md_sync_acct                               0.0089
     1 md_do_sync                                 0.0009
    13 unregister_netdevice                       0.0271
     1 __dev_mc_upload                            0.0208
    22 ip_frag_reasm                              0.0335
    26 ip_defrag                                  0.0929
    17 ip_forward                                 0.0374
   447 ip_options_compile                         0.2972
     2 ip_options_undo                            0.0114
    19 ip_options_get                             0.0699
    18 ip_forward_options                         0.0469
    43 ip_options_rcv_srr                         0.1348
     8 ip_queue_xmit                              0.0068
     1 ip_setsockopt                              0.0004
     5 inet_fill_ifaddr                           0.0087
     1 devinet_sysctl_register                    0.0030
    16 inet_sock_release                          0.1250
     6 inet_create                                0.0107
     1 fib_create_info                            0.0012
     1 tux_error_report                           0.0037
     1 tux_state_change                           0.0015
     1 tux_ftp_create_child                       0.0027
    13 parse_http_message                         0.0006
     1 zap_userspace_req                          0.0104
     1 gen_bitlen                                 0.0020
     1 send_all_trees                             0.0015
     3 _tr_tally                                  0.0104
     1 compress_block                             0.0009
     6 set_data_type                              0.0469
 54301 total                                      0.0343

--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ
Content-Type: text/plain;
  charset="us-ascii";
  name="pro2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pro2"

     4 _stext                                     0.0833
    27 huft_build                                 0.0147
    76 inflate_codes                              0.0731
     1 inflate_dynamic                            0.0006
     9 gunzip                                     0.0071
    38 dump_thread                                0.1319
     7 __switch_to                                0.0337
   142 alignment_check                           11.8333
     1 page_fault                                 0.0833
     1 machine_check                              0.0833
     1 spurious_interrupt_bug                     0.0833
     4 show_trace                                 0.0167
     1 show_stack                                 0.0078
  1051 save_v86_state                             2.1896
    75 sys_ipc                                    0.1379
    36 do_open                                    0.1731
     6 free_initrd_mem                            0.0469
   205 do_page_fault                              0.1667
    12 remap_area_pages                           0.0268
    28 sys_sched_getparam                         0.1094
     1 sys_sched_get_priority_min                 0.0208
     7 sys_sched_rr_get_interval                  0.0230
    58 show_task                                  0.1576
    13 render_sigset_t                            0.1016
    45 reparent_to_init                           0.1480
    12 daemonize                                  0.1071
     1 wake_up_process                            0.0133
    16 request_dma                                0.2500
   129 lookup_exec_domain                         0.8063
   109 register_exec_domain                       1.3625
     3 do_syslog                                  0.0038
     1 emit_log_char                              0.0089
     1 printk                                     0.0035
     1 console_unblank                            0.0156
     1 sys_create_module                          0.0025
     1 qm_modules                                 0.0033
     1 sys_query_module                           0.0028
     1 exit_notify                                0.0016
     1 sys_sysinfo                                0.0031
    23 sys_settimeofday                           0.1106
   323 tasklet_hi_action                          2.8839
     1 tasklet_init                               0.0208
     2 __run_task_queue                           0.0208
     2 ksoftirqd                                  0.0114
     3 cpu_raise_softirq                          0.0517
     1 __request_resource                         0.0125
     1 release_resource                           0.0625
     1 check_resource                             0.0125
     1 update_wall_time_one_tick                  0.0057
     1 update_wall_time                           0.0156
   104 timer_bh                                   0.1204
    31 do_timer                                   0.2768
    60 sys_alarm                                  0.7500
     4 sys_geteuid                                0.1250
     3 sys_getgid                                 0.0938
     4 collect_signal                             0.0179
    30 bad_signal                                 0.2083
     5 send_signal                                0.0195
     2 deliver_signal                             0.0208
     2 send_sig_info                              0.0125
     1 force_sig_info                             0.0069
     1 kill_pg_info                               0.0089
     2 wake_up_parent                             0.0312
    17 sys_rt_sigaction                           0.0531
    28 sys_ssetmask                               0.3500
    11 kill_proc_info                             0.0764
     2 exec_usermodehelper                        0.0022
     1 call_usermodehelper                        0.0048
     2 vmtruncate_list                            0.0208
     9 vmtruncate                                 0.0312
     1 do_anonymous_page                          0.0045
    17 handle_mm_fault                            0.0885
     1 vmalloc_to_page                            0.0132
     1 unlock_vma_mappings                        0.0625
     1 get_unmapped_area                          0.0037
     6 find_vma                                   0.0625
    13 find_vma_prev                              0.0677
   583 find_extend_vma                            3.3125
    82 unmap_fixup                                0.2697
    17 do_brk                                     0.0354
     4 exit_mmap                                  0.0139
     1 insert_vm_struct                           0.0079
    12 .text.lock.mmap                            0.1846
     1 add_page_to_hash_queue                     0.0208
     1 __remove_inode_page                        0.0125
     1 invalidate_inode_pages                     0.0069
     1 truncate_list_pages                        0.0024
     1 invalidate_list_pages2                     0.0031
     1 generic_buffer_fdatasync                   0.0052
     1 __find_lock_page_helper                    0.0089
     6 find_or_create_page                        0.0288
     1 do_generic_file_read                       0.0010
     1 generic_file_direct_IO                     0.0021
     7 do_readahead                               0.0486
    15 madvise_willneed                           0.0493
     3 read_cache_page                            0.0099
    50 generic_file_write                         0.0306
  1069 change_protection                          3.0369
     5 mprotect_fixup                             0.0049
     3 kmem_cache_create                          0.0037
     1 remove_exclusive_swap_page                 0.0048
    59 try_to_unuse                               0.0899
   156 sys_swapoff                                0.2868
     8 get_swaphandle_info                        0.0417
    30 valid_swaphandles                          0.2222
     2 Letext                                     0.2222
     1 int_sqrt                                   0.0156
    18 badness                                    0.0938
    25 shmem_file_write                           0.0340
     4 do_shmem_file_read                         0.0167
    48 shmem_statfs                               0.6000
     2 shmem_mknod                                0.0179
    54 shmem_rename                               0.4219
     4 shmem_symlink                              0.0083
    14 shmem_follow_link                          0.1250
    35 shmem_parse_options                        0.0643
     4 sys_truncate64                             0.0104
     1 remove_super                               0.0069
     1 sys_ustat                                  0.0042
     1 get_anon_super                             0.0045
    15 kill_super                                 0.0670
     7 .text.lock.super                           0.0300
    91 do_open                                    0.2708
   268 blkdev_put                                 1.3958
     1 bdevname                                   0.0169
     2 sys_stat64                                 0.0179
     1 sys_fstat64                                0.0093
     2 copy_strings                               0.0046
     1 exec_mmap                                  0.0035
     2 flush_old_exec                             0.0033
     1 compute_creds                              0.0030
     1 pipe_read                                  0.0018
     1 sys_poll                                   0.0014
     1 flock64_to_posix_lock                      0.0035
     8 locks_insert_lock                          0.1250
    13 locks_delete_lock                          0.0580
     4 posix_lock_file                            0.0034
     1 fcntl_setlease                             0.0018
     1 locks_remove_posix                         0.0030
     1 lock_get_status                            0.0022
     1 Letext                                     0.0030
     1 free_kiobuf_bhs                            0.0125
     1 expand_kiobuf                              0.0057
    59 show_vfsmnt                                0.0658
     7 umount_tree                                0.0365
    35 do_umount                                  0.1367
    17 sys_umount                                 0.0966
     1 sys_oldumount                              0.0312
    10 copy_tree                                  0.0521
     2 graft_tree                                 0.0078
     8 do_loopback                                0.0227
     6 do_remount                                 0.0375
     4 do_move_mount                              0.0076
     1 bm_entry_read                              0.0039
     5 load_elf_binary                            0.0017
     2 proc_root_link                             0.0208
     1 proc_pid_environ                           0.0125
     1 mem_read                                   0.0030
     1 do_proc_readlink                           0.0045
     2 ext3_free_data                             0.0060
     1 ext3_do_update_inode                       0.0011
     1 ext3_setattr                               0.0024
     2 ext3_change_inode_journal_flag             0.0066
     4 ext3_find_entry                            0.0057
     2 ext3_create                                0.0069
     3 ext3_mkdir                                 0.0037
     3 empty_dir                                  0.0063
   213 ext3_orphan_add                            0.4294
     2 count_tags                                 0.0250
     1 ext2_read_super                            0.0006
     1 zlib_fs_inflate_codes                      0.0005
     1 parse_rock_ridge_inode_internal            0.0006
  2092 autoconfig                                 2.0754
     1 pci_siig10x_fn                             0.0089
     2 pci_siig20x_fn                             0.0179
     2 serial_remove_one                          0.0125
    47 register_serial                            0.0773
    25 setledstate                                0.3125
    13 register_leds                              0.1625
    11 kbd_bh                                     0.0595
    13 Letext                                     0.2031
     8 pckbd_translate                            0.0278
     1 interpret_errors                           0.0016
     1 user_reset_fdc                             0.0078
     1 raw_cmd_ioctl                              0.0010
    41 fd_ioctl                                   0.0140
    23 compute_loop_size                          0.1797
    10 do_nbd_request                             0.0391
     8 nbd_ioctl                                  0.0082
    26 eepro100_init_one                          0.0492
    81 speedo_found1                              0.0460
    16 do_eeprom_cmd                              0.0769
     1 ide_scan_devices                           0.0052
     1 ide_dmafunc_verbose                        0.0063
     1 pdc202xx_tune_chipset                      0.0012
     2 pdc202xx_new_tune_chipset                  0.0020
     1 piix_get_info                              0.0009
     1 piix_tune_drive                            0.0023
    19 cdrom_sysctl_handler                       0.0792
 48831 cdrom_sysctl_register                    435.9911
     9 pci_find_subsys                            0.0703
     3 pci_find_class                             0.0625
     6 call_policy                                0.0134
     1 usb_start_wait_urb                         0.0026
     1 usb_internal_control_msg                   0.0078
     4 usb_get_device_descriptor                  0.1250
    48 usb_get_status                             0.6000
    18 usb_get_protocol                           0.2250
     1 usb_open                                   0.0042
     1 usb_hub_configure                          0.0016
     1 usb_hcd_pci_resume                         0.0063
    64 hcd_submit_urb                             0.0833
     1 periodic_unlink                            0.0048
    68 td_submit_urb                              0.0802
    18 dl_transfer_length                         0.0804
     4 dl_del_urb                                 0.0417
     1 raid5_end_write_request                    0.0026
    19 xor_pII_mmx_5                              0.0360
     6 get_spare                                  0.0417
     1 md_sync_acct                               0.0089
     1 md_do_sync                                 0.0009
    13 unregister_netdevice                       0.0271
     1 __dev_mc_upload                            0.0208
    24 ip_frag_reasm                              0.0366
    31 ip_defrag                                  0.1107
    19 ip_forward                                 0.0419
   497 ip_options_compile                         0.3305
     2 ip_options_undo                            0.0114
    21 ip_options_get                             0.0772
    19 ip_forward_options                         0.0495
    48 ip_options_rcv_srr                         0.1505
     9 ip_queue_xmit                              0.0077
     1 ip_setsockopt                              0.0004
     6 inet_fill_ifaddr                           0.0104
     1 devinet_sysctl_register                    0.0030
    16 inet_sock_release                          0.1250
     6 inet_create                                0.0107
     1 fib_create_info                            0.0012
     1 tux_error_report                           0.0037
     1 tux_state_change                           0.0015
     1 tux_ftp_create_child                       0.0027
    13 parse_http_message                         0.0006
     1 zap_userspace_req                          0.0104
     1 gen_bitlen                                 0.0020
     1 send_all_trees                             0.0015
     3 _tr_tally                                  0.0104
     1 compress_block                             0.0009
     6 set_data_type                              0.0469
 58299 total                                      0.0368

--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ
Content-Type: text/plain;
  charset="us-ascii";
  name="pro3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pro3"

     4 _stext                                     0.0833
    27 huft_build                                 0.0147
    76 inflate_codes                              0.0731
     1 inflate_dynamic                            0.0006
    10 gunzip                                     0.0079
    56 dump_thread                                0.1944
    11 __switch_to                                0.0529
   206 alignment_check                           17.1667
     3 page_fault                                 0.2500
     1 machine_check                              0.0833
     1 spurious_interrupt_bug                     0.0833
     5 show_trace                                 0.0208
     1 show_stack                                 0.0078
  1412 save_v86_state                             2.9417
   104 sys_ipc                                    0.1912
    47 do_open                                    0.2260
     6 free_initrd_mem                            0.0469
   255 do_page_fault                              0.2073
    17 remap_area_pages                           0.0379
    46 sys_sched_getparam                         0.1797
     1 sys_sched_get_priority_min                 0.0208
    13 sys_sched_rr_get_interval                  0.0428
    93 show_task                                  0.2527
    17 render_sigset_t                            0.1328
    65 reparent_to_init                           0.2138
    16 daemonize                                  0.1429
     2 wake_up_process                            0.0267
    19 request_dma                                0.2969
   177 lookup_exec_domain                         1.1062
   148 register_exec_domain                       1.8500
     1 print_tainted                              0.0089
     3 do_syslog                                  0.0038
     1 emit_log_char                              0.0089
     1 printk                                     0.0035
     1 console_unblank                            0.0156
     1 sys_create_module                          0.0025
     1 qm_modules                                 0.0033
     1 sys_query_module                           0.0028
     1 exit_notify                                0.0016
     1 sys_sysinfo                                0.0031
    36 sys_settimeofday                           0.1731
   423 tasklet_hi_action                          3.7768
     2 tasklet_init                               0.0417
     2 __run_task_queue                           0.0208
     2 ksoftirqd                                  0.0114
     5 cpu_raise_softirq                          0.0862
     1 get_resource_list                          0.0156
     4 __request_resource                         0.0500
     1 release_resource                           0.0625
     1 check_resource                             0.0125
     1 update_wall_time_one_tick                  0.0057
     1 update_wall_time                           0.0156
   135 timer_bh                                   0.1562
    38 do_timer                                   0.3393
    80 sys_alarm                                  1.0000
     5 sys_geteuid                                0.1562
     5 sys_getgid                                 0.1562
     6 collect_signal                             0.0268
    38 bad_signal                                 0.2639
     5 send_signal                                0.0195
     2 deliver_signal                             0.0208
     4 send_sig_info                              0.0250
     3 force_sig_info                             0.0208
     1 kill_pg_info                               0.0089
     2 wake_up_parent                             0.0312
    30 sys_rt_sigaction                           0.0938
    33 sys_ssetmask                               0.4125
    13 kill_proc_info                             0.0903
     2 exec_usermodehelper                        0.0022
     1 call_usermodehelper                        0.0048
     2 vmtruncate_list                            0.0208
    10 vmtruncate                                 0.0347
     1 do_anonymous_page                          0.0045
    21 handle_mm_fault                            0.1094
     1 vmalloc_to_page                            0.0132
     1 unlock_vma_mappings                        0.0625
     1 get_unmapped_area                          0.0037
     8 find_vma                                   0.0833
    14 find_vma_prev                              0.0729
   745 find_extend_vma                            4.2330
   109 unmap_fixup                                0.3586
    23 do_brk                                     0.0479
     4 exit_mmap                                  0.0139
     2 insert_vm_struct                           0.0157
    17 .text.lock.mmap                            0.2615
     1 add_page_to_hash_queue                     0.0208
     1 __remove_inode_page                        0.0125
     1 set_page_dirty                             0.0125
     1 invalidate_inode_pages                     0.0069
     1 truncate_list_pages                        0.0024
     2 invalidate_list_pages2                     0.0063
     1 do_buffer_fdatasync                        0.0089
     1 generic_buffer_fdatasync                   0.0052
     1 __find_lock_page_helper                    0.0089
     9 find_or_create_page                        0.0433
     2 grab_cache_page_nowait                     0.0114
     1 do_generic_file_read                       0.0010
     1 generic_file_direct_IO                     0.0021
     7 do_readahead                               0.0486
    21 madvise_willneed                           0.0691
     4 read_cache_page                            0.0132
    67 generic_file_write                         0.0411
  1521 change_protection                          4.3210
     7 mprotect_fixup                             0.0068
     3 kmem_cache_create                          0.0037
     1 remove_exclusive_swap_page                 0.0048
    75 try_to_unuse                               0.1143
   218 sys_swapoff                                0.4007
    12 get_swaphandle_info                        0.0625
    39 valid_swaphandles                          0.2889
     2 Letext                                     0.2222
     1 int_sqrt                                   0.0156
    21 badness                                    0.1094
    34 shmem_file_write                           0.0462
     4 do_shmem_file_read                         0.0167
    61 shmem_statfs                               0.7625
     2 shmem_mknod                                0.0179
    71 shmem_rename                               0.5547
     5 shmem_symlink                              0.0104
    17 shmem_follow_link                          0.1518
    62 shmem_parse_options                        0.1140
     5 sys_truncate64                             0.0130
     1 remove_super                               0.0069
     1 sys_ustat                                  0.0042
     1 get_anon_super                             0.0045
     1 do_kern_mount                              0.0039
    20 kill_super                                 0.0893
    13 .text.lock.super                           0.0558
   128 do_open                                    0.3810
   351 blkdev_put                                 1.8281
     1 bdevname                                   0.0169
     3 sys_stat64                                 0.0268
     1 sys_fstat64                                0.0093
     2 copy_strings                               0.0046
     1 exec_mmap                                  0.0035
     2 flush_old_exec                             0.0033
     1 compute_creds                              0.0030
     1 pipe_read                                  0.0018
     1 sys_poll                                   0.0014
     1 flock64_to_posix_lock                      0.0035
    10 locks_insert_lock                          0.1562
    15 locks_delete_lock                          0.0670
     5 posix_lock_file                            0.0042
     2 fcntl_setlease                             0.0037
     1 locks_remove_posix                         0.0030
     1 lock_get_status                            0.0022
     1 Letext                                     0.0030
     1 free_kiobuf_bhs                            0.0125
     1 expand_kiobuf                              0.0057
    75 show_vfsmnt                                0.0837
    11 umount_tree                                0.0573
    43 do_umount                                  0.1680
    20 sys_umount                                 0.1136
     2 sys_oldumount                              0.0625
    11 copy_tree                                  0.0573
     5 graft_tree                                 0.0195
     9 do_loopback                                0.0256
     9 do_remount                                 0.0563
     8 do_move_mount                              0.0152
     1 bm_entry_read                              0.0039
     8 load_elf_binary                            0.0027
     1 load_elf_library                           0.0020
     2 proc_root_link                             0.0208
     1 proc_pid_environ                           0.0125
     1 mem_read                                   0.0030
     1 do_proc_readlink                           0.0045
     1 proc_symlink                               0.0078
     3 ext3_free_data                             0.0089
     1 ext3_free_branches                         0.0020
     1 ext3_do_update_inode                       0.0011
     1 ext3_setattr                               0.0024
     2 ext3_change_inode_journal_flag             0.0066
     1 ext3_ioctl                                 0.0009
    12 ext3_find_entry                            0.0170
     2 ext3_create                                0.0069
     4 ext3_mkdir                                 0.0049
     3 empty_dir                                  0.0063
   295 ext3_orphan_add                            0.5948
     2 ext3_orphan_del                            0.0037
     2 count_tags                                 0.0250
     1 ext2_read_super                            0.0006
     1 zlib_fs_inflate_blocks                     0.0003
     1 zlib_fs_inflate_codes                      0.0005
     1 huft_build                                 0.0005
     1 parse_rock_ridge_inode_internal            0.0006
  2860 autoconfig                                 2.8373
     1 pci_siig10x_fn                             0.0089
     2 pci_siig20x_fn                             0.0179
     2 serial_remove_one                          0.0125
    47 register_serial                            0.0773
    31 setledstate                                0.3875
    22 register_leds                              0.2750
    20 kbd_bh                                     0.1081
    17 Letext                                     0.2656
     9 pckbd_translate                            0.0312
     1 interpret_errors                           0.0016
     1 user_reset_fdc                             0.0078
     1 raw_cmd_ioctl                              0.0010
    60 fd_ioctl                                   0.0205
    32 compute_loop_size                          0.2500
    17 do_nbd_request                             0.0664
    12 nbd_ioctl                                  0.0123
    32 eepro100_init_one                          0.0606
   104 speedo_found1                              0.0591
    18 do_eeprom_cmd                              0.0865
     1 ide_scan_devices                           0.0052
     1 ide_dmafunc_verbose                        0.0063
     1 pdc202xx_tune_chipset                      0.0012
     2 pdc202xx_new_tune_chipset                  0.0020
     1 piix_get_info                              0.0009
     1 piix_tune_drive                            0.0023
    27 cdrom_sysctl_handler                       0.1125
 57992 cdrom_sysctl_register                    517.7857
    12 pci_find_subsys                            0.0938
     5 pci_find_class                             0.1042
     8 call_policy                                0.0179
     1 usb_start_wait_urb                         0.0026
     2 usb_internal_control_msg                   0.0156
     1 usb_control_msg                            0.0069
     5 usb_get_device_descriptor                  0.1562
    65 usb_get_status                             0.8125
    24 usb_get_protocol                           0.3000
     1 usb_open                                   0.0042
     1 usb_hub_configure                          0.0016
     1 usb_hcd_pci_resume                         0.0063
    86 hcd_submit_urb                             0.1120
     1 periodic_unlink                            0.0048
    96 td_submit_urb                              0.1132
    20 dl_transfer_length                         0.0893
     6 dl_del_urb                                 0.0625
     2 raid5_end_write_request                    0.0052
    25 xor_pII_mmx_5                              0.0473
     6 get_spare                                  0.0417
     1 md_sync_acct                               0.0089
     1 md_do_sync                                 0.0009
    13 unregister_netdevice                       0.0271
     1 __dev_mc_upload                            0.0208
    36 ip_frag_reasm                              0.0549
    38 ip_defrag                                  0.1357
    24 ip_forward                                 0.0529
     1 ip_options_echo                            0.0012
   684 ip_options_compile                         0.4548
     2 ip_options_undo                            0.0114
    27 ip_options_get                             0.0993
    26 ip_forward_options                         0.0677
    55 ip_options_rcv_srr                         0.1724
    12 ip_queue_xmit                              0.0103
     1 ip_setsockopt                              0.0004
     1 inet_del_ifa                               0.0031
     6 inet_fill_ifaddr                           0.0104
     1 devinet_sysctl_register                    0.0030
    19 inet_sock_release                          0.1484
     9 inet_create                                0.0161
     1 fib_create_info                            0.0012
     1 tux_error_report                           0.0037
     1 tux_state_change                           0.0015
     2 tux_ftp_data_ready                         0.0114
     2 tux_ftp_create_child                       0.0054
    16 parse_http_message                         0.0007
     1 zap_userspace_req                          0.0104
     3 gen_bitlen                                 0.0060
     1 send_all_trees                             0.0015
     3 _tr_tally                                  0.0104
     1 compress_block                             0.0009
     6 set_data_type                              0.0469
 70765 total                                      0.0447

--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ
Content-Type: text/plain;
  charset="us-ascii";
  name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".config"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M586MMX=y
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_X86_F00F_WORKS_OK is not set
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHIO is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_CMBATT=y
CONFIG_ACPI_THERMAL=y
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
CONFIG_IP_NF_MATCH_MULTIPORT=y
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
CONFIG_IP_NF_MATCH_STATE=y
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=y
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
CONFIG_IPV6=y

#
#   IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
# CONFIG_IP6_NF_MATCH_MAC is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=y
# CONFIG_IP6_NF_MATCH_OWNER is not set
# CONFIG_IP6_NF_MATCH_MARK is not set
# CONFIG_IP6_NF_MATCH_LENGTH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
# CONFIG_IP6_NF_MANGLE is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=y
CONFIG_BLK_DEV_CMD680=y
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
CONFIG_BLK_DEV_HPT34X=y
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_PDC202XX=y
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=y
CONFIG_BLK_DEV_ATARAID_PDC=y
CONFIG_BLK_DEV_ATARAID_HPT=y

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
CONFIG_PCNET32=y
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
# CONFIG_TLAN is not set
# CONFIG_TC35815 is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
CONFIG_E1000=y
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_AMD7XX_TCO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso8859-15"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
# CONFIG_USB_DEVICEFS is not set
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set

#
# Library routines
#
# CONFIG_ZLIB_INFLATE is not set
# CONFIG_ZLIB_DEFLATE is not set

--------------Boundary-00=_8D7ZMWFV6X3PCI32YPTZ--

