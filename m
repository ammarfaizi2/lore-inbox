Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbRB1PCu>; Wed, 28 Feb 2001 10:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRB1PCd>; Wed, 28 Feb 2001 10:02:33 -0500
Received: from ns1.bmlv.gv.at ([193.171.152.34]:19723 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S130205AbRB1PCY>;
	Wed, 28 Feb 2001 10:02:24 -0500
Message-Id: <3.0.6.32.20010228160302.0092f100@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 28 Feb 2001 16:03:02 +0100
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@mail.bmlv.gv.at>
Subject: PROBLEM: Kernel bug in inode.c:885 when floppy disk removed
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

Hope I didn't forget something necessary.



1:
Kernel bug/Segmentation fault when floppy disk removed 2nd time


2: 
Segmentation fault in a program, 
hanging processes in "D"-state,
Kernel bug in inode.c:885!

when removing floppy disk before unmounting and then using again


3:
kernel floppy oops removed D-state hang


4:
Linux version 2.4.2 (milh@sifs) (gcc version 2.95.2 19991024 (release)) #1 Tue Feb 27 09:14:31 CET 2001


5:
Feb 28 15:38:57 suisse kernel: kernel BUG at inode.c:885!
Feb 28 15:38:57 suisse kernel: invalid operand: 0000
Feb 28 15:38:57 suisse kernel: CPU:    0
Feb 28 15:38:57 suisse kernel: EIP:    0010:[iput+205/332]
Feb 28 15:38:57 suisse kernel: EFLAGS: 00010282
Feb 28 15:38:57 suisse kernel: eax: 0000001b   ebx: c646d0e0   ecx: c653c000   edx: c01ea368
Feb 28 15:38:57 suisse kernel: esi: c01edde0   edi: c63fc4a0   ebp: c6085fa4   esp: c6085f50
Feb 28 15:38:57 suisse kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 15:38:57 suisse kernel: Process rm (pid: 544, stackpage=c6085000)
Feb 28 15:38:57 suisse kernel: Stack: c01c72a5 c01c7325 00000375 c63fc4a0 c646d0e0 c013fca6 c646d0e0 00000000 
Feb 28 15:38:57 suisse kernel:        c60f6dc0 c0139c09 c63fc4a0 c63fc4a0 c63fc4a0 c6c96000 c0139ce3 c60f6dc0 
Feb 28 15:38:57 suisse kernel:        c63fc4a0 c6084000 bffffa20 00000000 bffff744 c6ae8940 c66b9960 c6c96007 
Feb 28 15:38:57 suisse kernel: Call Trace: [d_delete+78/112] [vfs_unlink+249/300] [sys_unlink+167/284] [system_call+51/56] 
Feb 28 15:38:57 suisse kernel: 
Feb 28 15:38:57 suisse kernel: Code: 0f 0b 83 c4 0c eb 6c 39 1b 74 38 f6 83 ec 00 00 00 07 75 26 


6:
/sbin/mke2fs /dev/fd0
mount /dev/fd0 /mnt/floppy
cp /bin/bash /mnt/floppy
sync
#wait for completion, remove floppy. first timeout-messages in log
umount /mnt/floppy

# ok as far - but: insert floppy
mount /dev/fd0 /mnt/floppy
rm /mnt/floppy/bash
sync
# remove floppy again
cp /bin/bash /mnt/floppy
# BUG! BAM! CRASH!
# this or some other (df, du, ls) command hangs forever (until reboot :-) in D-state!
# sometimes works for some tries. try sync inbetween


7.7. additional
	1. logfile 
	2. /proc/ksyms
	3. strace of an ls


7.7.1: logfile
Feb 28 15:38:57 suisse kernel: floppy driver state
Feb 28 15:38:57 suisse kernel: -------------------
Feb 28 15:38:57 suisse kernel: now=19380 last interrupt=19087 diff=293 last called handler=c0158bb8
Feb 28 15:38:57 suisse kernel: timeout_message=floppy start
Feb 28 15:38:57 suisse kernel: last output bytes:
Feb 28 15:38:57 suisse kernel:  0 90 19080
Feb 28 15:38:57 suisse kernel: 13 90 19080
Feb 28 15:38:57 suisse kernel:  0 90 19080
Feb 28 15:38:57 suisse kernel: 1a 90 19080
Feb 28 15:38:57 suisse kernel:  0 90 19080
Feb 28 15:38:57 suisse kernel:  3 90 19080
Feb 28 15:38:57 suisse kernel: c1 90 19080
Feb 28 15:38:57 suisse kernel: 10 90 19080
Feb 28 15:38:57 suisse kernel:  7 80 19080
Feb 28 15:38:57 suisse kernel:  0 90 19080
Feb 28 15:38:57 suisse kernel:  8 81 19087
Feb 28 15:38:57 suisse kernel: e6 80 19087
Feb 28 15:38:57 suisse kernel:  0 90 19087
Feb 28 15:38:57 suisse last message repeated 2 times
Feb 28 15:38:57 suisse kernel:  9 90 19087
Feb 28 15:38:57 suisse kernel:  2 90 19087
Feb 28 15:38:57 suisse kernel: 12 90 19087
Feb 28 15:38:57 suisse kernel: 1b 90 19087
Feb 28 15:38:57 suisse kernel: ff 90 19087
Feb 28 15:38:57 suisse kernel: last result at 19087
Feb 28 15:38:57 suisse kernel: last redo_fd_request at 19080
Feb 28 15:38:57 suisse kernel: 20  0 
Feb 28 15:38:57 suisse kernel: status=50
Feb 28 15:38:57 suisse kernel: fdc_busy=1
Feb 28 15:38:57 suisse kernel: DEVICE_INTR=c0157c80
Feb 28 15:38:57 suisse kernel: fd_timer.function=c0157be8
Feb 28 15:38:57 suisse kernel: cont=c01ef3b8
Feb 28 15:38:57 suisse kernel: CURRENT=c6f7d3c0
Feb 28 15:38:57 suisse kernel: command_status=-1
Feb 28 15:38:57 suisse kernel: 
Feb 28 15:38:57 suisse kernel: floppy0: floppy timeout called
Feb 28 15:38:57 suisse kernel: end_request: I/O error, dev 02:00 (floppy), sector 8
Feb 28 15:38:57 suisse kernel: EXT2-fs error (device fd(2,0)): read_inode_bitmap: Cannot read inode bitmap - block_group = 0, inode_bitmap = 4
Feb 28 15:38:57 suisse kernel: kernel BUG at inode.c:885!
Feb 28 15:38:57 suisse kernel: invalid operand: 0000
Feb 28 15:38:57 suisse kernel: CPU:    0
Feb 28 15:38:57 suisse kernel: EIP:    0010:[iput+205/332]
Feb 28 15:38:57 suisse kernel: EFLAGS: 00010282
Feb 28 15:38:57 suisse kernel: eax: 0000001b   ebx: c646d0e0   ecx: c653c000   edx: c01ea368
Feb 28 15:38:57 suisse kernel: esi: c01edde0   edi: c63fc4a0   ebp: c6085fa4   esp: c6085f50
Feb 28 15:38:57 suisse kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 15:38:57 suisse kernel: Process rm (pid: 544, stackpage=c6085000)
Feb 28 15:38:57 suisse kernel: Stack: c01c72a5 c01c7325 00000375 c63fc4a0 c646d0e0 c013fca6 c646d0e0 00000000 
Feb 28 15:38:57 suisse kernel:        c60f6dc0 c0139c09 c63fc4a0 c63fc4a0 c63fc4a0 c6c96000 c0139ce3 c60f6dc0 
Feb 28 15:38:57 suisse kernel:        c63fc4a0 c6084000 bffffa20 00000000 bffff744 c6ae8940 c66b9960 c6c96007 
Feb 28 15:38:57 suisse kernel: Call Trace: [d_delete+78/112] [vfs_unlink+249/300] [sys_unlink+167/284] [system_call+51/56] 
Feb 28 15:38:57 suisse kernel: 
Feb 28 15:38:57 suisse kernel: Code: 0f 0b 83 c4 0c eb 6c 39 1b 74 38 f6 83 ec 00 00 00 07 75 26 
Feb 28 15:39:17 suisse kernel: 
Feb 28 15:39:17 suisse kernel: floppy driver state
Feb 28 15:39:17 suisse kernel: -------------------
Feb 28 15:39:17 suisse kernel: now=21375 last interrupt=21040 diff=335 last called handler=c01587a4
Feb 28 15:39:17 suisse kernel: timeout_message=floppy start
Feb 28 15:39:17 suisse kernel: last output bytes:
Feb 28 15:39:17 suisse kernel:  0 90 21040
Feb 28 15:39:17 suisse kernel:  3 90 21040
Feb 28 15:39:17 suisse kernel: c1 90 21040
Feb 28 15:39:17 suisse kernel: 10 90 21040
Feb 28 15:39:17 suisse kernel:  7 80 21040
Feb 28 15:39:17 suisse kernel:  0 90 21040
Feb 28 15:39:17 suisse kernel:  8 81 21040
Feb 28 15:39:17 suisse kernel:  f 80 21040
Feb 28 15:39:17 suisse kernel:  0 90 21040
Feb 28 15:39:17 suisse kernel:  1 91 21040
Feb 28 15:39:17 suisse kernel:  8 81 21040
Feb 28 15:39:17 suisse kernel: 45 80 21077
Feb 28 15:39:17 suisse kernel:  4 90 21077
Feb 28 15:39:17 suisse kernel:  1 90 21077
Feb 28 15:39:17 suisse kernel:  1 90 21077
Feb 28 15:39:17 suisse kernel:  3 90 21077
Feb 28 15:39:17 suisse kernel:  2 90 21077
Feb 28 15:39:17 suisse kernel:  4 90 21077
Feb 28 15:39:17 suisse kernel: 1b 90 21077
Feb 28 15:39:17 suisse kernel: ff 90 21077
Feb 28 15:39:17 suisse kernel: last result at 21040
Feb 28 15:39:17 suisse kernel: last redo_fd_request at 21039
Feb 28 15:39:17 suisse kernel: 20  1 
Feb 28 15:39:17 suisse kernel: status=10
Feb 28 15:39:17 suisse kernel: fdc_busy=1
Feb 28 15:39:17 suisse kernel: DEVICE_INTR=c0157c80
Feb 28 15:39:17 suisse kernel: fd_timer.function=c0157be8
Feb 28 15:39:17 suisse kernel: cont=c01ef3b8
Feb 28 15:39:17 suisse kernel: CURRENT=c6f7d7e0
Feb 28 15:39:17 suisse kernel: command_status=-1
Feb 28 15:39:17 suisse kernel: 
Feb 28 15:39:17 suisse kernel: floppy0: floppy timeout called
Feb 28 15:39:17 suisse kernel: end_request: I/O error, dev 02:00 (floppy), sector 56

7.7.2: /proc/ksyms
c782f660 __insmod_usb-ohci_S.rodata_L1841	[usb-ohci]
c782fda0 __insmod_usb-ohci_S.data_L192	[usb-ohci]
c782c000 __insmod_usb-ohci_O/lib/modules/2.4.2/kernel/drivers/usb/usb-ohci.o_M3A9B661B_V132098	[usb-ohci]
c782fdec sohci_device_operations	[usb-ohci]
c782c060 __insmod_usb-ohci_S.text_L13802	[usb-ohci]
c7824270 usb_ifnum_to_if	[usbcore]
c78242b8 usb_epnum_to_ep_desc	[usbcore]
c7824060 usb_register	[usbcore]
c7824200 usb_deregister	[usbcore]
c78240fc usb_scan_devices	[usbcore]
c7824634 usb_alloc_bus	[usbcore]
c78246a4 usb_free_bus	[usbcore]
c78246b8 usb_register_bus	[usbcore]
c7824774 usb_deregister_bus	[usbcore]
c7824b58 usb_alloc_dev	[usbcore]
c7824bd8 usb_free_dev	[usbcore]
c7824c08 usb_inc_dev_use	[usbcore]
c7824814 usb_driver_claim_interface	[usbcore]
c7824834 usb_interface_claimed	[usbcore]
c782484c usb_driver_release_interface	[usbcore]
c782486c usb_match_id	[usbcore]
c7825864 usb_root_hub_string	[usbcore]
c782653c usb_new_device	[usbcore]
c7827dec usb_reset_device	[usbcore]
c7825a4c usb_connect	[usbcore]
c7825958 usb_disconnect	[usbcore]
c7824520 usb_check_bandwidth	[usbcore]
c78245c0 usb_claim_bandwidth	[usbcore]
c78245f4 usb_release_bandwidth	[usbcore]
c7825b98 usb_set_address	[usbcore]
c7825bc8 usb_get_descriptor	[usbcore]
c7825c74 usb_get_class_descriptor	[usbcore]
c78258f0 __usb_get_extra_descriptor	[usbcore]
c7825d18 usb_get_device_descriptor	[usbcore]
c7825cc8 usb_get_string	[usbcore]
c7826408 usb_string	[usbcore]
c7825d78 usb_get_protocol	[usbcore]
c7825dc4 usb_set_protocol	[usbcore]
c7826128 usb_get_report	[usbcore]
c782617c usb_set_report	[usbcore]
c7825e00 usb_set_idle	[usbcore]
c7825f0c usb_clear_halt	[usbcore]
c7825fd0 usb_set_interface	[usbcore]
c78261cc usb_get_configuration	[usbcore]
c782605c usb_set_configuration	[usbcore]
c7825018 usb_get_current_frame_number	[usbcore]
c7824c10 usb_alloc_urb	[usbcore]
c7824c74 usb_free_urb	[usbcore]
c7824c88 usb_submit_urb	[usbcore]
c7824cb8 usb_unlink_urb	[usbcore]
c7824f18 usb_control_msg	[usbcore]
c7824fb0 usb_bulk_msg	[usbcore]
c782a7e0 usb_devfs_handle	[usbcore]
c7824000 __insmod_usbcore_O/lib/modules/2.4.2/kernel/drivers/usb/usbcore.o_M3A9B661B_V132098	[usbcore]
c7824060 __insmod_usbcore_S.text_L16504	[usbcore]
c7828160 __insmod_usbcore_S.rodata_L7982	[usbcore]
c782a660 __insmod_usbcore_S.data_L280	[usbcore]
c782a780 __insmod_usbcore_S.bss_L100	[usbcore]
c7822660 __insmod_sis900_S.data_L256	[sis900]
c7821e60 __insmod_sis900_S.rodata_L2033	[sis900]
c782282c __insmod_sis900_S.bss_L4	[sis900]
c7820000 __insmod_sis900_O/lib/modules/2.4.2/kernel/drivers/net/sis900.o_M3A9B6619_V132098	[sis900]
c7820060 __insmod_sis900_S.text_L7670	[sis900]
c01071bc machine_real_restart
c0242520 drive_info
c01e9540 boot_cpu_data
c0242508 MCA_bus
c0111ce0 __verify_write
c01075ac dump_thread
c010ded8 dump_fpu
c010df7c dump_extended_fpu
c01124a0 __ioremap
c0112590 iounmap
c01b5050 __io_virt_debug
c010a08c enable_irq
c010a038 disable_irq
c010a798 disable_irq_nosync
c010a3b8 probe_irq_mask
c01073fc kernel_thread
c0242504 pm_idle
c0241bd4 pm_power_off
c010cd98 get_cmos_time
c024254c apm_info
c010022c gdt
c0107a60 __down_failed
c0107a6c __down_failed_interruptible
c0107a78 __down_failed_trylock
c0107a84 __up_wakeup
c0107aac __down_write_failed
c0107a90 __down_read_failed
c0107cd0 __rwsem_wake
c01b4c54 csum_partial_copy_generic
c01b4dbc __udelay
c01b4d94 __delay
c01b4ddc __const_udelay
c01b4fa4 __get_user_1
c01b4fb8 __get_user_2
c01b4fd4 __get_user_4
c01b4ff4 __put_user_1
c01b5008 __put_user_2
c01b5024 __put_user_4
c01b51e4 strtok
c01b51b0 strpbrk
c01b5394 simple_strtol
c01b4e9c strncpy_from_user
c01b4e78 __strncpy_from_user
c01b4ee8 clear_user
c01b4f28 __clear_user
c01b4e3c __generic_copy_from_user
c01b4e00 __generic_copy_to_user
c01b4f54 strnlen_user
c010d500 pci_alloc_consistent
c010d570 pci_free_consistent
c010f0d8 pcibios_penalize_isa_irq
c0241d00 screen_info
c0107840 get_wchan
c01e99cc rtc_lock
c01b50b8 memcpy
c01b50e0 memset
c010fca0 mtrr_add
c010feb4 mtrr_del
c011b768 dequeue_signal
c011b570 flush_signals
c011be38 force_sig
c011bbf8 force_sig_info
c011be50 kill_pg
c011bc84 kill_pg_info
c011be90 kill_proc
c011ca88 kill_proc_info
c011be70 kill_sl
c011bcdc kill_sl_info
c011bfd0 notify_parent
c011cad0 recalc_sigpending
c011be18 send_sig
c011bb60 send_sig_info
c011b618 block_all_signals
c011b648 unblock_all_signals
c011cb00 notifier_chain_register
c011cb34 notifier_chain_unregister
c011cb60 notifier_call_chain
c011cb98 register_reboot_notifier
c011cbac unregister_reboot_notifier
c011db7c in_group_p
c011dba4 in_egroup_p
c011e2a0 exec_usermodehelper
c011e8f8 call_usermodehelper
c011e6dc request_module
c011ea50 schedule_task
c011ec3c flush_scheduled_tasks
c0115140 inter_module_register
c0115218 inter_module_unregister
c01152b4 inter_module_get
c0115304 inter_module_get_request
c011532c inter_module_put
c0115a90 try_inc_mod_count
c0120d28 do_mmap_pgoff
c012173c do_munmap
c01219d0 do_brk
c0117088 exit_mm
c0116e20 exit_files
c0116f14 exit_fs
c011b58c exit_sighand
c0129e38 __alloc_pages
c012bd30 alloc_pages_node
c012a118 __get_free_pages
c012a138 get_zeroed_page
c012a164 __free_pages
c012a180 free_pages
c01eb460 contig_page_data
c0245218 num_physpages
c0127484 kmem_find_general_cachep
c0126ae4 kmem_cache_create
c0126f4c kmem_cache_destroy
c0126f00 kmem_cache_shrink
c0127238 kmem_cache_alloc
c012732c kmem_cache_free
c012728c kmalloc
c01273d4 kfree
c01263f8 vfree
c0126460 __vmalloc
c0245418 mem_map
c0120004 remap_page_range
c0245400 max_mapnr
c02451f8 high_memory
c01205bc vmtruncate
c012139c find_vma
c0121130 get_unmapped_area
c01e85e0 init_mm
c0127a08 deactivate_page
c01ecfc0 def_blk_fops
c01411bc update_atime
c0132544 get_fs_type
c0132fbc get_super
c013309c get_empty_super
c0137d90 getname
c0245468 names_cachep
c012f188 fput
c012f258 fget
c0140e94 igrab
c0140e30 iunique
c0140f04 iget4
c0141030 iput
c014117c force_delete
c01380dc follow_up
c013816c follow_down
c0138b2c path_init
c0138214 path_walk
c0137f88 path_release
c0138d50 __user_walk
c0138cf0 lookup_one
c0138c64 lookup_hash
c012e434 sys_close
c01ed2f8 dcache_lock
c013fa58 d_alloc_root
c013fc58 d_delete
c013f414 dget_locked
c013fb90 d_validate
c013fcc8 d_rehash
c013f3b4 d_invalidate
c013fd04 d_move
c013fa30 d_instantiate
c013f8c0 d_alloc
c013fa94 d_lookup
c013fdf4 __d_path
c01302a0 mark_buffer_dirty
c012ff30 set_buffer_async_io
c0130274 __mark_buffer_dirty
c01402c4 __mark_inode_dirty
c012f020 get_empty_filp
c012f11c init_private_file
c012dfec filp_open
c012e3d0 filp_close
c012f280 put_filp
c01ecd7c files_lock
c013530c check_disk_change
c012faf0 __invalidate_buffers
c01409f0 invalidate_inodes
c0121f88 invalidate_inode_pages
c012218c truncate_inode_pages
c012f5c0 fsync_dev
c0137f0c permission
c0137e28 vfs_permission
c0141338 inode_setattr
c0141210 inode_change_ok
c0140690 write_inode_now
c0141450 notify_change
c012fa6c get_hardblocksize
c012fbd0 set_blocksize
c0130100 getblk
c013506c bdget
c0135130 bdput
c01303d4 bread
c0130354 __brelse
c0130374 __bforget
c0155e2c ll_rw_block
c0155d70 submit_bh
c012f360 __wait_on_buffer
c0122804 ___wait_on_page
c0131414 block_write_full_page
c0130ce4 block_read_full_page
c01311a0 block_prepare_write
c013203c block_sync_page
c0130f08 cont_prepare_write
c01311dc generic_commit_write
c013123c block_truncate_page
c0131558 generic_block_bmap
c0123384 generic_file_read
c0122e40 do_generic_file_read
c0124c3c generic_file_write
c0123d9c generic_file_mmap
c01ecc80 generic_ro_fops
c0122328 generic_buffer_fdatasync
c0245204 page_hash_bits
c024520c page_hash_table
c01ed2e8 file_lock_list
c013cef8 locks_init_lock
c013cf9c locks_copy_lock
c013dbb0 posix_lock_file
c013d7e0 posix_test_lock
c013ee04 posix_block_lock
c013ee18 posix_unblock_lock
c013d8c0 locks_mandatory_area
c013f270 dput
c013f78c have_submounts
c013f444 d_find_alias
c013f498 d_prune_aliases
c013f500 prune_dcache
c013f648 shrink_dcache_sb
c013f870 shrink_dcache_parent
c014012c find_inode_number
c01400bc is_subdir
c012e19c get_unused_fd
c0138da8 vfs_create
c01396a0 vfs_mkdir
c0139458 vfs_mknod
c0139d58 vfs_symlink
c0139ed4 vfs_link
c0139868 vfs_rmdir
c0139b10 vfs_unlink
c013a840 vfs_rename
c012d070 vfs_statfs
c012e4c0 generic_read_dir
c013c014 __pollwait
c013bfd0 poll_freewait
c0245470 ROOT_DEV
c01229d8 __find_lock_page
c0124b98 grab_cache_page
c0124a00 read_cache_page
c013aad0 vfs_readlink
c013ab28 vfs_follow_link
c013ace8 page_readlink
c013ad38 page_follow_link
c01ed240 page_symlink_inode_operations
c0131abc block_symlink
c013ba40 vfs_readdir
c013e080 __get_lease
c013e28c lease_get_mtime
c013f188 lock_may_read
c013f200 lock_may_write
c013babc dcache_readdir
c012e4c8 default_llseek
c012e048 dentry_open
c0123778 filemap_nopage
c0123b78 filemap_sync
c0122954 lock_page
c012edc0 register_chrdev
c012ee44 unregister_chrdev
c0135228 register_blkdev
c01352b0 unregister_blkdev
c015f908 tty_register_driver
c015f9b4 tty_unregister_driver
c0250600 tty_std_termios
c0134a88 block_read
c01345e0 block_write
c024f400 blksize_size
c0245880 hardsect_size
c024f800 blk_size
c0246080 blk_dev
c015536c is_read_only
c01553ac set_device_ro
c0141190 bmap
c012f59c sync_dev
c014881c devfs_register_partitions
c0135554 blkdev_open
c0135440 blkdev_get
c01355d4 blkdev_put
c01353a0 ioctl_by_bdev
c0245474 gendisk_head
c014884c grok_partitions
c0148820 register_disk
c01eec00 tq_disk
c012fe18 init_buffer
c0130344 refile_buffer
c0245480 max_sectors
c0245c80 max_readahead
c012f2e4 file_moveto
c015d96c tty_hangup
c0161f80 tty_wait_until_sent
c015d604 tty_check_change
c015d990 tty_hung_up_p
c015f730 tty_flip_buffer_push
c015f6bc tty_get_baud_rate
c015f530 do_SAK
c0114dfc console_print
c01ea370 console_loglevel
c0132318 register_filesystem
c0132364 unregister_filesystem
c01337b4 kern_mount
c0133834 kern_umount
c0133850 may_umount
c0135f60 register_binfmt
c0135fac unregister_binfmt
c0136cac search_binary_handler
c01369e8 prepare_binprm
c0136af8 compute_creds
c0136c50 remove_arg_zero
c0136ff4 set_binfmt
c0114714 register_exec_domain
c011475c unregister_exec_domain
c0114794 __set_personality
c0118eac register_sysctl_table
c0118f24 unregister_sysctl_table
c0119d8c sysctl_string
c0119eb4 sysctl_intvec
c0119f34 sysctl_jiffies
c01191c4 proc_dostring
c01196b4 proc_dointvec
c0119d60 proc_dointvec_jiffies
c011972c proc_dointvec_minmax
c0119d30 proc_doulongvec_ms_jiffies_minmax
c0119d04 proc_doulongvec_minmax
c011a830 add_timer
c011a9c8 del_timer
c010a1b0 request_irq
c010a254 free_irq
c0242960 irq_stat
c01135f0 add_wait_queue
c011361c add_wait_queue_exclusive
c0113644 remove_wait_queue
c010a2cc probe_irq_on
c010a41c probe_irq_off
c011a8fc mod_timer
c01eaf54 tq_timer
c01eaf5c tq_immediate
c01419f4 kiobuf_init
c0141a28 alloc_kiovec
c0141a84 free_kiovec
c0141ae8 expand_kiobuf
c011f914 map_user_kiobuf
c011fb60 unmap_kiobuf
c011fbe0 lock_kiovec
c011fca0 unlock_kiovec
c01316b4 brw_kiovec
c0141b80 kiobuf_wait_for_io
c0113588 request_dma
c01135c0 free_dma
c01ea240 dma_spin_lock
c0107110 disable_hlt
c0107118 enable_hlt
c0118878 request_resource
c011889c release_resource
c01189a4 allocate_resource
c01188ac check_resource
c0118a00 __request_region
c0118a78 __check_region
c0118ab8 __release_region
c01ea438 ioport_resource
c01ea454 iomem_resource
c0117518 up_and_exit
c0112b50 __wake_up
c01134f0 wake_up_process
c0112d34 sleep_on
c0112d84 sleep_on_timeout
c0112c88 interruptible_sleep_on
c0112cd8 interruptible_sleep_on_timeout
c01127bc schedule
c0112718 schedule_timeout
c02439ec jiffies
c02429b0 xtime
c010ca40 do_gettimeofday
c010ca9c do_settimeofday
c01e8708 loops_per_jiffy
c0243a00 kstat
c02439e8 nr_running
c01148c0 panic
c0114c9c printk
c01b5b44 sprintf
c01b57d8 vsprintf
c012eef0 kdevname
c01356c8 bdevname
c012ef18 cdevname
c01b52f0 simple_strtoul
c01e8720 system_utsname
c01eafe0 uts_sem
c01e8918 sys_call_table
c0107264 machine_restart
c01072e4 machine_halt
c01072e8 machine_power_off
c01f9c28 _ctype
c016551c secure_tcp_sequence_number
c0164930 get_random_bytes
c01ea200 securebits
c01eaf44 cap_bset
c011349c daemonize
c013642c setup_arg_pages
c01362c4 copy_strings_kernel
c0136e0c do_execve
c01367a0 flush_old_exec
c0136628 kernel_read
c0136560 open_exec
c0111ca4 si_meminfo
c0242980 sys_tz
c0132e7c __wait_on_super
c012f600 file_fsync
c012ff3c fsync_inode_buffers
c0140818 clear_inode
c01eb334 nr_async_pages
c025482c ___strtok
c012ef5c init_special_inode
c024fc00 read_ahead
c012f9d8 get_hash_table
c0140c54 get_empty_inode
c0140fd8 insert_inode_hash
c014101c remove_inode_hash
c012fa90 buffer_insert_inode_queue
c014155c make_bad_inode
c014158c is_bad_inode
c02429c0 event
c0131a20 brw_page
c01eafc0 overflowuid
c01eafc4 overflowgid
c01eafc8 fs_overflowuid
c01eafcc fs_overflowgid
c013b608 fasync_helper
c013b738 kill_fasync
c0148370 disk_name
c0137f3c get_write_access
c0114e74 register_console
c01150a8 unregister_console
c0117da8 get_fast_time
c01b5100 strnicmp
c01b5168 strspn
c01b5244 strsep
c022c5a0 tasklet_hi_vec
c022c580 tasklet_vec
c0242600 bh_task_vec
c0118684 init_bh
c011869c remove_bh
c011859c tasklet_init
c01185c0 tasklet_kill
c01186c8 __run_task_queue
c01fa000 init_task_union
c022c520 tasklist_lock
c02429e0 pidhash
c011f220 pm_register
c011f278 pm_unregister
c011f2a4 pm_unregister_all
c011f2d4 pm_send
c011f364 pm_send_all
c011f3c4 pm_find
c02439e0 pm_active
c01ed3c8 nfsd_linkage
c0245478 proc_sys_root
c0145c84 proc_symlink
c0145d74 proc_mknod
c0145e3c proc_mkdir
c0145ef8 create_proc_entry
c0146050 remove_proc_entry
c01ed4c0 proc_root
c024542c proc_root_fs
c0245464 proc_net
c024547c proc_bus
c0245428 proc_root_driver
c014ef74 register_nls
c014efc8 unregister_nls
c014f0c0 unload_nls
c014f04c load_nls
c014f148 load_nls_default
c014ede0 utf8_mbtowc
c014ee48 utf8_mbstowcs
c014eea4 utf8_wctomb
c014ef20 utf8_wcstombs
c01eec08 io_request_lock
c015608c end_that_request_first
c0156170 end_that_request_last
c0155208 blk_init_queue
c0154f30 blk_get_queue
c0156274 __blk_get_queue
c0154fa8 blk_cleanup_queue
c0155000 blk_queue_headactive
c015500c blk_queue_pluggable
c0155018 blk_queue_make_request
c0155c3c generic_make_request
c01562a4 blkdev_release_request
c0155124 generic_unplug_device
c024fffc queued_sectors
c0156814 blk_ioctl
c015f900 tty_register_devfs
c015f904 tty_unregister_devfs
c0163e14 misc_register
c0163ee8 misc_deregister
c0164458 add_keyboard_randomness
c0164480 add_mouse_randomness
c0164494 add_interrupt_randomness
c01644bc add_blkdev_randomness
c0164244 batch_entropy_store
c01f0a30 color_table
c01f0a40 default_red
c01f0a80 default_grn
c01f0ac0 default_blu
c02519e0 video_font_height
c025052c video_scan_lines
c01697d0 vc_resize
c0250528 fg_console
c025070c console_blank_hook
c0250020 vt_cons
c016cc94 take_over_console
c016ce24 give_up_console
c016d8a0 set_selection
c016de10 paste_selection
c0171b0c register_serial
c0171d2c unregister_serial
c0171e5c handle_scancode
c0250628 kbd_ledfunc
c01f3c2c keyboard_tasklet
c01739f0 autoirq_setup
c01739fc autoirq_report
c0174bd0 agp_free_memory
c0174c58 agp_allocate_memory
c0174d28 agp_copy_info
c0174da4 agp_bind_memory
c0174dfc agp_unbind_memory
c0175574 agp_enable
c0174aa0 agp_backend_acquire
c0174ad0 agp_backend_release
c0251a20 ide_hwifs
c0179a6c ide_register_module
c0179aa8 ide_unregister_module
c017868c ide_spin_wait_hwgroup
c0251a08 ide_probe
c0175a98 drive_is_flashcard
c0177268 ide_timer_expiry
c01774ec ide_intr
c01f685c ide_fops
c017722c ide_get_queue
c017889c ide_add_generic_settings
c0251a04 ide_devfs_handle
c0177254 do_ide_request
c0179804 ide_scan_devices
c0179900 ide_register_subdriver
c01799f8 ide_unregister_subdriver
c0177b24 ide_replace_subdriver
c0175c28 ide_input_data
c0175cd8 ide_output_data
c0175d68 atapi_input_bytes
c0175db0 atapi_output_bytes
c0175e58 ide_set_handler
c01764b8 ide_dump_status
c01767d4 ide_error
c017966c ide_fixstring
c0176b04 ide_wait_stat
c017639c ide_do_reset
c01776a0 ide_init_drive_cmd
c01776bc ide_do_drive_cmd
c01763ac ide_end_drive_cmd
c0175df8 ide_end_request
c01777dc ide_revalidate_disk
c0176948 ide_cmd
c0178aa8 ide_wait_cmd
c0178b50 ide_wait_cmd_task
c0178b88 ide_delay_50ms
c0176f30 ide_stall_queue
c017c758 ide_add_proc_entries
c017c7ac ide_remove_proc_entries
c017c4e0 proc_ide_read_geometry
c017c94c create_proc_ide_interfaces
c0178440 ide_add_setting
c017855c ide_remove_setting
c0178264 ide_register_hw
c01783e0 ide_register
c0177ccc ide_unregister
c0178200 ide_setup_ports
c0177bbc hwif_unregister
c017763c get_info_ptr
c0175ebc current_capacity
c0178ba0 system_bus_clock
c0179c7c ide_auto_reduce_xfer
c0179d84 ide_driveid_update
c0179f14 ide_ata66_check
c0179f74 set_transfer
c0179fb4 eighty_ninty_three
c0179ff0 ide_config_drive_speed
c017ff48 pci_read_config_byte
c017ff70 pci_read_config_word
c017ffa8 pci_read_config_dword
c017ffdc pci_write_config_byte
c0180008 pci_write_config_word
c018004c pci_write_config_dword
c01f6ac8 pci_devices
c01f6ac0 pci_root_buses
c017fd18 pci_enable_device
c017fa4c pci_find_capability
c017fa1c pci_find_class
c017fa00 pci_find_device
c017f950 pci_find_slot
c017f990 pci_find_subsys
c0180084 pci_set_master
c017fb7c pci_set_power_state
c0180984 pci_assign_resource
c017fe6c pci_register_driver
c017fecc pci_unregister_driver
c017ff18 pci_dev_driver
c017fda0 pci_match_device
c017fb08 pci_find_parent_resource
c0180670 pcibios_present
c0180734 pcibios_read_config_byte
c0180770 pcibios_read_config_word
c01807ac pcibios_read_config_dword
c01807e8 pcibios_write_config_byte
c0180830 pcibios_write_config_word
c0180878 pcibios_write_config_dword
c0180684 pcibios_find_class
c01806dc pcibios_find_device
c02538c4 isa_dma_bridge_buggy
c02538c0 pci_pci_problems
c018bfac register_8022_client
c018c010 unregister_8022_client
c018c140 register_snap_client
c018c1b4 unregister_snap_client
c01850b0 skb_over_panic
c01850f8 skb_under_panic
c0183eb8 sock_register
c0183efc sock_unregister
c0184b10 __lock_sock
c0184bac __release_sock
c01859a8 memcpy_fromiovec
c0185954 memcpy_tokerneliovec
c0182fa8 sock_create
c0182864 sock_alloc
c018291c sock_release
c0184030 sock_setsockopt
c0184418 sock_getsockopt
c018296c sock_sendmsg
c01829f4 sock_recvmsg
c0184750 sk_alloc
c01847a8 sk_free
c0182f38 sock_wake_async
c0184a00 sock_alloc_send_skb
c0184f80 sock_init_data
c0184d58 sock_no_release
c0184d5c sock_no_bind
c0184d64 sock_no_connect
c0184d6c sock_no_socketpair
c0184d74 sock_no_accept
c0184d7c sock_no_getname
c0184d84 sock_no_poll
c0184d88 sock_no_ioctl
c0184d90 sock_no_listen
c0184d98 sock_no_shutdown
c0184da8 sock_no_getsockopt
c0184da0 sock_no_setsockopt
c0184e18 sock_no_sendmsg
c0184e20 sock_no_recvmsg
c0184e28 sock_no_mmap
c0184818 sock_rfree
c01847e8 sock_wfree
c0184828 sock_wmalloc
c0184878 sock_rmalloc
c0185dc0 skb_recv_datagram
c0185e84 skb_free_datagram
c0185ea4 skb_copy_datagram
c0185ed8 skb_copy_datagram_iovec
c0185628 skb_copy_expand
c0185ef8 datagram_poll
c0186240 put_cmsg
c01848c4 sock_kmalloc
c0184900 sock_kfree_s
c0189ee4 neigh_table_init
c0189fd8 neigh_table_clear
c0189a1c neigh_resolve_output
c0189b74 neigh_connected_output
c0189530 neigh_update
c0188c00 neigh_create
c0188b98 neigh_lookup
c01893cc __neigh_event_send
c0189838 neigh_event_ns
c0188944 neigh_ifdown
c018a67c neigh_sysctl_register
c0188d48 pneigh_lookup
c0189d0c pneigh_enqueue
c0188f7c neigh_destroy
c0189de0 neigh_parms_alloc
c0189e7c neigh_parms_release
c01887d8 neigh_rand_reach_time
c01899b0 neigh_compat_output
c0188540 dst_alloc
c01885bc __dst_free
c0188640 dst_destroy
c018b2d0 net_ratelimit
c018b2a0 net_random
c018b2c0 net_srandom
c0186078 __scm_destroy
c01860b0 __scm_send
c0186520 scm_fp_dup
c01ecd60 files_stat
c01857b4 memcpy_toiovec
c01b4b6c csum_partial
c0184c74 sklist_destroy_socket
c0184c44 sklist_insert_socket
c018630c scm_detach_fds
c01f8834 inetdev_lock
c018fe80 inet_add_protocol
c018fedc inet_del_protocol
c018edc8 ip_route_output_key
c018e65c ip_route_input
c01a8e60 icmp_send
c01a8cd4 icmp_reply
c019149c ip_options_compile
c0191a28 ip_options_undo
c01a7cf8 arp_send
c01f8380 arp_broken_ops
c018d26c __ip_select_ident
c0193288 ip_send_check
c0192ddc ip_fragment
c01f8d80 inet_family_ops
c018c900 in_aton
c01ac344 ip_mc_inc_group
c01ac42c ip_mc_dec_group
c01932d0 ip_finish_output
c01f8d40 inet_dgram_ops
c01934b4 ip_cmsg_recv
c01acd34 inet_addr_type
c01aa5c0 inet_select_addr
c01acca4 ip_dev_find
c01a9bd0 inetdev_by_index
c01a9618 in_dev_finish_destroy
c0190c2c ip_defrag
c01ad008 ip_rt_ioctl
c01a9eec devinet_ioctl
c01aa664 register_inetaddr_notifier
c01aa678 unregister_inetaddr_notifier
c0253ba0 ip_statistics
c01b2ae0 netlink_set_err
c01b2938 netlink_broadcast
c01b26c0 netlink_unicast
c01b2eac netlink_kernel_create
c01b30c4 netlink_dump_start
c01b319c netlink_ack
c018a874 rtattr_parse
c02539e0 rtnetlink_links
c018a8fc __rta_fill
c018ad44 rtnetlink_dump_ifinfo
c018a9bc rtnetlink_put_metrics
c0254414 rtnl
c018a070 neigh_delete
c018a180 neigh_add
c018a5f0 neigh_dump_info
c01875d0 dev_set_allmulti
c018756c dev_set_promiscuity
c0184bf8 sklist_remove_socket
c01f7660 rtnl_sem
c018a830 rtnl_lock
c018a844 rtnl_unlock
c0253984 ipv4_config
c01869b8 dev_open
c018c8d0 in_ntoa
c019019c ip_rcv
c01a7ef8 arp_rcv
c01f83a0 arp_tbl
c01a7b38 arp_find
c01738bc tr_setup
c018b7fc tr_type_trans
c01738c0 register_trdev
c01738ec unregister_trdev
c017389c init_trdev
c0186ac8 register_netdevice_notifier
c0186adc unregister_netdevice_notifier
c0173644 init_etherdev
c01f6480 loopback_dev
c0187ccc register_netdevice
c0187ef8 unregister_netdevice
c01737a4 register_netdev
c0173824 unregister_netdev
c0186918 netdev_state_change
c01736c8 ether_setup
c0187c94 dev_new_index
c01867d0 dev_get_by_index
c01867b0 __dev_get_by_index
c0186780 dev_get_by_name
c018673c __dev_get_by_name
c0187e58 netdev_finish_unregister
c01874b8 netdev_set_master
c018b4a8 eth_type_trans
c0185140 alloc_skb
c0185324 __kfree_skb
c0185418 skb_clone
c0185580 skb_copy
c0186d3c netif_rx
c0186570 dev_add_pack
c01865bc dev_remove_pack
c0186798 dev_get
c01868b4 dev_alloc
c0186864 dev_alloc_name
c018c390 __netdev_watchdog_up
c0186940 dev_load
c0187a2c dev_ioctl
c0186ba8 dev_queue_xmit
c01f65b0 dev_base
c01f65b4 dev_base_lock
c0186a5c dev_close
c01881c8 dev_mc_add
c0188110 dev_mc_delete
c01880f4 dev_mc_upload
c0162580 n_tty_ioctl
c015d3bc tty_register_ldisc
c013b6d8 __kill_fasync
c01f7168 if_port_text
c01f6ee0 sysctl_wmem_max
c01f6ee4 sysctl_rmem_max
c01f7fa0 sysctl_ip_default_ttl
c018c6f4 qdisc_destroy
c018c6dc qdisc_reset
c018c200 qdisc_restart
c018c62c qdisc_create_dflt
c01f79a0 noop_qdisc
c01f7940 qdisc_tree_lock
c0187138 register_gifconf
c0186f1c net_call_rx_atomic
c022c6e0 softnet_data
c01b5bf4 memparse
c01b5b60 get_option
c01b5bac get_options

7.7.3: last part of strace of an hanging ls
lstat64("/mnt/floppy/", {st_mode=S_IFDIR|0755, st_size=1024, ...}) = 0
   open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
open("/mnt/floppy/", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=1024, ...}) = 0
shmat(3, 0x80585f8, 0x2ptrace: umoven: Input/output error)= ?
brk(0x805b000)= 0x805b000 
ipc_subcall(0x3, 0x8058640, 0x1000, 0
# Hangs here
