Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284243AbRLLAhH>; Tue, 11 Dec 2001 19:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284373AbRLLAg6>; Tue, 11 Dec 2001 19:36:58 -0500
Received: from air-1.osdl.org ([65.201.151.5]:37647 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284243AbRLLAgt>;
	Tue, 11 Dec 2001 19:36:49 -0500
Date: Tue, 11 Dec 2001 16:31:34 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Berend De Schouwer <bds@jhb.ucs.co.za>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: {multiple} Kernel Oops on cat /proc/ioports
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za>
Message-ID: <Pine.LNX.4.33L2.0112111628380.4033-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2001, Berend De Schouwer wrote:

| [1.] One line summary of the problem:
|
| Running "cat /proc/ioports" causes a segfault and kernel oops.

| >>EIP; c02a925b <vsnprintf+20b/420>   <=====
| Trace; c02a94a6 <vsprintf+16/20>
| Trace; c02a94c4 <sprintf+14/20>
| Trace; c011dcfb <do_resource_list+4b/80>
| Trace; c011dd1b <do_resource_list+6b/80>
| Trace; c011dd72 <get_resource_list+42/60>
| Trace; c0154eae <ioports_read_proc+2e/60>
| Trace; c0152a3e <proc_file_read+ce/190>
| Trace; c01368f6 <sys_read+96/d0>
| Trace; c0127caa <sys_brk+ba/f0>
| Trace; c010712b <system_call+33/38>
| Code;  c02a925b <vsnprintf+20b/420>
| 00000000 <_EIP>:
| Code;  c02a925b <vsnprintf+20b/420>   <=====
|    0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
| Code;  c02a925e <vsnprintf+20e/420>
|    3:   74 07                     je     c <_EIP+0xc> c02a9267 <vsnprintf+217/420>
| Code;  c02a9260 <vsnprintf+210/420>
|    5:   40                        inc    %eax
| Code;  c02a9261 <vsnprintf+211/420>
|    6:   4a                        dec    %edx
| Code;  c02a9262 <vsnprintf+212/420>
|    7:   83 fa ff                  cmp    $0xffffffff,%edx
| Code;  c02a9265 <vsnprintf+215/420>
|    a:   75 f4                     jne    0 <_EIP>
| Code;  c02a9267 <vsnprintf+217/420>
|    c:   29 c8                     sub    %ecx,%eax
| Code;  c02a9269 <vsnprintf+219/420>
|    e:   f6 04 24 10               testb  $0x10,(%esp,1)
| Code;  c02a926d <vsnprintf+21d/420>
|   12:   89 c6                     mov    %eax,%esi


There have been 3 reports of Oops in vsnprintf() recently [more
precisely, in inline strnlen() ]:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100277148326190&w=2
  printing /proc/ioports

http://marc.theaimsgroup.com/?l=linux-kernel&m=100680451811435&w=2
  usb device connect/disconnect

http://marc.theaimsgroup.com/?l=linux-kernel&m=100807421108830&w=2
  printing /proc/ioports

It would be easy to paste over the problem in vsnprintf(), but
they indicate to me that something else is screwy.

-- 
~Randy

