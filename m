Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293186AbSCOUEK>; Fri, 15 Mar 2002 15:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293184AbSCOUEB>; Fri, 15 Mar 2002 15:04:01 -0500
Received: from usfw01.photomask.com ([198.6.73.7]:27582 "EHLO
	yellow.photomask.com") by vger.kernel.org with ESMTP
	id <S293186AbSCOUDu> convert rfc822-to-8bit; Fri, 15 Mar 2002 15:03:50 -0500
From: John Helms <john.helms@photomask.com>
Date: Fri, 15 Mar 2002 20:07:31 GMT
Message-ID: <20020315.20073100@linux.local>
Subject: Re: bug (trouble?) report on high mem support
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Jim.Trice@photomask.com (Trice Jim),
        Martin.Bligh@us.ibm.com
In-Reply-To: <E16lxxL-0004WN-00@the-village.bc.nu>
In-Reply-To: <E16lxxL-0004WN-00@the-village.bc.nu>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,


Here is a top output.  We have 16Gb of ram.
I have also tried a 2.4.9-31 enterprise 
kernel rpm from RedHat with the same 
results.



  1:57pm  up 20 min,  2 users,  load average: 1.01, 0.88, 0.47
71 processes: 69 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU1 states:  0.1% user,  1.1% system,  0.0% nice, 98.2% idle
CPU2 states:  0.4% user, 99.1% system,  0.0% nice,  0.0% idle
CPU3 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
Mem:  15904836K av,  788196K used, 15116640K free,     400K shrd,   
14848K buff
Swap: 16096164K av,       0K used, 16096164K free                  
574956K cached
 
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1410 helmsjw   15   0  105M 105M  1072 R    99.9  0.6   7:37 WRITEFILE
 1411 root      11   0   992  992   780 R     1.7  0.0   0:09 top
    1 root       8   0   520  520   452 S     0.0  0.0   0:04 init
    2 root       8   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU0
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU1
    5 root      19  19     0    0     0 SWN   0.0  0.0   0:00 
ksoftirqd_CPU2




Below is the readprofile output per a recommendation
of Martin Bligh, who I have cc'd:


[root@rrux02 sbin]# ./readprofile
     4 _stext                                     0.0625
464584 cpu_idle                                 4148.0714
     1 machine_real_restart                       0.0052
     2 __switch_to                                0.0078
    13 restore_all                                0.5652
     1 v86_signal_return                          0.0625
     1 error_code                                 0.0156
     1 device_not_available_emulate               0.0625
     1 show_trace                                 0.0057
     6 disable_irq                                0.0469
     1 sys_modify_ldt                             0.0104
     6 do_cyrix_devid                             0.0417
     2 do_read                                    0.0042
     3 do_poll                                    0.0312
    39 do_ioctl                                   0.0938
     2 do_release                                 0.0083
     1 __wake_up_sync                             0.0039
    67 sys_sched_rr_get_interval                  0.2792
     8 show_task                                  0.0200
     1 add_wait_queue                             0.0208
    21 copy_files                                 0.0298
    24 do_fork                                    0.0133
     4 printk                                     0.0119
     4 register_console                           0.0100
     1 inter_module_unregister                    0.0057
     2 sys_init_module                            0.0013
     2 sys_delete_module                          0.0033
     1 sys_query_module                           0.0026
     2 sys_setitimer                              0.0089
     1 sys_sysinfo                                0.0033
     1 find_resource                              0.0052
     1 do_sysctl                                  0.0063
     3 do_proc_dointvec                           0.0036
    15 sysctl_string                              0.0493
     2 sysctl_jiffies                             0.0083
    16 check_free_space                           0.0357
     2 sys_acct                                   0.0043
     1 do_sigpending                              0.0069
     1 sys_rt_sigtimedwait                        0.0013
     1 sys_setgid                                 0.0057
     1 in_group_p                                 0.0208
     1 sys_newuname                               0.0078
     2 __pmd_alloc                                0.0625
     2 pte_alloc                                  0.0063
     6 unlock_vma_mappings                        0.1250
     8 sys_brk                                    0.0357
 54729 do_mmap_pgoff                             51.8267
     4 get_unmapped_area                          0.0132
     1 exit_mmap                                  0.0035
     1 __insert_vm_struct                         0.0026
     3 insert_vm_struct                           0.0375
    41 merge_anon_vmas                            0.1971
     4 attempt_merge_next                         0.0312
     1 add_page_to_hash_queue                     0.0208
    43 truncate_inode_pages                       0.2240
     2 __find_page_simple                         0.0250
    11 writeout_one_page                          0.1375
    11 waitfor_one_page                           0.1375
    12 do_buffer_fdatasync                        0.0577
    23 generic_buffer_fdatasync                   0.1307
     1 filemap_fdatasync                          0.0035
     2 filemap_fdatawait                          0.0125
     2 add_to_page_cache_locked                   0.0104
     7 add_to_page_cache                          0.0337
     2 add_to_page_cache_unique                   0.0083
     1 read_cluster_nonblocking                   0.0030
     3 ___wait_on_page                            0.0156
     9 __lock_page                                0.0469
     1 lock_page                                  0.0208
     1 __find_get_page                            0.0057
     1 __find_get_swapcache_page                  0.0045
     9 __find_lock_page                           0.0268
     1 drop_behind                                0.0045
    33 generic_file_readahead                     0.0469
    32 do_generic_file_read                       0.0215
     1 file_read_actor                            0.0045
     7 file_send_actor                            0.0273
    11 sys_sendfile                               0.0215
     2 nopage_sequential_readahead                0.0066
     7 madvise_willneed                           0.0109
     1 madvise_vma                                0.0104
     1 sys_madvise                                0.0039
    34 mincore_page                               0.1635
    12 change_protection                          0.0259
     1 mprotect_fixup                             0.0012
     4 mlock_fixup                                0.0049
     2 do_mlock                                   0.0089
     5 move_page_tables                           0.0312
     1 refill_inactive_scan                       0.0033
     1 do_try_to_free_pages                       0.0104
    14 kswapd                                     0.0515
     5 wakeup_kswapd                              0.1042
     3 try_to_free_pages                          0.0469
     6 kreclaimd                                  0.0341
    18 rw_swap_page_base                          0.0450
     1 nr_free_highpages                          0.0208
     3 zone_inactive_shortage                     0.0469
     2 show_free_areas_core                       0.0069
    90 badness                                    0.4688
     2 select_bad_process                         0.0208
    30 shmem_recalc_inode                         0.3125
    15 shmem_swp_entry                            0.0938
    64 shmem_truncate                             0.1176
     8 shmem_unuse_inode                          0.0312
     2 shmem_writepage                            0.0074
    28 shmem_getpage_locked                       0.0292
     1 shmem_getpage                              0.0045
     2 shmem_file_write                           0.0022
     1 shmem_file_setup                           0.0033
     2 alloc_bounce_page                          0.0096
  1240 vfs_statfs                                 9.6875
     1 file_move                                  0.0156
     5 file_moveto                                0.0781
     1 fs_may_remount_ro                          0.0089
     1 end_buffer_io_sync                         0.0125
     4 write_unlocked_buffers                     0.0139
     1 wait_for_locked_buffers                    0.0057
    21 sync_buffers                               0.3281
     1 fsync_super                                0.0057
     1 fsync_dev                                  0.0089
     3 __block_write_full_page                    0.0054
     6 brw_kiovec                                 0.0083
    11 brw_page                                   0.0573
     1 detach_mnt                                 0.0125
     2 attach_mnt                                 0.0139
     3 move_vfsmnt                                0.0187
     2 __mntput                                   0.0208
     2 mangle                                     0.0125
     2 get_filesystem_info                        0.0019
     1 sys_ustat                                  0.0045
     1 get_unnamed_dev                            0.0208
     1 do_umount                                  0.0027
     1 mount_is_safe                              0.0208
     2 block_llseek                               0.0125
     1 get_write_access                           0.0156
     1 deny_write_access                          0.0125
     2 lookup_hash                                0.0104
     3 open_namei                                 0.0019
     1 sys_unlink                                 0.0039
     1 vfs_follow_link                            0.0026
     3 page_follow_link                           0.0065
     3 sys_dup2                                   0.0134
     5 do_fcntl                                   0.0073
     1 send_sigio_to_task                         0.0052
     1 sys_ioctl                                  0.0020
     2 vfs_readdir                                0.0096
     1 fillonedir                                 0.0057
     1 filldir64                                  0.0031
     1 do_select                                  0.0017
     1 fcntl_setlease                             0.0016
     1 dput                                       0.0028
     1 d_invalidate                               0.0069
     1 dget_locked                                0.0208
     1 d_prune_aliases                            0.0063
     1 prune_dcache                               0.0026
     1 have_submounts                             0.0078
     2 d_delete                                   0.0114
     1 __inode_dir_notify                         0.0057
     1 read_blk                                   0.0104
     4 find_free_dqentry                          0.0078
     4 do_insert_tree                             0.0086
     3 read_dquot                                 0.0085
     1 set_dqblk                                  0.0018
     1 set_info                                   0.0037
     2 dquot_initialize                           0.0043
     1 load_elf_interp                            0.0014
     1 remove_proc_entry                          0.0037
     1 minix_partition                            0.0037
   182 ext2_free_blocks                           0.1835
     2 ext2_new_block                             0.0007
     1 ext2_dotdot                                0.0208
     2 random_read                                0.0060
     4 vt_ioctl                                   0.0005
     2 vcs_write                                  0.0017
     1 receive_chars                              0.0023
     3 set_fdc                                    0.0170
     1 _lock_fdc                                  0.0030
     1 show_floppy                                0.0017
     2 start_motor                                0.0078
     1 wait_til_done                              0.0031
     2 format_interrupt                           0.0312
     1 setup_format_params                        0.0022
     5 rw_interrupt                               0.0063
     1 ide_spin_wait_hwgroup                      0.0078
     1 set_pio_mode                               0.0104
     3 ide_add_generic_settings                   0.0059
     1 ahc_linux_alloc_device                     0.0089
     2 ahc_linux_filter_command                   0.0027
     2 ahc_linux_queue_recovery_cmd               0.0007
     1 ahc_aha394XX_setup                         0.0125
     1 revalidate_scsidisk                        0.0024
     6 pci_find_capability                        0.0312
     1 pci_find_parent_resource                   0.0078
    12 pci_set_power_state                        0.0417
     3 pci_save_state                             0.0375
     1 pci_restore_state                          0.0078
     3 pci_compare_state                          0.0375
     1 pci_generic_resume_restore                 0.0312
     1 pci_generic_resume_compare                 0.0312
     2 pci_enable_device                          0.0417
     1 pci_disable_device                         0.0156
     4 pci_scan_slot                              0.0192
     1 pci_pm_suspend_device                      0.0208
     1 pci_pm_resume_device                       0.0312
     1 pci_pm_save_state_bus                      0.0104
     1 pci_pm_suspend_bus                         0.0104
    15 isapnp_alternative_switch                  0.0154
     1 isapnp_valid_port                          0.0031
     1 isapnp_check_interrupt                     0.0039
     2 isapnp_valid_irq                           0.0040
     1 isapnp_print_configuration                 0.0015
     1 isapnp_set_port                            0.0035
    12 fbcon_clear                                0.0300
     4 fbcon_putc                                 0.0192
     5 fbcon_cfb24_putcs                          0.0054
     3 write_disk_sb                              0.0067
     3 sync_sbs                                   0.0208
     1 set_disk_info                              0.0312
     9 get_geo                                    0.0703
     1 md_ioctl                                   0.0004
     3 md_thread                                  0.0069
     1 md_wakeup_thread                           0.0312
     5 md_register_thread                         0.0312
     2 md_error                                   0.0125
     1 status_unused                              0.0063
     4 status_resync                              0.0068
    10 md_status_read_proc                        0.0145
     2 sys_sendmsg                                0.0042
     1 dst_alloc                                  0.0069
     1 ip_queue_xmit                              0.0008
     1 ip_build_xmit_slow                         0.0008
     2 ip_build_xmit                              0.0022
     2 ip_fragment                                0.0023
     2 ip_icmp_error                              0.0060
     1 tcp_fastretrans_alert                      0.0008
     1 __tcp_select_window                        0.0042
   230 rtmsg_ifa                                  1.4375
    31 inet_forward_change                        0.2422
   669 devinet_sysctl_forward                     6.9688
     3 devinet_sysctl_register                    0.0104
     4 devinet_sysctl_unregister                  0.0833
     4 inet_sock_destruct                         0.0104
     3 inet_sock_release                          0.0170
     4 inet_create                                0.0066
    10 inet_bind                                  0.0152
     1 inet_wait_for_connect                      0.0022
     2 inet_stream_connect                        0.0032
   374 fib_netdev_event                           2.9219
523311 total                                      0.4193       
              

>>>>>>>>>>>>>>>>>> Original Message <<<<<<<<<<<<<<<<<<

On 3/15/02, 2:05:39 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote regarding 
Re: bug (trouble?) report on high mem support:


> > running under the 2.4.7-10 enterprise
> > kernel.  This same program runs fine
> > under the 2.4.7-10 smp kernel.  The main

> Firstly queue standard comment about 2.4.9 errata kernels and upgrading

> > difference is that in a top output, most
> > of the cpu time is in system mode and very
> > little user mode under the enterprise kernel,
> > and just the opposite under the smp kernel.

> When you are using large amounts of RAM things in the PC world get a bit
> messy. Is this a box with a lot of memory ?
