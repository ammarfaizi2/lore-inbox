Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUJ3XBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUJ3XBV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUJ3W7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:59:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:53170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbUJ3Wzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:55:33 -0400
Message-ID: <41841AB8.1070109@osdl.org>
Date: Sat, 30 Oct 2004 15:50:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolando Espinoza La Fuente <rhodas@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27 java process, Kernel bug at file.c:66
References: <94b391ae0410300640496a1e1c@mail.gmail.com>
In-Reply-To: <94b391ae0410300640496a1e1c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolando Espinoza La Fuente wrote:
> Hi, this is my first message to lkml. (my english isnt good.. =/ )
> 
> i have this:
> 
> kernel BUG at file.c:66!

In 2.4.27, this must be fs/fat/file.c line # 66:

     65          if (iblock << sb->s_blocksize_bits != 
MSDOS_I(inode)->mmu_private) {
     66                  BUG();
     67                  return -EIO;
     68          }


> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c017656f>]    Tainted: P 
> EFLAGS: 00013287
> eax: 000d1000   ebx: 000d1200   ecx: 00000009   edx: 00000000
> esi: 00000688   edi: c8fe8bc0   ebp: c8fa5d40   esp: c9ef7e44
> ds: 0018   es: 0018   ss: 0018
> Process java (pid: 7050, stackpage=c9ef7000)
> Stack: 00000009 cd34d800 00000200 00000000 c13fbf7c 00000688 c01390cd c8fe8bc0 
>        00000688 c8fa5d40 00000001 c8fa5d40 c8f83000 c9ef7e88 00000200 c0178269 
>        c8fa5d40 0000315d c8fe8bc0 000000d1 c118aaa0 c13fbf7c 00000009 c013971a 
> Call Trace:    [<c01390cd>] [<c0178269>] [<c013971a>] [<c0176490>] [<c0178025>]
>   [<c0176490>] [<c012b195>] [<c012b663>] [<c01765e1>] [<c01765b9>] [<c0136988>]
>   [<c0108a93>]
> 
> Code: 0f 0b 42 00 1b ec 2e c0 ba fb ff ff ff e9 4c ff ff ff eb 0d 

Please see the REPORTING-BUGS file in the linux source tree
top-level directory for how to report bugs and also
Documentation/oops-tracing.txt for how to use ksymoops.
The Oops above needs to be run thru ksymoops.


> rolando@rolando:~$ uname -a ; java -version
> Linux rolando 2.4.27 #6 Thu Sep 16 20:35:47 PDT 2004 i686 unknown
> unknown GNU/Linux
> java version "1.4.2_04"
> Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_04-b05)
> Java HotSpot(TM) Client VM (build 1.4.2_04-b05, mixed mode)
> rolando@rolando:~$ 
> 
> I am using Slackware-current. i have using java with azureus
> (bittorrent client), and now, azureus doesnt start.


-- 
~Randy
