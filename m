Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSLCRUO>; Tue, 3 Dec 2002 12:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSLCRUO>; Tue, 3 Dec 2002 12:20:14 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62727 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261934AbSLCRUM>; Tue, 3 Dec 2002 12:20:12 -0500
Message-ID: <3DECE856.E784A3F4@aitel.hist.no>
Date: Tue, 03 Dec 2002 18:22:30 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 hang when copying files, handwritten trace included
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Yes please - if you could gather sufficient info to enable
> us to determine what eax is pointing at in wake_up_forked_process(),
> that would help.  Presumably it's the new process, which is rather
> bizarre.

Here's all the details.  Please tell if there is anything more I can
do with it. I simply don't know how to find "what line number in the
code"
or which variable maps to what register. But I have done programming
before and can follow instructions. Note that the .o files for this
build isn't around - I have patched the source tree after
booting but before this happened.

The first part probably scrolled off the screen, here is what I got:

EIP: 0060:[<c0119238>] Not tainted
EFLAGS: 00010086
EIP is at wake_up_forked_process+0xb8/0x18c
eax: 5a5a5a5a  ebx: c151da80  ecx: 0159f48d  edx: 00000000
esi: c0469d00  edi: 51eb851f  ebp: dfdd5f18  esp: dfdd5f08
ds:0068  es:0068  ss:0068

Process pdflush (pid:7 threadinfo=dfdd4000 task=c151ce00)

Stack: 00000000 c151da80 00000000 c0469d00 dfdd5fe4 c011e62a
       00000000 00000000 dfdd5f70 000002f2 000001dc 00000db4
       00000000 00000000 c0106fa1 00800f00 00000000 dfdd5f70
       00000000 00000000 00000000 dfdd5fd8 c03c53d4 dfdd4000

Call trace:

[<c011e62a>] do_fork+0xe2/0x138
[<c0106fa1>] kernel_thread+0x79/0x90
[<c01455b8>] pdflush+0x0/0x14
[<c0106f1c>] kernel_thread_helper+0x0/0xc
[<c0145719>] start_one_pdflush_thread+0x11/0x5
[<c01455b8>] pdflush+0x0/0x14
[<c01454d8>] __pdflush+0x0/0x14
[<c01455b8>] pdflush+0x0/0x14
[<c01455c3>] pdflush+0xb/0x14
[<c01459b8>] background_writeout+0x0/0xbc
[<c0106f21>] kernel_thread_helper+0x5/0xc

Code 89 50 0c 8b 55 fc a1 84
     58 4c c0 2b 43 30 8b 7a
     20 83 7b 18



> Also, does disabling preemption make it stop?

I'll run a test - later.

Helge Hafting
