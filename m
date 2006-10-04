Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWJDAfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWJDAfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWJDAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:35:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:57835 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161019AbWJDAfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:35:15 -0400
Subject: Re: FSX on NFS blew up.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20061003164905.GD23492@redhat.com>
References: <20061003164905.GD23492@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 17:34:44 -0700
Message-Id: <1159922084.9569.24.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 12:49 -0400, Dave Jones wrote:
> Took ~8hrs to hit this on an NFSv3 mount. (2.6.18+Jan Kara's jbd patch)
> 
> http://www.codemonkey.org.uk/junk/fsx-nfs.txt
> 
> 	Dave
> 

I was seeing *similar* problem on NFS mounted filesystem (while running
fsx), but later realized that filesystem is full - when it happend.

Could be fsx error handling problem ? Can you check yours ?

Thanks,
Badari

#df 
...
/dev/sdc              17504036  17504036         0 100% /mnt1
9.47.xx.xx:/mnt1      17504256  17504256         0 100% /mnt3


I get fsx sigsegvs:

fsx-linux[4514] general protection rip:2ae1d90df690 rsp:7fffd1b57b08 error:0
fsx-linux[4513] general protection rip:2b6ee6048690 rsp:7fffc4becba8 error:0
fsx-linux[4515] general protection rip:2ac5964f0690 rsp:7fff147446f8 error:0
fsx-linux[5586] general protection rip:2b001c974690 rsp:7fff8e2c0278 error:0
fsx-linux[5587] general protection rip:2af03e546690 rsp:7fff6c6ee6a8 error:0
fsx-linux[5588] general protection rip:2ad9ca19c690 rsp:7fffe0a99ec8 error:0
fsx-linux[5585] general protection rip:2b4da569c690 rsp:7fff0559a588 error:0
fsx-linux[5921] general protection rip:2ac4d7346690 rsp:7fffd38f0b38 error:0
fsx-linux[5923] general protection rip:2b942d139690 rsp:7fff7dafd2b8 error:0
fsx-linux[5924] general protection rip:2b14e07cf690 rsp:7fffca465738 error:0
fsx-linux[5922] general protection rip:2af16b457690 rsp:7fff3f7de498 error:0
fsx-linux[5932] general protection rip:2b4b2b6ba690 rsp:7fff7f57c5b8 error:0
fsx-linux[5933] general protection rip:2b1d69ffd690 rsp:7fff40c37c68 error:0
fsx-linux[5934] general protection rip:2b06721f7690 rsp:7fff38a3da78 error:0
fsx-linux[5935] general protection rip:2ba2b5be8690 rsp:7ffff504e088 error:0

truncating to largest ever: 0x13e76
truncating to largest ever: 0x13e76
truncating to largest ever: 0x13e76
truncating to largest ever: 0x13e76
short read: 0xa8c2 bytes instead of 0xf0c4
LOG DUMP (3 total operations):
1(1 mod 256): TRUNCATE UP       from 0x0 to 0x13e76
2(2 mod 256): WRITE     0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
3(3 mod 256): READ      0xc73e thru 0x1b801     (0xf0c4 bytes)
Correct content saved for comparison
(maybe hexdump "/mnt3/foo1" vs "/mnt3/foo1.fsxgood")
short read: 0xa8c2 bytes instead of 0xf0c4
LOG DUMP (3 total operations):
1(1 mod 256): TRUNCATE UP       from 0x0 to 0x13e76
2(2 mod 256): WRITE     0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
3(3 mod 256): READ      0xc73e thru 0x1b801     (0xf0c4 bytes)
short read: 0xa8c2 bytes instead of 0xf0c4
LOG DUMP (3 total operations):
1(1 mod 256): TRUNCATE UP       from 0x0 to 0x13e76
2(2 mod 256): WRITE     0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
3(3 mod 256): READ      0xc73e thru 0x1b801     (0xf0c4 bytes)
Correct content saved for comparison
(maybe hexdump "/mnt3//foo2" vs "/mnt3//foo2.fsxgood")
Correct content saved for comparison
(maybe hexdump "/mnt3//foo3" vs "/mnt3//foo3.fsxgood")
short read: 0xa8c2 bytes instead of 0xf0c4
LOG DUMP (3 total operations):
1(1 mod 256): TRUNCATE UP       from 0x0 to 0x13e76
2(2 mod 256): WRITE     0x17098 thru 0x26857    (0xf7c0 bytes) HOLE
3(3 mod 256): READ      0xc73e thru 0x1b801     (0xf0c4 bytes)
Correct content saved for comparison
(maybe hexdump "/mnt3//foo4" vs "/mnt3//foo4.fsxgood")



