Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbQKSJ7k>; Sun, 19 Nov 2000 04:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQKSJ7a>; Sun, 19 Nov 2000 04:59:30 -0500
Received: from new-smtp1.ihug.com.au ([203.109.250.27]:31241 "EHLO
	new-smtp1.ihug.com.au") by vger.kernel.org with ESMTP
	id <S129239AbQKSJ71>; Sun, 19 Nov 2000 04:59:27 -0500
Message-ID: <3A179D47.3CAAF427@ihug.com.au>
Date: Sun, 19 Nov 2000 20:28:39 +1100
From: Vincent <dtig@ihug.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: mount /mnt/cdrom ok!but ls segmentation fault...
In-Reply-To: <200011190904.eAJ94oq98530@saturn.cs.uml.edu>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:
> 
> The 'D' means that the process is running uninterruptable kernel
> code that should never take long to execute. Usually it means
> the process is doing disk IO.
> 
> To find where process 613 is stuck, do this:
> 
> ps -p 613 -o comm,stat,f,pcpu,nwchan,wchan

  361 pts/1    D      0:00 /bin/ls --color=auto -F -b -T 0
t77@darkstar:~$ ps -p 361 -o comm,stat,f,pcpu,nwchan,wchan
COMMAND          STAT   F %CPU  WCHAN WCHAN
ls               D    000  0.0 107951 down
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ no idea... :p since i am a
newbie,
is there anyway of killing such a process?
root@darkstar:~# umount /mnt/cdrom1
umount: /mnt/cdrom1: device is busy
root@darkstar:~# umount -f /mnt/cdrom1
umount2: Device or resource busy
umount: /mnt/cdrom1: device is busy

After playing around with ls ,i found that acutally executing /bin/ls
is ok, only because of the default alias of ls is alias ls='/bin/ls
$LS_OPTIONS' then 
ls will crash...and thus make the cdrom useless.

When ls /mnt/cdrom , from a virtual terminal there are extended kernel
error messages which i don't 
know howto copy the error message into memory or save it into a file.
Where 
if i 'ls /mnt/cdrom' from a gnome-terminal the error message is just
Segmentation fault.

from /var/log/syslog after "ls /mnt/cdrom"
Nov 19 19:46:47 darkstar kernel: Unable to handle kernel paging request
at virtual address dfdfdfc4
Nov 19 19:46:47 darkstar kernel: *pde = 00000000

Unable to handle kernel paging request at virtual address dfdfdfc4
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c486d5a7>]
EFLAGS: 00010202 ............rest went off the screen
i've tried "ls >~/tmp/err.out" , it didn't work just a 0byte file.

hmmm, ok here it's in dmesg|less

Unable to handle kernel paging request at virtual address dfdfdfc4
 printing eip:
c486d5a7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c486d5a7>]
EFLAGS: 00010202
eax: dfdfdf00   ebx: c2976960   ecx: c1ddb800   edx: c23f5c00
esi: c1ddb800   edi: c1ddb821   ebp: c233fba0   esp: c15b9eb0
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 229, stackpage=c15b9000)
Stack: c2976960 c486a2bf c1ddb800 c2976960 c27f8000 c10a9df0 c1b3d140
c2976960 
       c1b3d140 00000001 c01e1818 00000022 00000022 00000000 0b976960
00000800 
       22994000 c486a3dd c2976960 c1b3d140 c27f8000 c27f8400 fffffff4
c1b3d140 
Call Trace: [<c486a2bf>] [<c486a3dd>] [<c013502b>] [<c0135788>]
[<c0134dc7>] [<c0135d90>] [<c0132a26>] 
       [<c0108daf>] 
Code: 8b 90 c4 00 00 00 80 b8 b4 00 00 00 00 74 1e 68 00 10 00 00 
lines 76-116/116 (END) 

thank you for reply,
-
Regards, Vincent <dtig@ihug.com.au>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
