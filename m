Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTLGOuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 09:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTLGOuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 09:50:52 -0500
Received: from intra.cyclades.com ([64.186.161.6]:59570 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264428AbTLGOuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 09:50:50 -0500
Date: Sun, 7 Dec 2003 12:40:10 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mark Symonds <mark@symonds.net>
Cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Harald Welte <laforge@netfilter.org>
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <049e01c3bca9$0eae8880$7a01a8c0@gandalf>
Message-ID: <Pine.LNX.4.44.0312071236430.1283-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The first oops looks like:

Unable to handle kernel NULL pointer
dereference at virtual address: 00000000

printing eip:
c02363dd
*pde=00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c02363d>]  Not tainted
EFLAGS: 00010217

eax: 00000006   ebx: 00000000  ecx: 7a01a8c0   ecx: c700b2a0
esi: c0299ce0   edi: 000001b7  ebp: c0299d94   esp: c0299c54
ds: 0018  es: 0018  ss: 0018

process: swapper (pid: 0, stackpage = c0299000)


Isnt it a bit weird that the full backtrace is not reported ? 

wli suggests that might stack corruption.


I dont see any suspicious change around tcp_print_conntrack().

Any clues? 



On Sun, 7 Dec 2003, Mark Symonds wrote:

> 
> [...]
> > 
> > addr2line requires compiling with -g.  You can also do
> >   ksymoops -m /path/to/your/System.map -A c02363dd
> > which does not require a recompile.
> > 
> 
> Excellent, this is alot easier.  Should note that this 
> kernel is compiled without support for loadable modules.
> Here goes: 
> 
> ------------- 
> 
> puggy:/usr/src/linux/2.4.23# ksymoops -m ./System.map -A c02363dd
> ksymoops 2.4.9 on i686 2.4.23.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.23/ (default)
>      -m ./System.map (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> 
> 
> Adhoc c02363dd <tcp_print_conntrack+2d/60>
> 
> 1 error issued.  Results may not be reliable.
> puggy:/usr/src/linux/2.4.23#






