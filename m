Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279858AbRKIMUM>; Fri, 9 Nov 2001 07:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279860AbRKIMUC>; Fri, 9 Nov 2001 07:20:02 -0500
Received: from albatross-ext.wise.edt.ericsson.se ([194.237.142.116]:11748
	"EHLO albatross-ext.wise.edt.ericsson.se") by vger.kernel.org
	with ESMTP id <S279858AbRKIMTu>; Fri, 9 Nov 2001 07:19:50 -0500
Message-ID: <3BEBC9F5.92D90C41@eed.ericsson.se>
Date: Fri, 09 Nov 2001 13:20:05 +0100
From: "Ronny Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>
Organization: Ericsson EuroLab
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.14: crashing on heavy swap-load with SmartArray
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Total crash (Aieeee: Killing interrupt handlers...) on an compaq 6400R
Dual PIII Xeon 500, 3GB Ram + 1G Swap, custom kernel (SMP,
smartarray/eepro100 into kernel).

syslog says:
Nov  9 13:05:54 eedn36ls kernel: Invalid request on ida/c0d0 = (cmd=30
sect=5490
904 cnt=112 sg=12 ret=10) 

console:
Invalid request ...(same as above)
invalid operand: 0000
CPU: 1
EIP: 0010: [<c0123b3e>] EFLAGS: 00010046
eax: 0 ebx: edd98500 ecx: 1 edx: c1a80dc0
esi: 2 edi: c1a80dc0 ebp: 1 esp: c4039efc
ds: 0018 es: 0018 ss: 0018

(...)

Process: swapper (PID: 0, stackpage=c4039000) ...
....
Code: 0f 0b 8d 5a 24 8d 42 28 39 42 28 74 11 b9 01 00 00 00 ba 03

On the second crash, there was a slight change:
No reporting about an invalid request on ida/c0d0 but:

CPU: 0
same EIP, EFLAGS

Process: mtest01 (PID: 683, stackpage=f7439000)
....

same Code: ...

It is reproduceable on 2.4.14 (first compile using 2.91.66 gcc, second
2.95.3 gcc) using mtest01 from the Linux Testing Project
(ltp-20010801/ltctests/mem/mtest01).
I also applied the newest microcodeupdate from Intel, stays the same.
2.2.19 is doing fine (with bigmempatch, of course).

I used params: ./mtest01 -w -c $[25*1024*1024] -p 60 and started 3
processes. This will allocate 60% of total system ram on each process in
25MB chunks and will write to it after allocating.

If more infos are required, I will try me best to write down the
kernel-panic :)
Please include me on CC.

Kind regards,
Ronny
