Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSIDXay>; Wed, 4 Sep 2002 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSIDXay>; Wed, 4 Sep 2002 19:30:54 -0400
Received: from [195.223.140.120] ([195.223.140.120]:6177 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316434AbSIDXal>; Wed, 4 Sep 2002 19:30:41 -0400
Date: Thu, 5 Sep 2002 01:35:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20pre5aa1
Message-ID: <20020904233528.GA1238@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AIO now seems to work fine and it's in complete sync with the 2.5 kernel
API:

rm -f testdir/rofile
echo "test" >testdir/rofile
chmod 400 testdir/rofile
rm -f testdir/rwfile
echo "test" >testdir/rwfile
chmod 600 testdir/rwfile
rm -f testdir/wofile
echo "test" >testdir/wofile
chmod 200 testdir/wofile
rm -f testdir.ext2/rwfile
echo "test" >testdir.ext2/rwfile
chmod 600 testdir.ext2/rwfile
./runtests.sh cases/2.p cases/3.p cases/4.p cases/5.p cases/6.p cases/7.p cases/8.p cases/10.p cases/11.p cases/12.p cases/13.p
Test run starting at Wed Sep 4 05:02:02 GMT 2002
Starting cases/2.p
expect -14: io_setup(-1000, 0xc0010000) = -14 [Bad address]
expect -14: io_setup( 1000, 0xc0010000) = -14 [Bad address]
expect -14: io_setup(    0, 0xc0010000) = -14 [Bad address]
expect -22: io_setup(-1000, 0xbfffde28) = -22 [Invalid argument]
expect -22: io_setup(   -1, 0xbfffde28) = -22 [Invalid argument]
expect -22: io_setup(    0, 0xbfffde28) = -22 [Invalid argument]
expect   0: io_setup(    1, 0xbfffde28) =   0 [Success]
expect -22: io_setup(    1, 0xbfffde28) = -22 [Invalid argument]
test cases/2.t completed PASSED.
Completed cases/2.p with 0.
Starting cases/3.p
expect -22: io_submit(0xffffffff,   1, 0xbfffdd14) = -22 [Invalid argument]
expect   0: io_submit(0x40017000,   0, 0xbfffdd14) =   0 [Success]
expect -14: io_submit(0x40017000,   1,      (nil)) = -14 [Bad address]
expect -14: io_submit(0x40017000,   1, 0xffffffff) = -14 [Bad address]
expect -14: io_submit(0x40017000,   2, 0xbfffdd0c) = -14 [Bad address]
expect -14: io_submit(0x40017000,   2, 0xbfffdd04) = -14 [Bad address]
expect -22: io_submit(0x40017000,  -1, 0xbfffdd14) = -22 [Invalid argument]
test cases/3.t completed PASSED.
Completed cases/3.p with 0.
Starting cases/4.p
expect  -9: (w), res = sync_submit: io_submit res=-9 [Bad file descriptor]
 -9 [Bad file descriptor]
expect  -9: (r), res = sync_submit: io_submit res=-9 [Bad file descriptor]
 -9 [Bad file descriptor]
expect 512: (w), res = 512 [Success]
expect 512: (r), res = 512 [Success]
expect -22: (r), res = -22 [Invalid argument]
expect -22: (w), res = -22 [Invalid argument]
expect   0: (r), res =   0 [Success]
expect   4: (w), res =   4 [Success]
expect   4: (w), res =   4 [Success]
expect   8: (r), res =   8 [Success]
read after append: [12345678]
expect -14: (r), res = sync_submit: io_submit res=-14 [Bad address]
-14 [Bad address]
expect -14: (w), res = sync_submit: io_submit res=-14 [Bad address]
-14 [Bad address]
expect -14: (w), res = -14 [Bad address]
test cases/4.t completed PASSED.
Completed cases/4.p with 0.
Starting cases/5.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   512: (w), res =   512 [Success]
expect   -14: (r), res =   -14 [Bad address]
expect   512: (r), res =   512 [Success]
expect   -14: (w), res =   -14 [Bad address]
test cases/5.t completed PASSED.
Completed cases/5.p with 0.
Starting cases/6.p
size = 1031628
expect 524288000: (w), res = 524288000 [Success]
expect 524288000: (r), res = 524288000 [Success]
test cases/6.t completed PASSED.
Completed cases/6.p with 0.
Starting cases/7.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   511: (w), res =   511 [Success]
expect   511: (r), res =   511 [Success]
expect   -27: (w), res =   -27 [File too large]
expect     0: (r), res =     0 [Success]
expect     0: (w), res =     0 [Success]
test cases/7.t completed PASSED.
Completed cases/7.p with 0.
Starting cases/8.p
expect   512: (w), res =   512 [Success]
expect   512: (r), res =   512 [Success]
expect   511: (w), res =   511 [Success]
expect   511: (r), res =   511 [Success]
expect   -27: (w), res =   -27 [File too large]
expect     0: (r), res =     0 [Success]
expect     0: (w), res =     0 [Success]
test cases/8.t completed PASSED.
Completed cases/8.p with 0.
Starting cases/10.p
expect 103407616: (w), res = 103407616 [Success]
expect 103407616: (r), res = 103407616 [Success]
expect   -28: (w), res =   -28 [No space left on device]
expect     0: (r), res =     0 [Success]
expect 103407615: (w), res = 103407615 [Success]
expect 103407615: (r), res = 103407615 [Success]
expect     0: (r), res =     0 [Success]
expect   -28: (w), res =   -28 [No space left on device]
expect     0: (r), res =     0 [Success]
expect     0: (w), res =     0 [Success]
test cases/10.t completed PASSED.
Completed cases/10.p with 0.
Starting cases/11.p
completed 1000000 out of 1000000 writes
completed 1000000 out of 1000000 reads
test cases/11.t completed PASSED.
Completed cases/11.p with 0.
Starting cases/12.p
expect   0: io_submit(0x40017000,   0,      (nil)) =   0 [Success]
expect -22: io_submit(0x40017000,   0,      (nil)) = -22 [Invalid argument]
child exited with status 0
test cases/12.t completed PASSED.
Completed cases/12.p with 0.
Starting cases/13.p
expect   8: io_submit(0x40017000,   8, 0xbfffd67c) =   8 []
event[0]: write[0] okay, returned: 1048576 [Unknown error 4293918720]
event[1]: write[1] okay, returned: 1048576 [Unknown error 4293918720]
event[2]: write[2] okay, returned: 1048576 [Unknown error 4293918720]
event[3]: write[3] okay, returned: 1048576 [Unknown error 4293918720]
event[4]: write[4] okay, returned: 1048576 [Unknown error 4293918720]
event[5]: write[5] okay, returned: 1048576 [Unknown error 4293918720]
event[6]: write[6] okay, returned: 1048576 [Unknown error 4293918720]
event[7]: write[7] okay, returned: 1048576 [Unknown error 4293918720]
test cases/13.t completed PASSED.
Completed cases/13.p with 0.
Pass: 11  Fail: 0
^^^^^^^^^^^^^^^^^
Test run complete at Wed Sep 4 05:03:20 GMT 2002

The 2.5 libaio that works with this kernel and 2.5 is here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/libaio/libaio-0.3.15-2.5.tar.gz

This libaio should work on all archs 32/64bit big/little endian (only
the syscall numbers are missing but a number of them aren't registered
yet, they can be easily added in the file syscall.h). The resulting
libaio binary will work with 2.5 kernels too. The API provided by the
above libaio is compatible with the libaio in the RHAS so Oracle for
RHAS should work fine on top of this kernel after installing the above
libaio.so.1 in /usr/lib/libaio.so.1 (it's still untested though).

Since nobody apparently knows the semantics of the io_queue_wait, such
call keeps doing nothing at the moment (and Oracle isn't using it so
it's not a problem). I reccomend nobody to use the io_queue_wait, and
I'd like to remove it in the long run unless somebody claims its
semantics.

Currently the kernel compiles only for x86 I guess, I will shortly
release a new -aa that hopefully will compile on some more
architectures, the changes needed should be very small.

One more thing, the make modules_install for some unknwon reasons
generates huge complains from depmod -ae at the end, just ignore them, I
don't know why these errors are showing up but the modules loads just
fine, so it has to be some kind of depmod of makefile mistake, but I'll
think about it after all archs compiles.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20pre5aa1.gz

Changelog diff between 2.4.19rc5aa1 and 2.4.20pre5aa1:

Only in 2.4.19rc5aa1: 000_e100-2.1.6.gz
Only in 2.4.19rc5aa1: 000_e1000-4.3.2.gz
Only in 2.4.19rc5aa1: 00_TCDRAIN-1
Only in 2.4.19rc5aa1: 00_blkdev-pagecache-alias-read_full_page-1
Only in 2.4.19rc5aa1: 00_block-highmem-all-19-1.gz
Only in 2.4.19rc5aa1: 00_dnotify-cleanup-2
Only in 2.4.19rc5aa1: 00_elevator-fixes-1
Only in 2.4.19rc5aa1: 00_ext3-0.9.18.gz
Only in 2.4.19rc5aa1: 00_ffs_compile_failure-1
Only in 2.4.19rc5aa1: 00_pci-dma_mask-1
Only in 2.4.19rc5aa1: 00_pre7ac3-p4-xeon-1
Only in 2.4.19rc5aa1: 00_set_64bit-atomic-1
Only in 2.4.19rc5aa1: 00_sock_fasync-memleak-1
Only in 2.4.19rc5aa1: 00_sr-scatter-pad-1
Only in 2.4.19rc5aa1: 00_stack-overflow-detection-1
Only in 2.4.19rc5aa1: 05_vm_00_touch-buffer-1
Only in 2.4.19rc5aa1: 05_vm_04_dump_stack-1
Only in 2.4.19rc5aa1: 05_vm_12_drain_cpu_caches-2
Only in 2.4.19rc5aa1: 05_vm_14_block_flushpage_check-2
Only in 2.4.19rc5aa1: 05_vm_19_nodev-cleanup-1
Only in 2.4.19rc5aa1: 10_pte-highmem-f00f-2
Only in 2.4.19rc5aa1: 20_kiobuf-slab-3
Only in 2.4.19rc5aa1: 30_x86_memfree-boot-cleanup-1
Only in 2.4.19rc5aa1: 30_x86_setup-boot-cleanup-5
Only in 2.4.19rc5aa1: 90_init-survive-threaded-race-5
Only in 2.4.19rc5aa1: 94_numaq-tsc-4

	Merged in mainline.

Only in 2.4.19rc5aa1: 00_3.5G-address-space-4
Only in 2.4.20pre5aa1: 00_3.5G-address-space-5
Only in 2.4.20pre5aa1: 00_cpu-affinity-syscall-rml-2
Only in 2.4.19rc5aa1: 00_cpu-affinity-syscall-rml-2.4.19-pre9-1
Only in 2.4.19rc5aa1: 00_extraversion-5
Only in 2.4.20pre5aa1: 00_extraversion-6
Only in 2.4.19rc5aa1: 00_net-softirq-1
Only in 2.4.20pre5aa1: 00_net-softirq-2
Only in 2.4.19rc5aa1: 00_ordered-freeing-1
Only in 2.4.20pre5aa1: 00_ordered-freeing-2
Only in 2.4.19rc5aa1: 00_spinlock-no-egcs-1
Only in 2.4.20pre5aa1: 00_spinlock-no-egcs-2
Only in 2.4.19rc5aa1: 00_vm-cleanups-1
Only in 2.4.20pre5aa1: 00_vm-cleanups-2
Only in 2.4.19rc5aa1: 00_x86-optimize-apic-irq-and-cacheline-1
Only in 2.4.20pre5aa1: 00_x86-optimize-apic-irq-and-cacheline-2
Only in 2.4.19rc5aa1: 05_vm_03_vm_tunables-2
Only in 2.4.20pre5aa1: 05_vm_03_vm_tunables-3
Only in 2.4.19rc5aa1: 05_vm_08_try_to_free_pages_nozone-2
Only in 2.4.20pre5aa1: 05_vm_08_try_to_free_pages_nozone-3
Only in 2.4.19rc5aa1: 05_vm_09_misc_junk-2
Only in 2.4.20pre5aa1: 05_vm_09_misc_junk-3
Only in 2.4.19rc5aa1: 05_vm_17_rest-8
Only in 2.4.20pre5aa1: 05_vm_17_rest-9
Only in 2.4.19rc5aa1: 10_lvm-snapshot-check-2
Only in 2.4.20pre5aa1: 10_lvm-snapshot-check-3
Only in 2.4.19rc5aa1: 10_rawio-vary-io-11
Only in 2.4.20pre5aa1: 10_rawio-vary-io-12
Only in 2.4.19rc5aa1: 10_sched-o1-hyperthreading-2
Only in 2.4.20pre5aa1: 10_sched-o1-hyperthreading-3
Only in 2.4.19rc5aa1: 20_pte-highmem-26
Only in 2.4.20pre5aa1: 20_pte-highmem-27.gz
Only in 2.4.19rc5aa1: 30_irq-balance-12
Only in 2.4.20pre5aa1: 30_irq-balance-13
Only in 2.4.19rc5aa1: 60_tux-syscall-3
Only in 2.4.20pre5aa1: 60_tux-syscall-4
Only in 2.4.19rc5aa1: 70_xfs-1.1-5.gz
Only in 2.4.20pre5aa1: 70_xfs-1.1-6.gz
Only in 2.4.19rc5aa1: 80_x86_64-common-code-5
Only in 2.4.20pre5aa1: 80_x86_64-common-code-6
Only in 2.4.19rc5aa1: 90_buddyinfo-3
Only in 2.4.20pre5aa1: 90_buddyinfo-4
Only in 2.4.19rc5aa1: 90_proc-mapped-base-2
Only in 2.4.20pre5aa1: 90_proc-mapped-base-3
Only in 2.4.19rc5aa1: 90_s390-aa-2
Only in 2.4.20pre5aa1: 90_s390-aa-3
Only in 2.4.19rc5aa1: 90_s390x-aa-1
Only in 2.4.20pre5aa1: 90_s390x-aa-2
Only in 2.4.19rc5aa1: 93_NUMAQ-4
Only in 2.4.20pre5aa1: 93_NUMAQ-5
Only in 2.4.19rc5aa1: 94_discontigmem-meminfo-2
Only in 2.4.20pre5aa1: 94_discontigmem-meminfo-3
Only in 2.4.19rc5aa1: 96_inode_read_write-atomic-3
Only in 2.4.20pre5aa1: 96_inode_read_write-atomic-4
Only in 2.4.19rc5aa1: 9900_aio-2.gz
Only in 2.4.20pre5aa1: 9900_aio-4.gz
Only in 2.4.19rc5aa1: 9900_aio-API-x86-2
Only in 2.4.20pre5aa1: 9901_aio-API-x86-3

	Rediffed.

Only in 2.4.20pre5aa1: 00_bdflush-docs-1

	Updated the docs, from Christian Zoz.

Only in 2.4.20pre5aa1: 00_conntrack-hash-1

	Fix the hashfn to avoid wasting cpu, from Martin Wilck.

Only in 2.4.20pre5aa1: 00_e100-compile-1

	Fix compilation problem in e100 mainline.

Only in 2.4.20pre5aa1: 00_invlpg-386-1

	Be in function of 386 rather than in function of global
	page feature (as suggested by Linus).

Only in 2.4.19rc5aa1: 00_lowlatency-fixes-6
Only in 2.4.20pre5aa1: 00_lowlatency-fixes-8

	Converted to cond_resched in mainline.

Only in 2.4.20pre5aa1: 00_max-mp-busses-1

	Enlarge the number of busses to avoid random mem corruption
	on some new machines (most important: add check to avoid
	random mem corruption very hard to debug in the future).

Only in 2.4.19rc5aa1: 00_nfs-bkl-3
Only in 2.4.19rc5aa1: 00_nfs-rpc-ping-2
Only in 2.4.19rc5aa1: 00_nfs-seekdir-1
Only in 2.4.19rc5aa1: 00_nfs-svc_tcp-2
Only in 2.4.19rc5aa1: 10_nfs-o_direct-5
Only in 2.4.19rc5aa1: 10_o1-sched-nfs-1
Only in 2.4.20pre5aa1: 30_01_nfs-call-start-1
Only in 2.4.20pre5aa1: 30_02_call-reserve1-1
Only in 2.4.20pre5aa1: 30_03_call-reserve2-1
Only in 2.4.20pre5aa1: 30_04_noac-1
Only in 2.4.20pre5aa1: 30_05_seekdir-1
Only in 2.4.20pre5aa1: 30_06_cto2-1
Only in 2.4.20pre5aa1: 30_07_access-1
Only in 2.4.20pre5aa1: 30_08_rdplus-1
Only in 2.4.20pre5aa1: 30_09_o_direct-1
Only in 2.4.20pre5aa1: 30_10-lockd1-1
Only in 2.4.20pre5aa1: 30_11-lockd2-1
Only in 2.4.20pre5aa1: 30_12-lockd3-1
Only in 2.4.20pre5aa1: 30_13-lockd4-1

	Merge latest nfs client code from Trond.

Only in 2.4.20pre5aa1: 00_o_direct-b_page-null-1

	Let get_block understand it was a O_DIRECT asking for the
	block using bh.b_page = NULL (reiserfs will use it).

Only in 2.4.19rc5aa1: 00_o_direct-blkdev-1
Only in 2.4.20pre5aa1: 00_o_direct-blkdev-2

	Fix mem corruption bug that can trigger with initrd because
	initrd has no softblock blocksize entry in the array of
	the ramdisk major (the array has only 16 entries in function
	of the compile time number of ramdisks, initrd is at the end).

Only in 2.4.20pre5aa1: 00_prepare-write-fixes-3-1

	Also check the i_size is in sync with the last block we allocated in
	the metadata, it won't be updated in the commit_write if prepare_write
	is failing.

Only in 2.4.19rc5aa1: 00_rwsem-fair-30
Only in 2.4.19rc5aa1: 00_rwsem-fair-30-recursive-8
Only in 2.4.20pre5aa1: 00_rwsem-fair-31
Only in 2.4.20pre5aa1: 00_rwsem-fair-31-recursive-8

	Add the trylock operations with the same semantics of mainline.

Only in 2.4.19rc5aa1: 00_sched-O1-aa-2.4.19rc3-1.gz
Only in 2.4.20pre5aa1: 00_sched-O1-aa-2.4.19rc3-2.gz

	Merge sched_yield from Ingo with the same semantics of 2.4,
	to fix pthreads slowdowns.

Only in 2.4.20pre5aa1: 00_usagi-ipv6-1

	Avoid to bind to ipv4 too.

Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-30.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-31.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-34.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-36.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-40
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-41.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-43.gz
Only in 2.4.19rc5aa1: 50_uml-patch-2.4.18-47.gz
Only in 2.4.20pre5aa1: 50_uml-patch-2.4.19-1.gz
Only in 2.4.20pre5aa1: 51_uml-ac-to-aa-10
Only in 2.4.19rc5aa1: 51_uml-ac-to-aa-9
Only in 2.4.19rc5aa1: 52_uml-blockdev-1
Only in 2.4.19rc5aa1: 53_uml-page-struct-updates-1
Only in 2.4.19rc5aa1: 55_uml-page_address-3
Only in 2.4.19rc5aa1: 56_uml-pte-highmem-2
Only in 2.4.20pre5aa1: 56_uml-pte-highmem-3
Only in 2.4.19rc5aa1: 58_uml-hostfs-compile-1
Only in 2.4.19rc5aa1: 59_uml-compat-2.5-2
Only in 2.4.20pre5aa1: 59_uml-compat-2.5-3
Only in 2.4.19rc5aa1: 59_uml-yield-2

	UML updates from Jeff.

Only in 2.4.19rc5aa1: 81_x86_64-arch-2.4.19rc1-1.gz
Only in 2.4.19rc5aa1: 82_x86_64-suse-2
Only in 2.4.20pre5aa1: 82_x86_64-suse-3
Only in 2.4.19rc5aa1: 83_x86_64-cvs-020716-1
Only in 2.4.19rc5aa1: 84_x86-64-mtrr-compile-1
Only in 2.4.19rc5aa1: 87_x86_64-o1sched-1
Only in 2.4.20pre5aa1: 87_x86_64-o1sched-2

	Go in sync with mainline.

Only in 2.4.20pre5aa1: 9920_kgdb-1.gz

	kgdb from akpm.

Only in 2.4.20pre5aa1: 9930_io_request_scale-3
Only in 2.4.20pre5aa1: 9931_io_request_scale-drivers-1

	Avoid global io_request_lock scalability for a number
	of scsi drivers.

Only in 2.4.20pre5aa1: 9940_ocfs-1.gz

	Oracle Cluster Filesystem, developement release.

Only in 2.4.20pre5aa1: 9950_futex-1.gz

	Futex locking available to userspace.

Andrea
