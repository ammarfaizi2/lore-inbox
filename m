Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFXUvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTFXUvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:51:04 -0400
Received: from [62.67.222.139] ([62.67.222.139]:65489 "EHLO kermit")
	by vger.kernel.org with ESMTP id S261651AbTFXUvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:51:00 -0400
Date: Tue, 24 Jun 2003 23:04:14 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: medium Oops on 2.5.73-mm1
Message-ID: <20030624210414.GA1533@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030624164026.GA2934@sexmachine.doom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030624164026.GA2934@sexmachine.doom>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This evening 2.5.73-mm1 "crashed" two times. The " because of that: this
time it did not freeze completely, it disabled keyboard and mouse
buttons, mouse movements where working still! I was running X...

I enabled debugging in kernel, do you need the raw output or the
ksymoopsed one?

last lines raw:

agetty        S E9DC2000  5027      1                4994 (NOTLB)
ea767e1c 00000082 00000082 e9dc2000 ea767e34 c0339260 00000246 c0339260
       c03db160 eaa23000 c03db160 00000001 00000008 7fffffff 00000000
eb175974
       c0130393 c03db160 00000292 eb175000 7fffffff 00100100 00200200
00000246
Call Trace:
 [<c0130393>] schedule_timeout+0xe5/0xe7
 [<c024847a>] uart_write+0x18a/0x4be
 [<c02361d8>] read_chan+0x2d8/0x100e
 [<c0237094>] write_chan+0x186/0x272
 [<c011ecd7>] default_wake_function+0x0/0x2e
 [<c011ecd7>] default_wake_function+0x0/0x2e
 [<c0235f00>] read_chan+0x0/0x100e
 [<c022f4e3>] tty_read+0x24b/0x2ce
 [<c012ac52>] tasklet_action+0x40/0x61
 [<c0171c26>] vfs_read+0xbc/0x127
 [<c0171edd>] sys_read+0x42/0x63
 [<c010a067>] syscall_call+0x7/0xb

full at http://www.ludenkalle.de/capture.log.2003-06-24

and ksymoopsed:

>>EIP; e5cf1e6c <_end+25909b9c/3fc15d30>   <=====

Trace; c0130341 <schedule_timeout+93/e7>
Trace; c01302a5 <process_timeout+0/9>
Trace; c018d5b4 <do_select+29e/474>
Trace; c018d171 <__pollwait+0/c4>
Trace; c018dab0 <sys_select+301/53d>
Trace; c0137455 <sys_rt_sigaction+a1/115>
Trace; c010a067 <syscall_call+7/b>
Proc;  agetty

>>EIP; e9dc2000 <_end+299d9d30/3fc15d30>   <=====

Trace; c0130393 <schedule_timeout+e5/e7>
Trace; c024847a <uart_write+18a/4be>
Trace; c02361d8 <read_chan+2d8/100e>
Trace; c0237094 <write_chan+186/272>
Trace; c011ecd7 <default_wake_function+0/2e>
Trace; c011ecd7 <default_wake_function+0/2e>
Trace; c0235f00 <read_chan+0/100e>
Trace; c022f4e3 <tty_read+24b/2ce>
Trace; c012ac52 <tasklet_action+40/61>
Trace; c0171c26 <vfs_read+bc/127>
Trace; c0171edd <sys_read+42/63>
Trace; c010a067 <syscall_call+7/b>


2 warnings and 1 error issued.  Results may not be reliable.

full at http://www.ludenkalle.de/C

-- 
2.5.73-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 7 min, 
