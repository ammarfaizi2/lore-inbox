Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbTHZUpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTHZUpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:45:52 -0400
Received: from smtp0.libero.it ([193.70.192.33]:4086 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262916AbTHZUpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:45:49 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
Date: Tue, 26 Aug 2003 22:48:31 +0000
User-Agent: KMail/1.5.1
Cc: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0308261811240.1021-100000@neptune.local> <1061923890.17230.30.camel@sisko.scot.redhat.com>
In-Reply-To: <1061923890.17230.30.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308262248.31362.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 18:51, Stephen C. Tweedie wrote:
> Hi,
>
> On Tue, 2003-08-26 at 17:15, Pascal Schmidt wrote:
> > Sigh. I spoke too soon. Turns out I have two different versions of
> > fsx.c around. The one that caused the BUG before still does, but
> > it's a different one now:
>
> OK, could you send me both of your versions so that I can try them
> here?  I've got an uptodate fsx around myself, but not necessarily the
> same version as you, and evidently the precise version matters here.

I've just got a similar oops from 2.4.21

Aug 26 22:01:34 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 10108)
Aug 26 22:01:34 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 10108)
Aug 26 22:01:59 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9824)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9600)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9601)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9595)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 8923)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9608)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9608)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9609)
Aug 26 22:02:09 odyssey kernel: Unexpected dirty buffer encountered at 
do_get_write_access:616 (03:42 blocknr 9609)
Aug 26 22:02:09 odyssey kernel: Assertion failure in journal_dirty_metadata() 
at transaction.c:1164: "jh->b_frozen_data == 0"

ksymoops 2.4.8 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map-2.4.21 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 26 22:02:09 odyssey kernel: kernel BUG at transaction.c:1164!
Aug 26 22:02:09 odyssey kernel: invalid operand: 0000
Aug 26 22:02:09 odyssey kernel: CPU:    0
Aug 26 22:02:09 odyssey kernel: EIP:    0010:[journal_dirty_metadata+411/496]    
Not tainted
Aug 26 22:02:09 odyssey kernel: EFLAGS: 00010282
Aug 26 22:02:09 odyssey kernel: eax: 00000061   ebx: de8c94c0   ecx: dd786000   
edx: deaf7f7c
Aug 26 22:02:09 odyssey kernel: esi: c1593cf4   edi: c1593c80   ebp: dc6f88c0   
esp: dd787e68
Aug 26 22:02:09 odyssey kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 22:02:09 odyssey kernel: Process fsx-linux (pid: 554, 
stackpage=dd787000)
Aug 26 22:02:09 odyssey kernel: Stack: c0248f80 c024652a c0246c9d 0000048c 
c0246e0e df19b570 dcc15e40 dc6f88c0
Aug 26 22:02:09 odyssey kernel:        00000000 00001000 c015a5b4 dc6f88c0 
dcc15e40 c015a27f dc6f88c0 dcc15e40
Aug 26 22:02:09 odyssey kernel:        00001000 c0161f9b dcc15e40 dcc15e40 
00001000 c015a251 dc6f88c0 c6330200
Aug 26 22:02:09 odyssey kernel: Call Trace:    [commit_write_fn+36/128] 
[do_journal_get_write_access+31/128] [new_handle+75/112] 
[walk_page_buffers+113/128] [ext3_commit_write+139/512]
Aug 26 22:02:09 odyssey kernel: Code: 0f 0b 8c 04 9d 6c 24 c0 eb ad c7 44 24 
10 c0 b2 24 c0 c7 44
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; de8c94c0 <_end+1e5dde00/205489c0>
>>ecx; dd786000 <_end+1d49a940/205489c0>
>>edx; deaf7f7c <_end+1e80c8bc/205489c0>
>>esi; c1593cf4 <_end+12a8634/205489c0>
>>edi; c1593c80 <_end+12a85c0/205489c0>
>>ebp; dc6f88c0 <_end+1c40d200/205489c0>
>>esp; dd787e68 <_end+1d49c7a8/205489c0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   8c 04 9d 6c 24 c0 eb      movl   %es,0xebc0246c(,%ebx,4)
Code;  00000009 Before first symbol
   9:   ad                        lods   %ds:(%esi),%eax
Code;  0000000a Before first symbol
   a:   c7 44 24 10 c0 b2 24      movl   $0xc024b2c0,0x10(%esp,1)
Code;  00000011 Before first symbol
  11:   c0
Code;  00000012 Before first symbol
  12:   c7 44 00 00 00 00 00      movl   $0x0,0x0(%eax,%eax,1)
Code;  00000019 Before first symbol
  19:   00


1 warning issued.  Results may not be reliable.


I can reproduce the 2.4.22 oops too..

