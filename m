Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJIRUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTJIRUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:20:40 -0400
Received: from sphere.barak.net.il ([212.150.48.98]:52186 "EHLO
	sphere.barak.net.il") by vger.kernel.org with ESMTP id S262323AbTJIRUf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:20:35 -0400
From: "Amir Hermelin" <amir@montilio.com>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Format of an 'oops' call trace (in show_trace)
Date: Thu, 9 Oct 2003 19:20:28 +0200
Organization: Montilio
Message-ID: <028001c38e89$a5ca7b00$1401a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20031008100603.53c1cf75.rddunlap@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Randy.

Since the information doesn't tell me much other than which function
dropped, is there any way I could get more than a hunch of where the fault
occurred, assuming this is a loadable module?

Thanks,
Amir.



-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
Sent: Wednesday, October 08, 2003 7:06 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Format of an 'oops' call trace (in show_trace)


On Wed, 8 Oct 2003 13:25:44 +0200 "Amir Hermelin" <amir@montilio.com> wrote:

| Oops,
| I forgot that part :)  It's RH 2.4.20-8
| 
| Thanks,
| Amir.
| 
| 
| On Tue, 7 Oct 2003 17:56:38 +0200 "Amir Hermelin" <amir@montilio.com> 
| wrote:
| 
| | Hi,
| | Can someone please point me to a description of what I see in the 
| | Call
| | of the oops dump?  I tried looking into show_trace and lookup_symbol 
| | functions, but I couldn't understand some things.  For example, in 
| | this following trace:

The basic format (in RH 2.4.20-8) is:

[<address>] symbol_name [module_name] 0xoffset_from_symbol (where address is
on stack)

offset_from_symbol is hex bytes from symbol to <address>, so 0x0 is an exact
match.

| | joji kernel: [<e01bae00>] reqrdata [mymod] 0x0 (0xd5543fb4)) joji 
| | kernel: [<e01a5220>] mymod [mymod] 0x0 (0xd5543fe0))

| | I don't understand the relevance to reqrdata (since it's not a 
| | function,
| but
| | a data structure, and isn't the parameter to the mymod function).

It looks for any addresses in the kernel text (code) space and tries to find
symbol names for them.

| | And could
| | someone please explain what the 0x0 in the lines mean? From the code 
| | I understood it to be the offset of the symbol within the module, 
| | but that can't be right if both symbols translate to the same offset 
| | - so I must've understood it wrong.

See above.

| | joji kernel:  printing eip:
| | joji kernel: e01b090b
| | joji kernel: *pde = 00000000
| | joji kernel: Oops: 0002
| | joji kernel: CPU:    0
| | joji kernel: EIP:    0060:[<e01b090b>]    Not tainted
| | joji kernel: EFLAGS: 00010282
| | joji kernel:
| | joji kernel: EIP is at rtp_recv [mymod] 0x5b (2.4.20-8custom)
| | joji kernel: eax: 00000000   ebx: d5542000   ecx: 00000001
| | edx: c0374c88
| | joji kernel: esi: e01bae00   edi: d76aa400   ebp: d5543fcc
| | esp: d5543f98
| | joji kernel: ds: 0068   es: 0068   ss: 0068
| | joji kernel: Process mymod (pid: 6978, stackpage=d5543000)
| 
| | joji kernel: Stack: e01bae00 d76aa400 d5542000 00000000 d76aa400 
| | ffffffff e01a5308 e01bae00
| | joji kernel:        d76aa400 d5543fcc d5542000 d5542000
| | dbd15900 00000000 d54f3fd0 d5533fd0 
| | joji kernel:        d5542000 00000000 e01a5220 00000000
| | 00000000 00000000 c010742d d76aa400
| | joji kernel: Call Trace:
| |   [<e01bae00>] reqrdata [mymod] 0x0 (0xd5543f98))
| | joji kernel: [<e01a5308>] mymod [mymod] 0xe8 (0xd5543fb0))
| 
| | joji kernel: [<e01bae00>] reqrdata [mymod] 0x0 (0xd5543fb4))
| | 
| | joji kernel: [<e01a5220>] mymod [mymod] 0x0 (0xd5543fe0)) joji 
| | kernel: [<c010742d>] kernel_thread_helper [kernel] 0x5 (0xd5543ff0))

HTH.

--
~Randy


