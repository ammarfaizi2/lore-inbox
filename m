Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129324AbQK3EsR>; Wed, 29 Nov 2000 23:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129761AbQK3Er6>; Wed, 29 Nov 2000 23:47:58 -0500
Received: from ace.ulyssis.student.kuleuven.ac.be ([193.190.253.36]:29970 "EHLO
        ace.ulyssis.org") by vger.kernel.org with ESMTP id <S129324AbQK3Erx>;
        Wed, 29 Nov 2000 23:47:53 -0500
Date: Thu, 30 Nov 2000 05:17:25 +0100 (CET)
From: Steven Van Acker <deepstar@ulyssis.org>
To: linux-kernel@vger.kernel.org
Subject: ext2 directory size bug (?)
Message-ID: <Pine.LNX.4.21.0011300453200.31229-100000@ace.ulyssis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It this is a known thing, please don't kill me...
Hmm, gonna try to follow the REPORTING-BUGS file here...

[1.] One line summary of the problem:

     directory size increases when adding 0-size files, 
     but doesn't decrease when removing them.

[2.] Full description of the problem/report:

     when creating lots of 0-size files, the size of directory . 
     increases but when you delete those files, the directory size 
     doesn't decrease. the diskspace can only be freed when the 
     directory in question is removed. I know it's a stupid 
     bug/feature to report, but imagine someone creating lots of 
     files in /tmp.  on some systems I know, /tmp is a small partition,
     which would get filled up by that diskspace, and can only be 
     removed by removing /tmp
     
[3.] Keywords (i.e., modules, networking, kernel):

     ext2 directory dir size

[4.] Kernel version (from /proc/version):

     Linux version 2.2.17 (root@warp) (gcc version 2.95.2 20000220 
     (Debian GNU/Linux)) #1 Thu Nov 30 06:16:39 CET 2000

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

     No Oops message
     
[6.] A small shell script or example program which triggers the
     problem (if possible)

     #!/bin/bash
     
     cd /tmp;
     ls -ld .;
     for i in `seq 1 3000`; do touch AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA$i; done
     ls -ld .;
     rm AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA* ;
     ls -ld .;
          
[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

     Linux warp 2.2.17 #1 Thu Nov 30 06:16:39 CET 2000 i686 unknown
     Kernel modules         2.3.19
     Gnu C                  2.95.2
     Binutils               2.10.91
     Linux C Library        2.1.95
     Dynamic linker         ldd (GNU libc) 2.1.95
     Procps                 2.0.6
     Mount                  2.10o
     Net-tools              2.05
     Console-tools          0.2.3
     Sh-utils               2.0i
     Modules Loaded         au8820
     
[7.2.] Processor information (from /proc/cpuinfo):

     processor       : 0
     vendor_id       : GenuineIntel
     cpu family      : 6
     model           : 6
     model name      : Celeron (Mendocino)
     stepping        : 5
     cpu MHz         : 434.325
     cache size      : 128 KB
     fdiv_bug        : no
     hlt_bug         : no
     sep_bug         : no
     f00f_bug        : no
     coma_bug        : no
     fpu             : yes
     fpu_exception   : yes
     cpuid level     : 2
     wp              : yes
     flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
     bogomips        : 865.08
     
[7.3.] Module information (from /proc/modules):

     au8820                111120   3

[7.4.] SCSI information (from /proc/scsi/scsi)

     none

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

     my /tmp is on an ext2 partition

[X.] Other notes, patches, fixes, workarounds:

     I wish, but I have 0 kernel programming experience

--
"An ounce of prevention is worth a pound of purge."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
