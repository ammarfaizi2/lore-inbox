Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTLRHdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbTLRHdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:33:49 -0500
Received: from moof.zeroth.org ([203.117.131.35]:62730 "EHLO moof.zeroth.org")
	by vger.kernel.org with ESMTP id S264960AbTLRHdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:33:46 -0500
Message-ID: <3FE15845.1040508@metaparadigm.com>
Date: Thu, 18 Dec 2003 15:33:25 +0800
From: Jamie Clark <jclark@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 ext3 oops
References: <3FA713B9.3040405@metaparadigm.com>	 <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com>	 <20031206010505.GB14904@dualathlon.random>	 <3FD7D78A.4080409@metaparadigm.com>	 <1071661358.13152.26.camel@imladris.demon.co.uk>	 <3FE14706.3070003@metaparadigm.com> <1071728709.5316.2.camel@imladris.demon.co.uk>
In-Reply-To: <1071728709.5316.2.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>Odd. And what's 'inode' then? What compiler are you using?
>  
>
Debian woody  gcc 2.95.4

The code emitted at the start of precheck_file_write is:

precheck_file_write:
        pushl %ebp
        pushl %edi
        pushl %esi
        pushl %ebx
        movl 24(%esp),%ebp
        movl 32(%esp),%edx
        movl $-8192,%eax
[...]

I guessed inode to be ebp. the oops text copied from serial console (I 
lost the first line):

c01306fb
*pde = 00000000
Oops: 0002 2.4.23aa1 #12 SMP Thu Dec 11 11:25:47 SGT 2003
CPU:    1
EIP:    0010:[<c01306fb>]    Not tainted
EFLAGS: 00010206
eax: 00008000   ebx: 12ba4000   ecx: ffffffff   edx: f3a8ff48
esi: 00000000   edi: 00000000   ebp: c3526200   esp: f3a8feec
ds: 0018   es: 0018   ss: 0018
Process bonnie++ (pid: 316, stackpage=f3a8f000)
Stack: e7d715c0 c3526200 e7d715a0 00002000 c01308f8 e7d715a0 c3526200 
f3a8ff60
       f3a8ff48 c352626c c3526200 e7d715a0 00002000 f3a8ff44 0061a931 
00001000
       00000000 00001000 00001000 00000000 c3526200 c35262c4 00000000 
12ba4000
Call Trace:         [<c01308f8>] (88) [<c013108f>] (36) [<c016f3a7>] (36)
  [<c0140e57>] (36) [<c0107133>] (60)
Code: 00 60 74 15 8b 7c 24 14 f6 47 19 04 74 0b 8b 5d 44 8b 75 48

I'm now a little less confident about that last crash because I was a 
bit hasty in getting another run started. I have since trampled over the 
supporting evidence (kernel, map, build output).


