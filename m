Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314486AbSDRXIc>; Thu, 18 Apr 2002 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSDRXIb>; Thu, 18 Apr 2002 19:08:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:4107 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314486AbSDRXIa>;
	Thu, 18 Apr 2002 19:08:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-pre7 oops 
In-Reply-To: Your message of "Thu, 18 Apr 2002 12:40:59 -0400."
             <007401c1e6f7$d213d430$e1de11cc@csihq.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Apr 2002 09:08:19 +1000
Message-ID: <6232.1019171299@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 12:40:59 -0400, 
"Mike Black" <mblack@csihq.com> wrote:
>Apr 18 12:08:32 yeti kernel: Unable to handle kernel NULL pointer
>dereference at virtual address 00000006
>Apr 18 12:08:32 yeti kernel: f8826437
>Apr 18 12:08:32 yeti kernel: *pde = 00000000
>Apr 18 12:08:32 yeti kernel: Oops: 0000
>Apr 18 12:08:32 yeti kernel: CPU:    1
>Apr 18 12:08:32 yeti kernel: EIP:
>0010:[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-27744
>9/96]    Tainted: P
>Apr 18 12:08:32 yeti kernel: EFLAGS: 00010246
>Apr 18 12:08:32 yeti kernel: eax: 00000000   ebx: f5870dc0   ecx: 00000002
>edx: f5daed60
>Apr 18 12:08:32 yeti kernel: esi: f5ab7c00   edi: f5daec00   ebp: f5daec00
>esp: f59fbe88
>Apr 18 12:08:32 yeti kernel: ds: 0018   es: 0018   ss: 0018
>Apr 18 12:08:32 yeti kernel: Process raid5d (pid: 17544, stackpage=f59fb000)
>Apr 18 12:08:32 yeti kernel: Stack: 00000000 f5daec00 f5ab7c00 f5fa1de0
>00000001 00000001 000000f8 c011cf73
>Apr 18 12:08:32 yeti kernel:        00000000 c009ec00 f5ab7d58 f59fbf24
>f5ab7cec f5ab7c80 f5daec14 00000000
>Apr 18 12:08:32 yeti kernel:        f5ab7c14 00000000 00000001 00000001
>00000001 0000000c 00000001 ffffffff
>Apr 18 12:08:32 yeti kernel: Call Trace: [tasklet_hi_action+103/160]
>[nfs:__insmod_nfs_O/lib/modules/2.4.19-pre7/kernel/fs/nfs/nfs.o_+-275842/96]
>[md_thread+341/440] [kernel_thread+40/56]
>Apr 18 12:08:32 yeti kernel: Code: 8b 41 04 50 e8 d8 5a 9a c7 00 00 00 00 74
>51 83 7c 24 7c 00
>Using defaults from ksymoops -t elf32-i386 -a i386
>
>
>>>ebx; f5870dc0 <_end+3553350c/384df74c>
>>>edx; f5daed60 <_end+35a714ac/384df74c>
>>>esi; f5ab7c00 <_end+3577a34c/384df74c>
>>>edi; f5daec00 <_end+35a7134c/384df74c>
>>>ebp; f5daec00 <_end+35a7134c/384df74c>
>>>esp; f59fbe88 <_end+356be5d4/384df74c>

I do not trust that ksymoops output at all.  To start with, klogd has
stamped on the real numbers and replaced them with useless lookups.
Always disable klogd oops decoding, run as 'klogd -x'.  Secondly the
registers make no sense, it appears that you ran ksymoops against a
kernel without the modules loaded so the address lookup is meaningless.
You need to tell ksymoops which modules were loaded at the time of the
oops and where they were.  man insmod and look for /var/log/ksymoops.

