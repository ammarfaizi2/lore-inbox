Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273292AbTHKTrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273033AbTHKTrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:47:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:14259 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273298AbTHKTqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:46:20 -0400
Date: Mon, 11 Aug 2003 12:43:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Greg Nate" <Greg_Nate@adp.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Kernel 2.4.21 Crashing
Message-Id: <20030811124317.07f7a426.rddunlap@osdl.org>
In-Reply-To: <BF2EFB3523C48E47806C1C94D4EFB80301245729@nexus.plaza.ds.adp.com>
References: <BF2EFB3523C48E47806C1C94D4EFB80301245729@nexus.plaza.ds.adp.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 10:19:56 -0700 "Greg Nate" <Greg_Nate@adp.com> wrote:

| This example would be a good opportunity for explanation.  Hopefully, I am not the only one that has trouble deciphering the output from an Oops or panic.
| 
| If anyone is in the "know" and has the time, could you please give a little explanation as to what is being displayed below.  I understand that the there is a stack trace and register dumps, but I am not all that familiar with the registers being displayed, their significance and meaning.


kernelnewbies.org (web, email, wiki, or irc) would be a good place
for such documentation....

and please use hard returns so that your lines are max 72 characters.

This (below) is all very x86 specific.
It helps (probably an understatement) to know how stacks grow,
how compilers generate code, how registers are used, etc.


| On Sun, 10 Aug 2003, war wrote:
| 
| > Unable to handle kernel NULL pointer dereference at virtual address 00000000

Some code tried to reference address 0.  There is nothing mapped
at address 0 on purpose, to catch errant code such as this.

| >  printing eip:
| > c0131906

EIP is the (Extended) Instruction Pointer register, aka the next
instruction pointer.  It points just beyond the current (faulting)
instruction.

| > *pde = 00000000
| > Oops: 0002

This value is the page fault error code: (from source code):
 * error_code:
 *	bit 0 == 0 means no page found, 1 means protection fault
 *	bit 1 == 0 means read, 1 means write
 *	bit 2 == 0 means kernel, 1 means user-mode

| > CPU:    0
| > EIP:    0010:[<c0131906>]    Not tainted
0010 is the CS register value (Code segment selector).

| > EFLAGS: 00010246

i386 EFlags register

| > eax: c0306a18   ebx: 00000000   ecx: c250fffc   edx: 00000000

i386 general-purpose (GP) registers

| > esi: c250ffe0   edi: 0001328a   ebp: c0306c40   esp: c2821f40

i386 index and stack registers

| > ds: 0018   es: 0018   ss: 0018

These are the other i386 segment/selector registers.

| > Process kswapd (pid: 5, stackpage=c2821000)
| > Stack: c2095dd0 000001d0 000001ff 000001d0 00000016 0000001f 000001d0 00000020
| >        00000006 c0131ca3 00000006 c0306b90 c0306c40 000001d0 00000006 c0306c40
| >        00000000 c0131d1e 00000020 c0306c40 00000002 c2820000 c0131e3c c0306c40

Kernel stack, beginning at top of stack.

| > Call Trace:    [<c0131ca3>] [<c0131d1e>] [<c0131e3c>] [<c0131eb8>] [<c0131fe8>]
| >   [<c0131f50>] [<c0105000>] [<c01057ae>] [<c0131f50>]

show_trace() tries to pick out kernel text addresses from the stack
and only print those addresses.  Running this thru ksymoops
with a matching System.map file will decode these addresses into
kernel function names.

| > Code: 89 02 c7 01 00 00 00 00 89 50 04 a1 18 6a 30 c0 89 48 04 89


That was fairly straightforward.  Did it help any?

--
~Randy
