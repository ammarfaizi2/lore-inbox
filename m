Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbREVH6t>; Tue, 22 May 2001 03:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262589AbREVH6k>; Tue, 22 May 2001 03:58:40 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262594AbREVH6Z>;
	Tue, 22 May 2001 03:58:25 -0400
Date: Mon, 21 May 2001 17:11:08 -0300
From: Carlos Laviola <claviola@ajato.com.br>
To: linux-kernel@vger.kernel.org
Subject: Weird bug in kernel (invalid operand?)
Message-Id: <20010521171108.2fe854ab.claviola@ajato.com.br>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was getting the file ias9i_linux.tar from
http://xxx:yyy@download-east.oracle.com/otn/linux/ias/9ias/ias9i_linux.tar
(username and password masked to protect the innocent) and decided to take
a peek at the contents of that (huge) file, using "tar xfv ias9i_linux.tar".
After a few moments, wget segfaulted. I tried to continue the download, using
wget -c yada yada yada, and it locks up, becoming an unkillable process (i.e.
I had to reboot to get rid of the thing). I could reproduce this with another
downloader, who gave me this error:

setting resume on existing file `ias9i_linux.tar' at 1087947248 bytes
http://xxx:yyy@download-east.oracle.com/otn/linux/ias/9ias/ias9i_linux.tar (1233930K)
ias9i_linux.tar           [####################    ] 1062448K |  255.89K/sinvalid operand: 0000
CPU:    0
EIP:    0010:[<c48fb709>]
EFLAGS: 00010282
eax: 00000019   ebx: 00000000   ecx: c1272000   edx: c3f7bc20
esi: 00206c60   edi: c3ca5240   ebp: c0695aa0   esp: c1273e68
ds: 0018   es: 0018   ss: 0018
Process snarf (pid: 324, stackpage=c1273000)
Stack: c48fe965 c48fea27 00000045 000001f0 00000200 00040d8c c1273ec0 c012cf56
       c3ca5240 00206c60 c0695aa0 00000001 000001f0 c1273f64 00040d8c 000002e5
       c0605000 c0695aa0 00000200 00206c60 00000000 c0695aa0 0000004b 0000004b
Call Trace: [<c48fe965>] [<c48fea27>] [<c012cf56>] [<c012d553>] [<c48fb6ac>] [<c48fcf1c>] [<c48fb6ac>]
       [<c012179a>] [<c48fb7d2>] [<c48fb7b0>] [<c012ac5a>] [<c0106a63>]

Code: 0f 0b 83 c4 0c b8 fb ff ff ff eb 6d 8b 87 8c 00 00 00 0f b7
Segmentation fault

This seems to be a bug in the kernel, maybe because the file is too big,
and VFAT partitions don't like that. I don't have any other operating
systems here I can test this on, but I could try installing FreeBSD or
downgrading the kernel to 2.2.19 (I'm running 2.4.4) to attempt to trigger
this bug again. But, I'd like to ask some knowledgeable person to take a
look at that error above to tell me what the hell is going on. I get a
similar error when I strace wget (since this one doesn't give any weird
errors, just locks up).

Please Cc: to me, I'm not subscribed to this list atm.

Thank you,
Carlos.

-- 
 _ _  _| _  _  | _   . _ | _  carlos.debian.net   Debian-BR Project
(_(_|| |(_)_)  |(_|\/|(_)|(_| uin#: 981913 (icq)  debian-br.sf.net

Linux: the choice of a GNU generation - Registered Linux User #103594
Traveller: God has been mighty good to your fields, Mr. Farmer.      
Farmer: You should have seen how he treated them when I wasn't       
around.                                                              
