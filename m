Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMJBy>; Mon, 13 Nov 2000 04:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQKMJBo>; Mon, 13 Nov 2000 04:01:44 -0500
Received: from 3dyn245.com21.casema.net ([212.64.94.245]:18697 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129040AbQKMJBb>;
	Mon, 13 Nov 2000 04:01:31 -0500
Date: Mon, 13 Nov 2000 09:58:17 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
Message-ID: <20001113095816.A29077@spaans.ds9a.nl>
In-Reply-To: <3A0DF347.43807CB5@uow.edu.au> <3204.973996033@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3204.973996033@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Nov 12, 2000 at 01:27:13PM +1100
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 12, 2000 at 01:27:13PM +1100, Keith Owens wrote:

> >That's a pretty wierd trace.  You seem to have addresses related
> >to the `apm' kernel thread on mysqld's stack.
> 
> Normal unfortunately.  Firstly the ix86 oops code just scans the stack
> and prints anything that looks like it might be a kernel address.  It
> makes no attempt to confirm that these really are return addresses, so
> an ix86 oops trace gets lots of false positives.  Secondly that trace
> was converted by klogd (symbols in call trace line instead of numbers)
> not by ksymoops, I do not trust the klogd algorithm at all.  

All right, here's another one, this time using the oops directly from the
console -- this seems to give better symbols.. The 'console shuts up ...'
works, the oops from the other CPU didn't get put out.

Will try test11-pre3 + kdb this afternoon, if it compiles.

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ksymoops-output-2

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map-2.4.0-test11-pre2 (specified)

NMI Watchdog detected LOCKUP on CPU1, registers:
CPU:    1
EIP:    0010:[<c02347c4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000086
eax: 00000000   ebx: ce780000   ecx: 00000000   edx: ffffffff
esi: 00000002   edi: 00000000   ebp: cd0f1eb0   esp: cd0f1ea8
ds: 0018   es: 0018   ss: 0018
Process mysqld (pid: 5799, stackpage=cd0f1000)
Stack: ce780000 00000021 00000000 c01152ea ce780000 00000021 00000086 c01153c6 
       00000021 cd0f1f04 ce780000 00040001 00000000 cd0f0000 00000021 c011589a 
       00000021 cd0f1f04 ce780000 cd0f0000 c1458000 cd0f0000 ce780000 00000021 
Call Trace: [<c01152ea>] [<c01153c6>] [<c011589a>] [<c0122012>] [<c011e727>] [<c011eaf8>] [<c011eb4e>] 
       [<c010b203>] 
Code: 80 3d 00 44 2e c0 00 f3 90 7e f5 e9 67 59 ee ff 80 3b 00 f3 

>>EIP; c02347c4 <stext_lock+8e8/98ac>   <=====
Trace; c01152ea <deliver_signal+4a/90>
Trace; c01153c6 <send_sig_info+96/c0>
Trace; c011589a <do_notify_parent+c6/e0>
Trace; c0122012 <do_acct_process+21e/22c>
Trace; c011e727 <exit_notify+1a7/30c>
Trace; c011eaf8 <do_exit+26c/2b4>
Trace; c011eb4e <sys_exit+e/10>
Trace; c010b203 <system_call+33/38>
Code;  c02347c4 <stext_lock+8e8/98ac>
00000000 <_EIP>:
Code;  c02347c4 <stext_lock+8e8/98ac>   <=====
   0:   80 3d 00 44 2e c0 00      cmpb   $0x0,0xc02e4400   <=====
Code;  c02347cb <stext_lock+8ef/98ac>
   7:   f3 90                     repz nop 
Code;  c02347cd <stext_lock+8f1/98ac>
   9:   7e f5                     jle    0 <_EIP>
Code;  c02347cf <stext_lock+8f3/98ac>
   b:   e9 67 59 ee ff            jmp    ffee5977 <_EIP+0xffee5977> c011a13b <wake_up_process+13/68>
Code;  c02347d4 <stext_lock+8f8/98ac>
  10:   80 3b 00                  cmpb   $0x0,(%ebx)
Code;  c02347d7 <stext_lock+8fb/98ac>
  13:   f3 00 00                  repz add %al,(%eax)


--+QahgC5+KEYLbs62--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
