Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267983AbTAHXtD>; Wed, 8 Jan 2003 18:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267984AbTAHXtD>; Wed, 8 Jan 2003 18:49:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:49836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267983AbTAHXtC> convert rfc822-to-8bit;
	Wed, 8 Jan 2003 18:49:02 -0500
Date: Wed, 8 Jan 2003 15:54:14 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Roets, Chris (Tru64&Linux support)" <Chris.Roets@hp.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux i386 stack trace
In-Reply-To: <224CFA9643B4CE4BA18137CF73DB2F32010F2CD0@broexc01.emea.cpqcorp.net>
Message-ID: <Pine.LNX.4.33L2.0301081544150.6873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

George already gave you some good info.
Here's a little more that might help.


On Wed, 8 Jan 2003, Roets, Chris (Tru64&Linux support) wrote:

| I known nothing about i386 calling conventions, but I would like to analyse a kernel stack.
|
| I have the following stack trace :
|
| STACK TRACE FOR TASK: 0xc4cb6000(vi)
|
| 0 schedule+770 [0xc01130e2]
| 1 schedule_timeout+18 [0xc0112d42]
| 2 do_select+513 [0xc0140a11]
| 3 sys_select+820 [0xc0140db4]
| 4 system_call+44 [0xc0106f14]
| ebx: 00000001   ecx: bffff700   edx: 00000000   esi: bffff680
| edi: 00000000   ebp: bffff798   eax: 0000008e   ds:  002b
| es:  002b       eip: 4010e0ee   cs:  0023       eflags: 00000202
| esp: bffff630   ss:  002b
| ================================================================

The debugger has already listed all of the kernel symbols that
it can associate with addresses on the stack, here:

| >> dump -x 3301670612 40
| 0xc4cb7f04:       c0112d47 schedule_timeout+23 <<<<<
| 0xc4cb7f34:       c0140a16 do_select+518       <<<<<
|              c0140db9 sys_select+825   <<<<<
|
| can anybody point me out where the arguments and the local variables are ?
| take for example
| int do_select(int n, fd_set_bits *fds, long *timeout)
| {
|        poll_table table, *wait;
|        int retval, i, off;
|        long __timeout = *timeout;

|       ......
| I t has 3 arguments and tree local variable
| I would be nice to have the same for ia64

Actually it has 6 local variables, and they might not be allocated
any space on the stack at all.  They could all be in registers,
or a few of them in registers and others on the stack.

The arguments are pushed onto the stack (for x86), as George indicated.

-- 
~Randy

