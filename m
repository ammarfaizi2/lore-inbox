Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966403AbWKNWTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966403AbWKNWTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966414AbWKNWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:19:17 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:14700 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S966403AbWKNWTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:19:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=fozbTZE0Is7vz114INPkFGIX0run5WTzLnFcgiOr/3lrlFPq61swamPAuMV9KGCUzQEopxO1bkQHqd0SrO/y8unEx/3lx7xJs/U7qNTZqsfhuCvetjxpX74xxtwOEyjMwmgtNQING7FV8tvSpzS+YtO6RMBUjBG/TmeTybD/nJI=
Message-ID: <455A40DF.3040903@gmail.com>
Date: Tue, 14 Nov 2006 20:19:11 -0200
From: Alexandre Pereira Nunes <alexandre.nunes@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.7.13) Gecko/20060809 Debian/1.7.13-0.3
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ARM - Xscale Pxa 255] dlopen()s segfault at first runt; Subsequent
 runs succeeds.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With Linux 2.6.18 we're experiencing the symptoms describe above; On the 
first attempt to load a binary which in turns explicitly loads a DSO, 
there's a crash. Subsequent attempts succeeds.

The machine is a gumstix (400mhz pxa 255), kernel 2.6.18, uclibc, gcc 
3.4.5 binutils 2.17 (also tested with 2.16.1).

I've booted it with user_debug=0x1f parameter and got these:

(On the boot, a script runs that call iptables several times, and it 
eventually loads different DSOs conforming to what is requested, 
therefore the crashes).

If I get rid of the rules it succeeds (some don't, because it crashes 
beforehand), and run the script again, everything go fine.

The most interesting example of this is asterix: a user reported running 
it several times, and each time it crashed on a DSO load, but on the 
next time that particular one succeeded, and the load of another 
crashed, until everything runs just fine, and the crash doesn't happen 
again until reboot.

The root file system is jffs2, by the way.

If I just replace the kernel by a 2.6.17 one, everything runs fine.

Just ask for any other details, and please CC: me as I'm not subscribed.

Thanks,

- Alexandre


Crash log:


iptables: unhandled page fault (11) at 0x000000c9, code 0x017
pgd = c397c000
[000000c9] *pgd=a387c031, *pte=00000000, *ppte=00000000

Pid: 270, comm:             iptables
CPU: 0
PC is at 0x4000f054
LR is at 0x4000e8fc
pc : [<4000f054>]    lr : [<4000e8fc>]    Not tainted
sp : beef6c60  ip : 40017fd0  fp : beef6cc4
r10: 40017f94  r9 : 0001d050  r8 : beef6cc8
r7 : beef6c64  r6 : beef6c64  r5 : 000000c9  r4 : 4007b41c
r3 : 00000000  r2 : 000000c8  r1 : 400893ac  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 397F  Table: A397C000  DAC: 00000015
[<c0019ad4>] (show_regs+0x0/0x4c) from [<c001e3e0>] 
(__do_user_fault+0x5c/0xa4)
 r4 = C0289040
[<c001e384>] (__do_user_fault+0x0/0xa4) from [<c001e678>] 
(do_page_fault+0x1e4/0x214)
 r7 = C0014360  r6 = C3F09710  r5 = C0289040  r4 = FFFFFFEC
[<c001e494>] (do_page_fault+0x0/0x214) from [<c001e7e4>] 
(do_DataAbort+0x3c/0xa0)
[<c001e7a8>] (do_DataAbort+0x0/0xa0) from [<c0018ce8>] 
(ret_from_exception+0x0/0x10)
 r8 = BEEF6CC8  r7 = BEEF6C64  r6 = BEEF6C64  r5 = 000000C9
 r4 = FFFFFFFF
iptables: unhandled page fault (11) at 0x000000bf, code 0x017
pgd = c3908000
[000000bf] *pgd=a3972031, *pte=00000000, *ppte=00000000

Pid: 287, comm:             iptables
CPU: 0
PC is at 0x4000f054
LR is at 0x4000e8fc
pc : [<4000f054>]    lr : [<4000e8fc>]    Not tainted
sp : bec1ac08  ip : 40017fd0  fp : bec1ac6c
r10: 40017f94  r9 : 0001d058  r8 : bec1ac70
r7 : bec1ac0c  r6 : bec1ac0c  r5 : 000000bf  r4 : 4007b41c
r3 : 00000000  r2 : 000000be  r1 : 40088dc4  r0 : 00000001
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 397F  Table: A3908000  DAC: 00000015
[<c0019ad4>] (show_regs+0x0/0x4c) from [<c001e3e0>] 
(__do_user_fault+0x5c/0xa4)
 r4 = C02A8040
[<c001e384>] (__do_user_fault+0x0/0xa4) from [<c001e678>] 
(do_page_fault+0x1e4/0x214)
 r7 = C0014AE0  r6 = C3F0917C  r5 = C02A8040  r4 = FFFFFFEC
[<c001e494>] (do_page_fault+0x0/0x214) from [<c001e7e4>] 
(do_DataAbort+0x3c/0xa0)
[<c001e7a8>] (do_DataAbort+0x0/0xa0) from [<c0018ce8>] 
(ret_from_exception+0x0/0x10)
 r8 = BEC1AC70  r7 = BEC1AC0C  r6 = BEC1AC0C  r5 = 000000BF
 r4 = FFFFFFFF
iptables: unhandled page fault (11) at 0x000000b9, code 0x017
pgd = c0264000
[000000b9] *pgd=a394f031, *pte=00000000, *ppte=00000000

Pid: 318, comm:             iptables
CPU: 0
PC is at 0x4000f054
LR is at 0x4000e8fc
pc : [<4000f054>]    lr : [<4000e8fc>]    Not tainted
sp : beedcc18  ip : 40017fd0  fp : beedcc7c
r10: 40017f94  r9 : 0001d058  r8 : beedcc80
r7 : beedcc1c  r6 : beedcc1c  r5 : 000000b9  r4 : 4007b41c
r3 : 00000000  r2 : 000000b8  r1 : 40088c9c  r0 : 40088ca4
Flags: nZCv  IRQs on  FIQs on  Mode USER_32  Segment user
Control: 397F  Table: A0264000  DAC: 00000015
[<c0019ad4>] (show_regs+0x0/0x4c) from [<c001e3e0>] 
(__do_user_fault+0x5c/0xa4)
 r4 = C3991D60
[<c001e384>] (__do_user_fault+0x0/0xa4) from [<c001e678>] 
(do_page_fault+0x1e4/0x214)
 r7 = C0014960  r6 = C3DCC2CC  r5 = C3991D60  r4 = FFFFFFEC
[<c001e494>] (do_page_fault+0x0/0x214) from [<c001e7e4>] 
(do_DataAbort+0x3c/0xa0)
[<c001e7a8>] (do_DataAbort+0x0/0xa0) from [<c0018ce8>] 
(ret_from_exception+0x0/0x10)
 r8 = BEEDCC80  r7 = BEEDCC1C  r6 = BEEDCC1C  r5 = 000000B9
 r4 = FFFFFFFF

