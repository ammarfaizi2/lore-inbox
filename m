Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbULVJa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbULVJa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 04:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbULVJa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 04:30:56 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261951AbULVJaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 04:30:23 -0500
Message-ID: <41C93E93.5070704@mtg-marinetechnik.de>
Date: Wed, 22 Dec 2004 10:29:55 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>	 <89245775041217090726eb2751@mail.gmail.com>	 <41C31421.7090102@mtg-marinetechnik.de>	 <8924577504121710054331bb54@mail.gmail.com>	 <8924577504121712527144a5cf@mail.gmail.com>	 <41C6E2E1.8030801@mtg-marinetechnik.de>	 <8924577504122009126c40c1fe@mail.gmail.com>	 <41C713EF.8050003@mtg-marinetechnik.de>	 <892457750412201231461415a1@mail.gmail.com>	 <41C7F204.3030503@mtg-marinetechnik.de> <89245775041221080238187402@mail.gmail.com>
In-Reply-To: <89245775041221080238187402@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon, thanks for the last patch, it applied without errors or warnings.
But the NIC is still hanging.
Here the last hang data. Do you need the "Tx timed out" lines? I 
apparently didn't wait long enough for this timeout to trigger ...
Is it a 5 min timeout?


Dec 22 10:00:37 urutu kernel: eth0: HostError! IntStatus 0082. 216 59 
248001a0 7c2
Dec 22 10:02:24 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 22 10:02:55 urutu last message repeated 7 times
Dec 22 10:03:52 urutu last message repeated 3 times
Dec 22 10:04:14 urutu kernel: nfs: server jupiter not responding, still 
trying
Dec 22 10:06:07 urutu syslogd 1.4.1: restart.



The folks at SuSE corrected several bugs in a new kernel just released, 
some of them are IP related. Is something related to the problem you are 
seeing?

1) problem description, brief discussion

     Linux kernel

         Several vulnerabilities have been found and fixed in the Linux
         kernel.


         Paul Starzetz reported that the missing serialization in
         unix_dgram_recvmsg() which was added to kernel 2.4.28 can
         be used by a local attacker to gain elevated privileges (root
         access). This issue is tracked by the Mitre CVE ID CAN-2004-1068.

         Paul Starzetz and Georgi Guninski reported independently that bad
         argument handling and bad integer arithmetics in the IPv4 sendmsg
         handling of control messages could lead to a local attacker 
crashing
         the machine.
         This problem was fixed by Herbert Xu and is tracked by the Mitre
         CVE ID CAN-2004-1016.

         Georgi Guninski reported a memory leak in the IP option handling
         of the IPv4 sendmsg call.

         Paul Starzetz found bad handling in the kernel IGMP code, which
         could lead to a local attacker being able to crash the machine.
         This problem was fixed by Chris Wright and is tracked by the Mitre
         CVE ID CAN-2004-1137.

         Olaf Kirch found and fixed a problem in the RPC handling in the
         kernel of SUSE Linux 9.1, 9.2, and SUSE Linux Enterprise Server 9
         which could lead to a remote attacker crashing the machine.

         A local denial of service problem in the aio_free_ring system call
         could allow a local attacker to crash the machine.

         A problem in the memory management handling of ELF executables 
could
         lead to a local attacker crashing the machine with a handcrafted
         ELF binary. (This is a VMA overlap problem and not related to
         earlier ELF problems.)

         A buffer overflow in the system call handling in the 32bit system
         call emulation on AMD64 / Intel EM64T systems was fixed. It is not
         thought to be exploitable.

         A memory leak in the ip_conntrack_ftp firewalling module was fixed
         in the 2.6 kernels.

         Various UML security issues in the SUSE Linux 9.2 UML setup
         were fixed.


         Additionally some non-security bugs were fixed in the released
         kernels:

	SUSE Linux Enterprise Server 8 and SUSE Linux 8.1:
	- A memory leak in addition / removal of SCSI target devices was
           fixed.

         - A race condition in SCSI I/O accounting which could lead to
           erroneous reports on SCSI disk I/O was fixed.

         - S390: Patches from IBM have been installed in the S/390
           architecture, both for 32 and 64bit.
           Refer to the maintenance information mail for the full change 
log.

	- The "memfrac" and "lower_zone_reserve" kernel parameters had
           no effect since they were used before kernel command line 
parsing.

         - PowerPC: Missing synchronization that could lead to processes
           hanging in signal delivery was added.


	SUSE Linux Enterprise Server 9 and SUSE Linux 9.1:
         - A vfree() was called with interrupts disabled in the SCSI generic
           device handling, which could lead to a hanging machine.

         - A race condition between a file unlink and umount could lead to a
           machine crash.

         - Fixed a small memory leak in bio_copy_user().

         - cdrecord -scanbus could crash the kernel when using the 
"gdth" SCSI
           driver.

         - Allow reading from zero page (/dev/zero) using O_DIRECT/rawio.

         - Fixed some LSB issues in the fcntl compatibility handling.

         - The st (SCSI tape) driver did not pass on generic SCSI ioctl
           commands to the SCSI mid layer.


         SUSE Linux 9.2:
         - The kernel installation routines did not call depmod for the 
modules
           in the -nongpl RPMs, so they could not be loaded.
           This lead to non working USB modem drivers and similar.
           This problem was fixed.

         - A Problem with mounting iPods over FireWire was fixed.

         - A data corruption problem in the megaraid driver was fixed.

         - A pageattr overflow condition in the memory subsystem
           and missing TLB flush if multiple pages were passed were fixed.

         - Allow reading from zeropage with O_DIRECT/rawio.

         - Do not restart the system on ACPI events after power down.
           (Make it no longer start on opening the lid of just shutdown
            laptops for instance.)

         - New memory imbalance handling handling by Andrea leading
           to better Out Of Memory (OOM) handling was added.




-- 
Richard Ems
Tel: +49 40 65803 312
Fax: +49 40 65803 392
Richard.Ems@mtg-marinetechnik.de

MTG Marinetechnik GmbH - Wandsbeker Königstr. 62 - D 22041 Hamburg

GF Dipl.-Ing. Ullrich Keil
Handelsregister: Abt. B Nr. 11 500 - Amtsgericht Hamburg Abt. 66
USt.-IdNr.: DE 1186 70571

