Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270419AbRHHIqZ>; Wed, 8 Aug 2001 04:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270420AbRHHIqP>; Wed, 8 Aug 2001 04:46:15 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:54162 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S270419AbRHHIqD> convert rfc822-to-8bit; Wed, 8 Aug 2001 04:46:03 -0400
Importance: Normal
Subject: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Cc: "Carsten Otte" <COTTE@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF5E574EE5.AF3B6F6F-ONC1256AA2.0026D8D3@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Wed, 8 Aug 2001 10:46:41 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/08/2001 10:46:03
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ext3-users,


I tested ext3 on a Linux for S/390 with several stress and benchmark test
tests and faced a kernel bug message.
The console showed the following output:

Message from syslogd@boeaet34 at Fri Aug  3 11:34:16 2001 ...
boeaet34 kernel: Assertion failure in journal_forget() at
transaction.c:1184: "!
jh->b_committed_data"

I tried the Patch from http://www.zip.com.au/~akpm/ext3-2.4-0.9.5-247.gz
with the kernel 2.4.7 with a new LVM- patch(0.9.1)  and some S/390 specific
patches. I use mke2fs version 1.22.
S/390 is a 32bit big endian machine. After compiling and running the kernel
I created an ext3-file system on an 70GB LVM. When running the postmark
test I get (reproduceable) the message from above. dmesg shows:

kernel BUG at transaction.c:1184!
illegal operation: 0001
CPU:    1
Process bench (pid: 2453, stackpage=08CEF000)

Kernel PSW:    07080000 8007f458         =journal_forget
task: 08cee000 ksp: 08cefaa8 pt_regs: 08cefa10
Kernel GPRS:
00000000  8001c118  00000022  00000001
8007f456  00c27000  00194f9a  00000001
030d2c80  074ed294  00001899  092ca350
0001f94c  8007f2c8  8007f456  08cefaa8
Kernel ACRS:
00000000  00000000  00000000  00000000
00000001  00000000  00000000  00000000
00000000  00000000  00000000  00000000
00000000  00000000  00000000  00000000
Kernel BackChain  CallChain
       08cefaa8   [<0007f456>]                =journal_forget
       08cefb10   [<000744c6>]                =ext3_forget
       08cefb70   [<000767b4>]                =ext3_clear_blocks
       08cefbd8   [<000768d4>]                =ext3_free_data
       08cefc50   [<00076c38>]                =ext3_truncate
       08cefd08   [<00074732>]                =ext3_delete_inode
       08cefd68   [<0006659a>]                =iput
       08cefdc8   [<00063dfc>]                =d_delete

I resolved the functions using the system.map file.

Has anyone saw this message before? Any ideas, clues, hints?

Please CC me , because I am not on the list.


--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


