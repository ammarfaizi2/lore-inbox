Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278282AbRJMMoi>; Sat, 13 Oct 2001 08:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278283AbRJMMo1>; Sat, 13 Oct 2001 08:44:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:17683 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278282AbRJMMoW>;
	Sat, 13 Oct 2001 08:44:22 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Corrupt ext2/ext3 directory entries not recovered by e2fsck
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sat, 13 Oct 2001 22:44:34 +1000
Message-ID: <17469.1002977074@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64, gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-95).  Various
kernels from 2.4.9 (with ext3) through 2.4.13-pre1 (with XFS).

The filesystem was created as ext3 but is currently being accessed as
ext2 while I work on XFS and kdb for IA64.  After multiple power rests,
several directory entries are corrupt.  Attempts to access the files
get I/O error with nothing in the log.  Running e2fsck does not correct
the broken directory entry, neither does booting a kernel that supports
ext3.

I am surprised that neither ext3 recovery nor e2fsck detected the
broken directory entries.  Before I clri the directory entry, does
anybody want more details?

debugfs:  ls -l /var/run                                                                                                                      
686849  40755      0      0    4096 13-Oct-2001 21:41 .                                                                                       
179873  40755      0      0    4096 25-Sep-2001 11:39 ..                                                                                      
507431  40775      0      0    4096 27-Jul-2001 07:32 netreport                                                                               
686888 100664      0     22    4800 13-Oct-2001 21:45 utmp                                                                                    
376417  40755     75     75    4096  9-Jul-2001 21:40 radvd                                                                                   
654934  40700      0      0    4096 24-Jul-2001 02:52 sudo                                                                                    
686995 100644      0      0      11 13-Oct-2001 21:41 runlevel.dir                                                                            
687119 100600      0      0       4 13-Oct-2001 21:41 syslogd.pid                                                                             
687120 100600      0      0       4 13-Oct-2001 21:41 klogd.pid                                                                               
688413 100644      0      0       4 13-Oct-2001 21:41 sshd.pid                                                                                
688414 100644      0      0       4 13-Oct-2001 21:41 xinetd.pid                                                                              
2133571369 --- error ---  sendmail.pid                                                                                                        
2133571369 --- error ---  crond.pid                                                                                                           
2133571369 --- error ---  xfs.pid                                                                                                             
2133571369 --- error ---  atd.pid                

Dump of the directory.

0000  01 7B 0A 00  0C 00 01 02  2E 00 00 00  A1 BE 02 00  * .{..........¡... *
0010  0C 00 02 02  2E 2E 00 00  27 BE 07 00  14 00 09 02  * ........'....... *
0020  6E 65 74 72  65 70 6F 72  74 00 00 00  28 7B 0A 00  * netreport...({.. *
0030  0C 00 04 01  75 74 6D 70  61 BE 05 00  10 00 05 02  * ....utmpa....... *
0040  72 61 64 76  64 00 00 00  56 FE 09 00  0C 00 04 02  * radvd...V....... *
0050  73 75 64 6F  93 7B 0A 00  14 00 0C 01  72 75 6E 6C  * sudo.{......runl *
0060  65 76 65 6C  2E 64 69 72  0F 7C 0A 00  14 00 0B 01  * evel.dir.|...... *
0070  73 79 73 6C  6F 67 64 2E  70 69 64 00  10 7C 0A 00  * syslogd.pid..|.. *
0080  14 00 09 01  6B 6C 6F 67  64 2E 70 69  64 00 00 00  * ....klogd.pid... *
0090  1D 81 0A 00  10 00 08 01  73 73 68 64  2E 70 69 64  * ........sshd.pid *
00a0  1E 81 0A 00  14 00 0A 01  78 69 6E 65  74 64 2E 70  * ........xinetd.p *
00b0  69 64 00 00  00 00 00 00  14 00 0C 01  73 65 6E 64  * id..........send *
00c0  6D 61 69 6C  2E 70 69 64  00 00 00 00  14 00 09 01  * mail.pid........ *
00d0  63 72 6F 6E  64 2E 70 69  64 00 00 00  00 00 00 00  * crond.pid....... *
00e0  10 00 07 01  78 66 73 2E  70 69 64 00  00 00 00 00  * ....xfs.pid..... *
00f0  14 0F 07 01  61 74 64 2E  70 69 64 00  00 00 00 00  * ....atd.pid..... *
0100  04 0F 0C 01  73 68 75 74  64 6F 77 6E  2E 70 69 64  * ....shutdown.pid *
0110  00 00 00 00  00 00 00 00  00 00 00 00  00 00 00 00  * ................ *

