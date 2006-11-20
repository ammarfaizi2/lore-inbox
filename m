Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966210AbWKTRDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966210AbWKTRDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966207AbWKTRDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:03:13 -0500
Received: from 41.19.177.216.mht.nh.inaddr.G4.net ([216.177.19.41]:48133 "EHLO
	mail.resara.com") by vger.kernel.org with ESMTP id S966190AbWKTRDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:03:12 -0500
Subject: lock held at task exit time
From: Brendan Powers <brendan@resara.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-vxtyaR1+GWRh8yaMMMO6"
Date: Mon, 20 Nov 2006 12:01:05 -0500
Message-Id: <1164042065.11790.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vxtyaR1+GWRh8yaMMMO6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


Hello, i have a machine that locks up occasionally when trying to
unmount a cifs mount. The program unmounting it uses the umount2 syscall
to do the unmounting. 

I got these messages along with the stack trace in syslog
kernel: note: umount.special[18370] exited with preempt_count 1
kernel: BUG: umount.special/18370, lock held at task exit time!

Does this mean there is a bug in the kernel, or am i doing something
wrong in the umount.special process?

Attached is the full crash log and the source to umount.special

You will need to CC me when replying.

Info:
Machine i386/Xeon
Kernel versions: 2.6.17.11, and 2.6.16.7
Distro: Debian Sarge(3.1)

Any help would be appreciated. 


--=-vxtyaR1+GWRh8yaMMMO6
Content-Disposition: attachment; filename=error_log
Content-Type: text/plain; name=error_log; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>From syslog
Nov 17 07:55:38 resara1 kernel: f8d675c5
Nov 17 07:55:38 resara1 kernel: Modules linked in: nls_cp437 cifs smbfs ipv6 nfsd exportfs lockd nfs_acl sunrpc af_packet binfmt_misc autofs4 generic piix ide_generic ext3 jbd mbcache i2c_i801 i2c_core lp joydev parport_pc parport pcspkr rtc shpchp pciehp pci_hotplug tsdev mousedev evdev psmouse sd_mod e1000 ide_cd cdrom ide_disk floppy usb_storage ide_core vga16fb vgastate usbserial usbhid usbkbd ehci_hcd uhci_hcd usbcore thermal processor fan 3w_xxxx ata_piix libata scsi_mod unix
Nov 17 07:55:38 resara1 kernel: EIP:    0060:[pg0+949675461/1069831168]    Not tainted VLI
Nov 17 07:55:38 resara1 kernel: EFLAGS: 00010206   (2.6.17.11.resara-opteron #1)
Nov 17 07:55:38 resara1 kernel:  BUG: warning at kernel/exit.c:855/do_exit()
Nov 17 07:55:38 resara1 kernel:  <c012296c> do_exit+0x46c/0x480  <c0104567> die+0x227/0x230
Nov 17 07:55:38 resara1 kernel:  <c0115ebe> do_page_fault+0x2de/0x70c  <c02bca62> __reacquire_kernel_lock+0x42/0x60
Nov 17 07:55:38 resara1 kernel:  <c02ba235> schedule+0x3f5/0x750  <c0129218> try_to_del_timer_sync+0x58/0x70
Nov 17 07:55:38 resara1 kernel:  <c0115be0> do_page_fault+0x0/0x70c  <c0103c6f> error_code+0x4f/0x54
Nov 17 07:55:38 resara1 kernel:  <f8d675c5> sesInfoFree+0x25/0xb0 [cifs]  <f8d5e993> cifs_umount+0x53/0x1f0 [cifs]
Nov 17 07:55:38 resara1 kernel:  <f8d4e182> cifs_put_super+0x32/0xb0 [cifs]  <c016af89> generic_shutdown_super+0x139/0x150
Nov 17 07:55:38 resara1 kernel:  <c016b8a6> kill_anon_super+0x16/0x50  <c016ad6c> deactivate_super+0x6c/0xb0
Nov 17 07:55:38 resara1 kernel:  <c018315f> sys_umount+0x3f/0x90  <c01030d3> syscall_call+0x7/0xb
Nov 17 07:55:38 resara1 kernel: note: umount.special[18370] exited with preempt_count 1
Nov 17 07:55:38 resara1 kernel: BUG: umount.special/18370, lock held at task exit time!
Nov 17 07:55:38 resara1 kernel:  [eb4b7e50] {alloc_super}
Nov 17 07:55:38 resara1 kernel: .. held by:    umount.special:18370 [ea347030, 117]
Nov 17 07:55:38 resara1 kernel: ... acquired at:               generic_shutdown_super+0x5f/0x150
Nov 17 07:55:50 resara1 kernel:  <c0140c59> softlockup_tick+0xa9/0xd0  <c01295ec> update_process_times+0x3c/0x90
Nov 17 07:55:50 resara1 kernel:  <c011161f> smp_apic_timer_interrupt+0x5f/0x70  <c02bc6e4> _write_lock+0x64/0x90
Nov 17 07:55:50 resara1 kernel:  <c0103ba4> apic_timer_interrupt+0x1c/0x24  <c02bc6e4> _write_lock+0x64/0x90
Nov 17 07:55:50 resara1 kernel:  <f8d60d9d> cifs_close+0xdd/0x220 [cifs]  <c0164e8f> __fput+0x13f/0x160
Nov 17 07:55:50 resara1 kernel:  <c01633cd> filp_close+0x4d/0x80  <c0163470> sys_close+0x70/0xa0
Nov 17 07:55:50 resara1 kernel:  <c01030d3> syscall_call+0x7/0xb
Nov 17 07:55:51 resara1 kernel:  <c0140c59> softlockup_tick+0xa9/0xd0  <c01295ec> update_process_times+0x3c/0x90
Nov 17 07:55:51 resara1 kernel:  <c011161f> smp_apic_timer_interrupt+0x5f/0x70  <c02bc6e2> _write_lock+0x62/0x90
Nov 17 07:55:51 resara1 kernel:  <c0103ba4> apic_timer_interrupt+0x1c/0x24  <c02bc6e2> _write_lock+0x62/0x90
Nov 17 07:55:51 resara1 kernel:  <f8d60d9d> cifs_close+0xdd/0x220 [cifs]  <c0164e8f> __fput+0x13f/0x160
Nov 17 07:55:51 resara1 kernel:  <c01633cd> filp_close+0x4d/0x80  <c0163470> sys_close+0x70/0xa0
Nov 17 07:55:51 resara1 kernel:  <c01030d3> syscall_call+0x7/0xb



Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: Oops: 0002 [#1]

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: PREEMPT SMP

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:        eb4b7e50 c016af89 eb4b7e00 dfa504c0 00000011 f8d88260 bf96be90 c016b8a6

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: Stack: 00335bdc 00335bdc f8d5e993 ef8f3ec0 e8df0b80 00000000 e9107f08 e9107f08

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: EIP is at sesInfoFree+0x25/0xb0 [cifs]

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: eax: 00000002   ebx: ef8f3ec0   ecx: 00000001   edx: 00000018

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: esi: fffffffb   edi: cad383c0   ebp: ef8f3ec0   esp: e9107ed4

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: CPU:    3

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: Process umount.special (pid: 18370, threadinfo=e9106000 task=ea347030)

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:        cad383c0 eb4b7e00 f8d88200 e9106000 f8d4e182 eb4b7e00 cad383c0 eb4b7e00

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:  <f8d5e993> cifs_umount+0x53/0x1f0 [cifs]  <f8d4e182> cifs_put_super+0x32/0xb0 [cifs]

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:  <c016ad6c> deactivate_super+0x6c/0xb0  <c018315f> sys_umount+0x3f/0x90

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:  <c01030d3> syscall_call+0x7/0xb

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: Code: 8d b6 00 00 00 00 83 ec 08 89 5c 24 04 8b 5c 24 0c 85 db 74 71 b8 d8 90 d8 f8 e8 c7 50 55 c7 f0 ff 0d 1c 91 d8 f8 8b 53 04 8b 03 <89> 50 04 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 b8 d8 90

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel:  <c016af89> generic_shutdown_super+0x139/0x150  <c016b8a6> kill_anon_super+0x16/0x50

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: Call Trace:

Message from syslogd@resara1 at Fri Nov 17 07:55:38 2006 ...
resara1 kernel: EIP: [pg0+949675461/1069831168] sesInfoFree+0x25/0xb0 [cifs] SS:ESP 0068:e9107ed4
--=-vxtyaR1+GWRh8yaMMMO6
Content-Disposition: attachment; filename=main.cpp
Content-Type: text/x-c++src; name=main.cpp; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <sys/mount.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
extern int errno;


int main(int argc, char* argv[])
{
	if(argc != 2)
	{
		printf("usage: umount.special <mountpoint>\n");
		return(1);
	}

	if(strstr(argv[1],getenv("HOME")) == NULL)
	{
		printf("You cannot umount filesystems outside your home directory\n");
		return(2);
	}

	int retval = umount2(argv[1],2);
	if(retval != 0)
	{
		printf("%s\n",strerror(errno));
	}
	return(retval);
}

--=-vxtyaR1+GWRh8yaMMMO6--

