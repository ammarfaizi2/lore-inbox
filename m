Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130389AbQLIXRA>; Sat, 9 Dec 2000 18:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131805AbQLIXQv>; Sat, 9 Dec 2000 18:16:51 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:47763 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S130389AbQLIXQj>; Sat, 9 Dec 2000 18:16:39 -0500
Date: Sat, 9 Dec 2000 23:46:09 +0100
From: Dick Streefland <Dick.Streefland@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.0-test12-pre7] kernel BUG at buffer.c:827!
Message-ID: <20001209234609.A29924@two.de.bilt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message showed up when running lilo on an ext2 image, mounted via
a loopback mount. Line 827 in fs/buffer.c is a call to UnlockPage().
The complete message from /var/log/messages:

Dec  9 18:24:51 tampere kernel: kernel BUG at buffer.c:827! 
Dec  9 18:24:51 tampere kernel: invalid operand: 0000 
Dec  9 18:24:51 tampere kernel: CPU:    0 
Dec  9 18:24:51 tampere kernel: EIP:    0010:[end_buffer_io_async+195/240] 
Dec  9 18:24:51 tampere kernel: EFLAGS: 00010086 
Dec  9 18:24:51 tampere kernel: eax: 0000001c   ebx: c00142bc   ecx: 00000000   edx: 00000006 
Dec  9 18:24:51 tampere kernel: esi: c0597c20   edi: 00000002   ebp: c0597c68   esp: c0499da0 
Dec  9 18:24:51 tampere kernel: ds: 0018   es: 0018   ss: 0018 
Dec  9 18:24:51 tampere kernel: Process lilo (pid: 3676, stackpage=c0499000) 
Dec  9 18:24:51 tampere kernel: Stack: c0230d89 c023105a 0000033b c0597c20 c0089620 00000002 00000001 c018b115  
Dec  9 18:24:51 tampere kernel:        c0597c20 00000001 c0089620 c0088260 c0089620 c0089620 c018c1c1 c0089620  
Dec  9 18:24:51 tampere kernel:        00000001 c024710b c0089620 00000007 c0089620 c02b99d8 00000000 00000700  
Dec  9 18:24:52 tampere kernel: Call Trace: [tvecs+12861/115968] [tvecs+13582/115968] [end_that_request_first+101/192] [do_lo_request+993/1072] [tvecs+103871/115968] [__make_request+1597/1712] [generic_make_request+188/288]  
Dec  9 18:24:52 tampere kernel:        [ll_rw_block+371/496] [block_read_full_page+541/656] [ext2_readpage+15/32] [ext2_get_block+0/1344] [do_generic_file_read+931/1504] [generic_file_read+99/128] [file_read_actor+0/112] [sys_read+142/208]  
Dec  9 18:24:52 tampere kernel:        [system_call+51/64]  
Dec  9 18:24:52 tampere kernel: Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00  

I cannot reproduce it reliably, but after a few retries, it occured again.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@inter.nl.net      (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
