Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJTRXa>; Sat, 20 Oct 2001 13:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273836AbRJTRXV>; Sat, 20 Oct 2001 13:23:21 -0400
Received: from email.osc.edu ([192.148.249.4]:22989 "EHLO osc.edu")
	by vger.kernel.org with ESMTP id <S273831AbRJTRXI>;
	Sat, 20 Oct 2001 13:23:08 -0400
Date: Sat, 20 Oct 2001 13:20:54 -0400 (EDT)
From: Jan Labanowski <jkl@osc.edu>
To: linux-kernel@vger.kernel.org
cc: Jan Labanowski <jkl@osc.edu>
Subject: 2.4.12 SCSI_IOCTL_FC_TARGET_ADDRESS undeclared in ./drivers/scsi/cpqfcTSinit.c
Message-ID: <Pine.GSO.4.21.0110201318590.16747-100000@arlen.osc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
2.4.12: SCSI_IOCTL_FC_TARGET_ADDRESS undeclared in ./drivers/scsi/cpqfcTSinit.c

[2.] Full description of the problem/report:

When I run 
   make modules
I get:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.12/include/linux/modversions.h   -c -o cpqfcTSinit.o cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:663: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this
function)
cpqfcTSinit.c:663: (Each undeclared identifier is reported only once
cpqfcTSinit.c:663: for each function it appears in.)
cpqfcTSinit.c:681: `SCSI_IOCTL_FC_TDR' undeclared (first use in this function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2
======================================

I could not find any file which contains something similar to 
SCSI_IOCTL_FC_TARGET_ADDRESS, so I just simply cheated by doing
cd /usr/src/linux-2.4.12/drivers/scsi
mv cpqfcTSinit.c cpqfcTSinit.c.orig
# created empty file cpqfcTSinit.c
cat > cpqfcTSinit.c
^D
cd /usr/src/linux
make modules


[3.] Keywords (i.e., modules, networking, kernel): modules

[4.] Kernel version (from /proc/version): 
Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 19:37:14 EDT 2001

[5.] N/A

[6.] N/A

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here) 

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dhcp065-024-066-066.columbus.rr.com 2.4.2-2 #1 Sun Apr 8 19:37:14 EDT 2001 i586 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         sb sb_lib uart401 sound soundcore autofs eepro100 3c509 BusLogic sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo): 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 233.867
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 466.94

[7.3.] Module information (from /proc/modules): 
autofs                 11136   1 (autoclean)
eepro100               16688   1 (autoclean)
3c509                   7696   1 (autoclean)
BusLogic               87296   0 (unused)
sd_mod                 11808   0 (unused)
scsi_mod               94304   2 [BusLogic sd_mod]

[X.] Yes, I do point to right include files 
cd /usr/include
mv asm asm-2.4,2
mv linux linux-2.4.2
mv scsi scsi-2.4.2
ln -s /usr/src/linux-2.4/include/asm-i386 asm
ln -s /usr/src/linux-2.4/include/linux linux
ln -s /usr/src/linux-2.4/include/scsi scsifil

and my /usr/src/linux-2.4 and /usr/src/linux is
lrwxrwxrwx 1 root root 12 Oct 20 02:13 /usr/src/linux-2.4 -> lnux-2.4.12



Jan K. Labanowski            |    phone: 614-292-9279,  FAX: 614-292-7168
Ohio Supercomputer Center    |    Internet: jkl@osc.edu 
1224 Kinnear Rd,             |    http://www.ccl.net/chemistry.html
Columbus, OH 43212-1163      |    http://www.osc.edu/

