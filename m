Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCLHRy>; Mon, 12 Mar 2001 02:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRCLHRo>; Mon, 12 Mar 2001 02:17:44 -0500
Received: from isc4.tn.cornell.edu ([128.84.242.21]:21391 "EHLO
	isc4.tn.cornell.edu") by vger.kernel.org with ESMTP
	id <S129393AbRCLHRh>; Mon, 12 Mar 2001 02:17:37 -0500
Date: Mon, 12 Mar 2001 02:16:31 -0500 (EST)
From: "Donald J. Barry" <don@astro.cornell.edu>
Message-Id: <200103120716.CAA24465@isc4.tn.cornell.edu>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd problem: Guaranteed Oops on my "pathological file system" (a monster ext2)

System: Athlon tbird 1100 MHz 
	GA 79X motherboard (with the notorious VIA kt133 chipset) 
        this problem with a very minimal 2.4.2 install except with
        Pavlich's v4.3 via82cxxx.c driver (same problem with 2.4.2
        stock driver), also same problems problems also seen with
        RedHat's rawhide 2.4.2-0.1.25 (and 0.1.19)
        
I had corruption problems before, slowly knocked away by upgrading
mb bios to current and using less aggressive disk parameters.  Now
running: 
/dev/hda: (and hdb and hde, my 3 drives)
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 7473/255/63, sectors = 120064896, start = 0

(and I just reproduced the oops even with DMA entirely off on these three
drives).

My "pathological file system" is a three physical partition lvm volume,
nonstriped, just a simple concretion, containing an e2fs 180G volume.  
But some of the directories have many thousands of files (ugh) of 
considerable length (40-60 characters, in many cases).

Just doing a "du -s *" in the top level will create the oops, quite
reliably.  Sometimes fscking the system after a reboot will oops it also.

It's a new system and has been a royal pain in the three days I've had it.

More problems with the vaunted VIA chips? (the AmiBios isn't terribly
configurable but I've got all the parameters set at their conservative
end -- this is for a spacecraft data server in our lab here, and I'd
sort of like the thing to be stable -- not an auspicious beginning so far.

Cheers,  Don Barry, 
SIRTF/IRS Science Team,
Cornell Astronomy
(please cc to don@astro.cornell.edu any messages to the list)

----ksymoops follows

ksymoops 2.3.4 on i686 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __blk_get_queue_R__ver___blk_get_queue not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_cleanup_queue_R__ver_blk_cleanup_queue not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_get_queue_R__ver_blk_get_queue not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_init_queue_R__ver_blk_init_queue not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_queue_headactive_R__ver_blk_queue_headactive not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_queue_make_request_R__ver_blk_queue_make_request not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blk_queue_pluggable_R__ver_blk_queue_pluggable not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol blkdev_release_request_R__ver_blkdev_release_request not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol end_that_request_first_R__ver_end_that_request_first not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol end_that_request_last_R__ver_end_that_request_last not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol generic_make_request_R__ver_generic_make_request not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol generic_unplug_device_R__ver_generic_unplug_device not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol io_request_lock_R__ver_io_request_lock not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol queued_sectors_R__ver_queued_sectors not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 003dde2f
c014196b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014196b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: cffd9188   ebx: 003dde0f   ecx: 0000000e   edx: 006d0225
esi: 003dde0f   edi: 00000000   ebp: cffd9188   esp: ce419eb8
ds: 0018   es: 0018   ss: 0018
Process du (pid: 902, stackpage=ce419000)
Stack: 006d0225 00000000 006d0225 ce885c00 c0141d87 ce885c00 006d0225 cffd9188 
       00000000 00000000 006d0225 c7024340 c70b6300 c70b635c cffd9188 c01506cb 
       ce885c00 006d0225 00000000 00000000 fffffff4 c7024340 c70b6300 c70af5c8 
Call Trace: [<c0141d87>] [<c01506cb>] [<c01385d3>] [<c0138d57>] [<c013833b>] [<c013938c>] [<c0136236>] 
       [<c012dfd3>] [<c0108f47>] 
Code: 39 53 20 75 24 8b 54 24 14 39 93 8c 00 00 00 75 18 85 ff 74 

>>EIP; c014196b <find_inode+1b/60>   <=====
Trace; c0141d87 <iget4+47/e0>
Trace; c01506cb <ext2_lookup+5b/90>
Trace; c01385d3 <real_lookup+53/c0>
Trace; c0138d57 <path_walk+5b7/820>
Trace; c013833b <getname+5b/a0>
Trace; c013938c <__user_walk+3c/60>
Trace; c0136236 <sys_lstat64+16/70>
Trace; c012dfd3 <sys_close+43/60>
Trace; c0108f47 <system_call+33/38>
Code;  c014196b <find_inode+1b/60>
00000000 <_EIP>:
Code;  c014196b <find_inode+1b/60>   <=====
   0:   39 53 20                  cmp    %edx,0x20(%ebx)   <=====
Code;  c014196e <find_inode+1e/60>
   3:   75 24                     jne    29 <_EIP+0x29> c0141994 <find_inode+44/60>
Code;  c0141970 <find_inode+20/60>
   5:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  c0141974 <find_inode+24/60>
   9:   39 93 8c 00 00 00         cmp    %edx,0x8c(%ebx)
Code;  c014197a <find_inode+2a/60>
   f:   75 18                     jne    29 <_EIP+0x29> c0141994 <find_inode+44/60>
Code;  c014197c <find_inode+2c/60>
  11:   85 ff                     test   %edi,%edi
Code;  c014197e <find_inode+2e/60>
  13:   74 00                     je     15 <_EIP+0x15> c0141980 <find_inode+30/60>


15 warnings issued.  Results may not be reliable.
