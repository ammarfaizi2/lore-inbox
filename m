Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUFFFem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUFFFem (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 01:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUFFFel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 01:34:41 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:20586 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S262909AbUFFFef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 01:34:35 -0400
Message-ID: <40C2ACE3.70105@ThinRope.net>
Date: Sun, 06 Jun 2004 14:34:27 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org> <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net> <20040606051350.GA19485@taniwha.stupidest.org>
In-Reply-To: <20040606051350.GA19485@taniwha.stupidest.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, Jun 06, 2004 at 02:08:52PM +0900, Kalin KOZHUHAROV wrote:
> 
> 
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
>>[pid 13097] getpid()                    = 13097
> 
> 
> is this repeartable?  if you strace -tt how often is this?
Yes, definately on this system. Here we go:

poi root # strace -tt -f -F -p 3550
Process 3550 attached - interrupt to quit
14:24:31.589227 accept(3, {sa_family=AF_INET, sin_port=htons(40575), sin_addr=inet_addr("192.168.1.20")}, [16]) = 0
14:25:04.068649 rt_sigprocmask(SIG_BLOCK, [CHLD], NULL, 8) = 0
14:25:04.068898 write(2, "tcpserver: status: 1/40\n", 24) = 24
14:25:04.069229 fork(Process 14320 attached
)                  = 14320
[pid  3550] 14:25:04.069663 close(0 <unfinished ...>
[pid 14320] 14:25:04.069771 close(3 <unfinished ...>
[pid  3550] 14:25:04.069874 <... close resumed> ) = 0
[pid  3550] 14:25:04.069977 rt_sigprocmask(SIG_UNBLOCK, [CHLD], NULL, 8) = 0
[pid  3550] 14:25:04.070169 accept(3,  <unfinished ...>
[pid 14320] 14:25:04.070278 <... close resumed> ) = 0
[pid 14320] 14:25:04.070406 getpid()    = 14320
[pid 14320] 14:25:04.070614 write(2, "tcpserver: pid 14320 from 192.16"..., 39) = 39
...
[pid 14320] 14:25:04.139116 close(3)    = 0
[pid 14320] 14:25:04.139242 close(6)    = 0
[pid 14320] 14:25:04.139350 time(NULL)  = 1086499504
[pid 14320] 14:25:04.139516 getpid()    = 14320
[pid 14320] 14:25:04.139742 read(0, "\26\3\1\0s\1\0\0o\3\1", 11) = 11
[pid 14320] 14:25:04.139910 time(NULL)  = 1086499504
[pid 14320] 14:25:04.140017 getpid()    = 14320
[pid 14320] 14:25:04.140125 read(0, "\0?\230A\323\323\304\226\v\37NI\310\3634i\375\346\300p"..., 109) = 109
[pid 14320] 14:25:04.140278 time(NULL)  = 1086499504
[pid 14320] 14:25:04.140383 getpid()    = 14320
[pid 14320] 14:25:04.140475 getpid()    = 14320
[pid 14320] 14:25:04.140584 getpid()    = 14320
[pid 14320] 14:25:04.140681 open("/dev/urandom", O_RDONLY|O_NONBLOCK|O_NOCTTY) = 3
[pid 14320] 14:25:04.140811 select(4, [3], NULL, NULL, {0, 10000}) = 1 (in [3], left {0, 10000})
[pid 14320] 14:25:04.140972 read(3, "g\t\270X\304\260\17P\'\367\t\"\253\375\24\350\272\240\327"..., 32) = 32
[pid 14320] 14:25:04.141130 close(3)    = 0
[pid 14320] 14:25:04.141224 getpid()    = 14320
[pid 14320] 14:25:04.141326 getpid()    = 14320
[pid 14320] 14:25:04.141435 getuid32()  = 89
[pid 14320] 14:25:04.141531 getpid()    = 14320
[pid 14320] 14:25:04.141650 time(NULL)  = 1086499504
[pid 14320] 14:25:04.141747 getpid()    = 14320
[pid 14320] 14:25:04.141846 getpid()    = 14320
[pid 14320] 14:25:04.141949 getpid()    = 14320
[pid 14320] 14:25:04.142051 getpid()    = 14320
[pid 14320] 14:25:04.142153 getpid()    = 14320
[pid 14320] 14:25:04.142257 getpid()    = 14320
[pid 14320] 14:25:04.142359 getpid()    = 14320
[pid 14320] 14:25:04.142461 getpid()    = 14320
[pid 14320] 14:25:04.142580 getpid()    = 14320
[pid 14320] 14:25:04.142683 getpid()    = 14320
[pid 14320] 14:25:04.142784 getpid()    = 14320
[pid 14320] 14:25:04.142886 getpid()    = 14320
[pid 14320] 14:25:04.142989 getpid()    = 14320
[pid 14320] 14:25:04.143090 getpid()    = 14320
[pid 14320] 14:25:04.143192 getpid()    = 14320
[pid 14320] 14:25:04.143294 getpid()    = 14320
[pid 14320] 14:25:04.143396 getpid()    = 14320
[pid 14320] 14:25:04.143499 getpid()    = 14320
[pid 14320] 14:25:04.143619 getpid()    = 14320
[pid 14320] 14:25:04.143722 getpid()    = 14320
[pid 14320] 14:25:04.143824 getpid()    = 14320
[pid 14320] 14:25:04.143927 getpid()    = 14320
[pid 14320] 14:25:04.144029 getpid()    = 14320
[pid 14320] 14:25:04.144131 getpid()    = 14320
[pid 14320] 14:25:04.144233 getpid()    = 14320
[pid 14320] 14:25:04.144336 getpid()    = 14320
[pid 14320] 14:25:04.144438 getpid()    = 14320
[pid 14320] 14:25:04.144540 getpid()    = 14320
[pid 14320] 14:25:04.144701 getpid()    = 14320
[pid 14320] 14:25:04.144804 getpid()    = 14320
[pid 14320] 14:25:04.144906 getpid()    = 14320
[pid 14320] 14:25:04.145009 getpid()    = 14320
[pid 14320] 14:25:04.145111 getpid()    = 14320
[pid 14320] 14:25:04.145214 getpid()    = 14320
[pid 14320] 14:25:04.145316 getpid()    = 14320
[pid 14320] 14:25:04.145419 getpid()    = 14320
[pid 14320] 14:25:04.145520 getpid()    = 14320
[pid 14320] 14:25:04.145640 getpid()    = 14320
[pid 14320] 14:25:04.145742 getpid()    = 14320
[pid 14320] 14:25:04.145845 getpid()    = 14320
[pid 14320] 14:25:04.145948 getpid()    = 14320
[pid 14320] 14:25:04.146050 getpid()    = 14320
[pid 14320] 14:25:04.146152 getpid()    = 14320
[pid 14320] 14:25:04.146254 getpid()    = 14320
[pid 14320] 14:25:04.146356 getpid()    = 14320
[pid 14320] 14:25:04.146458 getpid()    = 14320
[pid 14320] 14:25:04.146575 getpid()    = 14320
[pid 14320] 14:25:04.146678 getpid()    = 14320
[pid 14320] 14:25:04.146780 getpid()    = 14320
[pid 14320] 14:25:04.146882 getpid()    = 14320
[pid 14320] 14:25:04.146985 getpid()    = 14320
[pid 14320] 14:25:04.147087 getpid()    = 14320
[pid 14320] 14:25:04.147189 getpid()    = 14320
[pid 14320] 14:25:04.147345 time(NULL)  = 1086499504
[pid 14320] 14:25:04.147442 getpid()    = 14320
[pid 14320] 14:25:04.147531 getpid()    = 14320
[pid 14320] 14:25:04.147773 write(0, "\26\3\1\0J\2\0\0F\3\1@\302\252\260\204\203~\367\r\305G"..., 1127) = 1127
[pid 14320] 14:25:04.147937 read(0, "\26\3\1\1\6", 5) = 5
[pid 14320] 14:25:04.151416 read(0, "\20\0\1\2\1\0S\303\2\335E\264\330\250\261oj\307a~en\262"..., 262) = 262
[pid 14320] 14:25:04.151575 getpid()    = 14320
[pid 14320] 14:25:04.151685 time([1086499504]) = 1086499504
[pid 14320] 14:25:04.151790 getpid()    = 14320
[pid 14320] 14:25:04.151883 getpid()    = 14320
[pid 14320] 14:25:04.155052 getpid()    = 14320
[pid 14320] 14:25:04.155150 getpid()    = 14320
[pid 14320] 14:25:04.178154 read(0, "\24\3\1\0\1", 5) = 5
[pid 14320] 14:25:04.178346 read(0, "\1", 1) = 1
[pid 14320] 14:25:04.178646 read(0, "\26\3\1\0000", 5) = 5
[pid 14320] 14:25:04.178810 read(0, "\10\215\371\334e+\324\356\224|\216\371\204\351\330f+\203"..., 48) = 48
[pid 14320] 14:25:04.179055 write(0, "\24\3\1\0\1\1\26\3\1\0000\26\2678\202\31\16\251\346\224"..., 59) = 59
[pid 14320] 14:25:04.179302 gettimeofday({1086499504, 179360}, NULL) = 0
...

The ppid changed because I restarted /service while testing.
I sent a short mail via SMTP/SSL to trigger the above trace.

> what's more, i wonder why this is going on?  i'd almost be tempted to
> attach to it with gdb and take a bt from getpid and see wtf is going
> on
Well, there was no gdb on that machine, compiling it now.
AFAIR, tcpserver is stripped (it is a "production" machine), so I wonder how inforamative it will be.

I havent used gbd a lot, educate me what to do.
For example how do I set a bp to trigger when getpid() is called ?
I know how to set one in a function, but I guess function names are stripped.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
