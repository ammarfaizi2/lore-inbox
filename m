Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVC1QSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVC1QSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVC1QSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:18:30 -0500
Received: from alog0221.analogic.com ([208.224.220.236]:11728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261911AbVC1QSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:18:13 -0500
Date: Mon, 28 Mar 2005 11:17:37 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Ara Avanesyan <araav@hylink.am>
cc: Linux kernel <linux-kernel@vger.kernel.org>, avila@lists.unixstudios.net
Subject: Re: Strange memory problem with Linux booted from U-Boot
In-Reply-To: <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
Message-ID: <Pine.LNX.4.61.0503281113440.5098@chaos.analogic.com>
References: <006b01c5047e$1efc78a0$1000000a@araavanesyan>
 <20050127144441.GB4848@home.fluff.org> <00ae01c533a6$85ddf1f0$1000000a@araavanesyan>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-453923945-1112026657=:5098"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-453923945-1112026657=:5098
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


I tried your program with several 'val' values including ~0 and
0. The results were the same. In spite of using character pointers
on large negative integers, everything worked. What was the observed
kernel problem?? Perhaps, the kernel's printk() was not as kind
as g++ and you got some strange printed results??

On Mon, 28 Mar 2005, Ara Avanesyan wrote:

> Hi,
>
> I need some help on solving this strange problem.
> Here is what I have,
> I have a loadable module (linux.2.4.20) which contains a 2 mb static gloabal
> array.
> When I load it from linux booted via U-Boot the system crashes.
> Everything works ok if I do the same thing with the same linux booted with
> RedBoot.
> Before loading the module I check the current meminfo and get the same
> result both times.
>
> Additional information:
> The same error occurs if I just run depmod -a.
>
> system: Avila board 64 MB RAM, ixdp425 architecture, U-Boot: 1.1.2.
> Linux is MontaVista(R) Linux(R) Professional Edition 3.1.
>
> Ok, now an amazing reproduction of the same problem from user mode:
> the code below works for val = (~0), but not for 0, or even (~ff).
> Again, it works fine for linux booted from RedBoot.
>
> Some glue or something where and what to look?
> Any ideas of what potentially could cause this problem?
>
> Please CC me on reply.
>
> Thanks!
> Ara
>
> Several days ago I posted this question to U-boot mailing list but got not
> much help there:)
>
> ____
> error message:
> Unable to handle kernel paging request at virtual address e59f30f8
> mm = c000a320 pgd = c3e60000
> *pgd = 00000000, *pmd = 00000000
> Internal error: Oops: 0
> CPU: 0
> pc 2 [<c0054f64>]    lr : [<00000000>]    Tainted: GF
> sp : c3e45e94  ip : c3e45eb4  fp : c3e45eb0
> r10: 00000000  r9 : c3e45f04  r8 : 00000004
> r7 : 00000004  r6 : c016a000  r5 : c3e44000  r4 : e59f3054
> r3 : e91ba870  r2 : c019cc70  r1 : 00000000  r0 : 00000000
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32 Control: 39FF  Table: 03E60000
> DAC: 00000015
> Process klogd (pid: 89, stack limit = 0xc3e443a0)
> Stack: (0xc3e45e94 to 0xc3e46000)
>
> ___
> Now the (user level) code:
>
> #include <iostream>
>
> using namespace std;
>
> const int pass = 64;
> const int size = 2 * 1024 * 1024;
> const int val = 0xffffff00;
> int main()
> {
>    cout << "starting val == " << hex << val << endl;
>    char *buf = new char[size];
>    cout << "allocated memory of " << size << " bytes. buf == " << (int)buf
> << endl;
>
>    for (int j = 0; j < pass; j++)
>    {
>        cout << "passing " << j << endl;
>        for (int i = 0; i < size; i++)
>        {
>            buf[i] = val;
>        }
>        cout << "passed" << endl;
>    }
>
>    cout << "freeing" << endl;
>    delete []buf;
>    cout << "finished!" << endl;
>    return 0;
> }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-453923945-1112026657=:5098
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=typescript
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0503281117370.5098@chaos.analogic.com>
Content-Description: 
Content-Disposition: attachment; filename=typescript

U2NyaXB0IHN0YXJ0ZWQgb24gTW9uIDI4IE1hciAyMDA1IDExOjEyOjI2IEFN
IEVTVA0KTElOVVg+IGcrKyAtbyB4eHggLVdhbGwgLU8yIHh4eC5jcHANDQpM
SU5VWD4gLi94eHgNDQpzdGFydGluZyB2YWwgPT0gZmZmZmZmZmYNDQphbGxv
Y2F0ZWQgbWVtb3J5IG9mIDIwMDAwMCBieXRlcy4gYnVmID09IGI3ZGRlMDA4
DQ0KcGFzc2luZyAwDQ0KcGFzc2VkDQ0KcGFzc2luZyAxDQ0KcGFzc2VkDQ0K
cGFzc2luZyAyDQ0KcGFzc2VkDQ0KcGFzc2luZyAzDQ0KcGFzc2VkDQ0KcGFz
c2luZyA0DQ0KcGFzc2VkDQ0KcGFzc2luZyA1DQ0KcGFzc2VkDQ0KcGFzc2lu
ZyA2DQ0KcGFzc2VkDQ0KcGFzc2luZyA3DQ0KcGFzc2VkDQ0KcGFzc2luZyA4
DQ0KcGFzc2VkDQ0KcGFzc2luZyA5DQ0KcGFzc2VkDQ0KcGFzc2luZyBhDQ0K
cGFzc2VkDQ0KcGFzc2luZyBiDQ0KcGFzc2VkDQ0KcGFzc2luZyBjDQ0KcGFz
c2VkDQ0KcGFzc2luZyBkDQ0KcGFzc2VkDQ0KcGFzc2luZyBlDQ0KcGFzc2Vk
DQ0KcGFzc2luZyBmDQ0KcGFzc2VkDQ0KcGFzc2luZyAxMA0NCnBhc3NlZA0N
CnBhc3NpbmcgMTENDQpwYXNzZWQNDQpwYXNzaW5nIDEyDQ0KcGFzc2VkDQ0K
cGFzc2luZyAxMw0NCnBhc3NlZA0NCnBhc3NpbmcgMTQNDQpwYXNzZWQNDQpw
YXNzaW5nIDE1DQ0KcGFzc2VkDQ0KcGFzc2luZyAxNg0NCnBhc3NlZA0NCnBh
c3NpbmcgMTcNDQpwYXNzZWQNDQpwYXNzaW5nIDE4DQ0KcGFzc2VkDQ0KcGFz
c2luZyAxOQ0NCnBhc3NlZA0NCnBhc3NpbmcgMWENDQpwYXNzZWQNDQpwYXNz
aW5nIDFiDQ0KcGFzc2VkDQ0KcGFzc2luZyAxYw0NCnBhc3NlZA0NCnBhc3Np
bmcgMWQNDQpwYXNzZWQNDQpwYXNzaW5nIDFlDQ0KcGFzc2VkDQ0KcGFzc2lu
ZyAxZg0NCnBhc3NlZA0NCnBhc3NpbmcgMjANDQpwYXNzZWQNDQpwYXNzaW5n
IDIxDQ0KcGFzc2VkDQ0KcGFzc2luZyAyMg0NCnBhc3NlZA0NCnBhc3Npbmcg
MjMNDQpwYXNzZWQNDQpwYXNzaW5nIDI0DQ0KcGFzc2VkDQ0KcGFzc2luZyAy
NQ0NCnBhc3NlZA0NCnBhc3NpbmcgMjYNDQpwYXNzZWQNDQpwYXNzaW5nIDI3
DQ0KcGFzc2VkDQ0KcGFzc2luZyAyOA0NCnBhc3NlZA0NCnBhc3NpbmcgMjkN
DQpwYXNzZWQNDQpwYXNzaW5nIDJhDQ0KcGFzc2VkDQ0KcGFzc2luZyAyYg0N
CnBhc3NlZA0NCnBhc3NpbmcgMmMNDQpwYXNzZWQNDQpwYXNzaW5nIDJkDQ0K
cGFzc2VkDQ0KcGFzc2luZyAyZQ0NCnBhc3NlZA0NCnBhc3NpbmcgMmYNDQpw
YXNzZWQNDQpwYXNzaW5nIDMwDQ0KcGFzc2VkDQ0KcGFzc2luZyAzMQ0NCnBh
c3NlZA0NCnBhc3NpbmcgMzINDQpwYXNzZWQNDQpwYXNzaW5nIDMzDQ0KcGFz
c2VkDQ0KcGFzc2luZyAzNA0NCnBhc3NlZA0NCnBhc3NpbmcgMzUNDQpwYXNz
ZWQNDQpwYXNzaW5nIDM2DQ0KcGFzc2VkDQ0KcGFzc2luZyAzNw0NCnBhc3Nl
ZA0NCnBhc3NpbmcgMzgNDQpwYXNzZWQNDQpwYXNzaW5nIDM5DQ0KcGFzc2Vk
DQ0KcGFzc2luZyAzYQ0NCnBhc3NlZA0NCnBhc3NpbmcgM2INDQpwYXNzZWQN
DQpwYXNzaW5nIDNjDQ0KcGFzc2VkDQ0KcGFzc2luZyAzZA0NCnBhc3NlZA0N
CnBhc3NpbmcgM2UNDQpwYXNzZWQNDQpwYXNzaW5nIDNmDQ0KcGFzc2VkDQ0K
ZnJlZWluZw0NCmZpbmlzaGVkIQ0NCkxJTlVYPiBleGl0DQ0KDQpTY3JpcHQg
ZG9uZSBvbiBNb24gMjggTWFyIDIwMDUgMTE6MTI6NTkgQU0gRVNUDQo=

--1879706418-453923945-1112026657=:5098--
