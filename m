Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315603AbSEIDxs>; Wed, 8 May 2002 23:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315604AbSEIDxr>; Wed, 8 May 2002 23:53:47 -0400
Received: from melancholia.rimspace.net ([210.23.138.19]:40975 "EHLO
	melancholia.danann.net") by vger.kernel.org with ESMTP
	id <S315603AbSEIDxr>; Wed, 8 May 2002 23:53:47 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: Linux-2.5.14..
In-Reply-To: <Pine.LNX.4.44.0205060811360.2540-100000@home.transmeta.com>
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
Date: Thu, 09 May 2002 13:53:39 +1000
Message-ID: <87n0va0yf0.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.5 (bamboo,
 i686-pc-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Linus Torvalds wrote:
> On Mon, 6 May 2002, Daniel Pittman wrote:
>>
>> From the look of the changelog at least a few of the file corruption
>> bugs with ext3, 2k block file systems and 2.5 have been fixed. Should
>> I expect this release to address the problems I was seeing?
> 
> "Expect" is too strong a word. I'd say "hope" - a number of truncate
> bugs were fixed, but whether that was what bit you, nobody knows.
> 
> I suspect the real answer is that we'd love for you to test things
> out, but that if it ends up being too painful to recover if the
> problems happen again, you probably shouldn't..

Right. I got brave enough to test it on a real, live system after
extensive fake testing. It seems to work well, at least so far as
running the same workload that cause massive file corruption correctly.

So, I believe that 2.5.14 is working correctly with 2k ext3 filesystems,
at least for minimal use. I didn't do any sort of extreme load testing
or anything like that, being cautious about it.

On reboot, I got an assertion in ext3, though, and the following BUG
trace. So, something still isn't well, but it seems to be getting it
much more right. :)

        Daniel

ksymoops 2.4.5 on i686 2.5.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.6/ (default)
     -m /boot/System.map-2.5.14 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Invalid Operand: 0000
CPU: 0
EIP: 0010:[<c015cf45>] Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
EAX: 00000061 EBX: dc883900 ECX: c14ee080 EDX: df954ca0
ESI: dd36d200 EDI: dfd53600 EBP: d0d805c0 ESP: c14f1e6c
DS: 0018 ES: 0018 SS: 0018
Stack: c02c0060 c02c04e1 c02c0040 00000460 c02c0537 d2821380 d0d805c0 00000000
       c14f1f04 c01557fd d0d805c0 d2821380 d2821380 00000800 d2821380 00000800
       00000800 000000c0 c015555c d0d805c0 d2821380 0005f700 00000000 bfd71c00
Call Trace: [<c01557fd>] [<c015555c0>] [<c0155909>] [<c01557e4>] [<c0126bab>]
            [<c01535fa>] [<c0132576>] [<c0106c97>]
Code: 0f 0b 60 04 40 00 2c c0 83 c4 14 6a 03 8b 45 00 50 53 e8 1c


>>EIP; c015cf45 <journal_dirty_metadata+13d/174>   <=====

>>EBX; dc883900 <END_OF_CODE+1c4d838c/????>
>>ECX; c14ee080 <END_OF_CODE+1142b0c/????>
>>EDX; df954ca0 <END_OF_CODE+1f5a972c/????>
>>ESI; dd36d200 <END_OF_CODE+1cfc1c8c/????>
>>EDI; dfd53600 <END_OF_CODE+1f9a808c/????>
>>EBP; d0d805c0 <END_OF_CODE+109d504c/????>
>>ESP; c14f1e6c <END_OF_CODE+11468f8/????>

Trace; c01557fd <commit_write_fn+19/5c>
Trace; c015555c0 <END_OF_CODE+b411aa04c/????>
Trace; c0155909 <ext3_commit_write+c9/1e4>
Trace; c01557e4 <commit_write_fn+0/5c>
Trace; c0126bab <generic_file_write+4c3/6e4>
Trace; c01535fa <ext3_file_write+46/4c>
Trace; c0132576 <sys_write+96/f0>
Trace; c0106c97 <syscall_call+7/b>

Code;  c015cf45 <journal_dirty_metadata+13d/174>
00000000 <_EIP>:
Code;  c015cf45 <journal_dirty_metadata+13d/174>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015cf47 <journal_dirty_metadata+13f/174>
   2:   60                        pusha  
Code;  c015cf48 <journal_dirty_metadata+140/174>
   3:   04 40                     add    $0x40,%al
Code;  c015cf4a <journal_dirty_metadata+142/174>
   5:   00 2c c0                  add    %ch,(%eax,%eax,8)
Code;  c015cf4d <journal_dirty_metadata+145/174>
   8:   83 c4 14                  add    $0x14,%esp
Code;  c015cf50 <journal_dirty_metadata+148/174>
   b:   6a 03                     push   $0x3
Code;  c015cf52 <journal_dirty_metadata+14a/174>
   d:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c015cf55 <journal_dirty_metadata+14d/174>
  10:   50                        push   %eax
Code;  c015cf56 <journal_dirty_metadata+14e/174>
  11:   53                        push   %ebx
Code;  c015cf57 <journal_dirty_metadata+14f/174>
  12:   e8 1c 00 00 00            call   33 <_EIP+0x33> c015cf78 <journal_dirty_metadata+170/174>


1 error issued.  Results may not be reliable.

-- 
The artistic temperment is a disease which afflicts amateurs.
        -- G. K. Chesterton, _Heretics_, 1905
