Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWJEOfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWJEOfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWJEOfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:35:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54190 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932084AbWJEOfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:35:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: vgoyal@in.ibm.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       "Magnus Damm" <magnus@valinux.co.jp>
Subject: Re: 2.6.19-rc1: kexec broken on x86_64
References: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com>
	<20061005134522.GB20551@in.ibm.com>
	<aec7e5c30610050656u6d287752pc9d1bcbb807442d3@mail.gmail.com>
Date: Thu, 05 Oct 2006 08:33:53 -0600
In-Reply-To: <aec7e5c30610050656u6d287752pc9d1bcbb807442d3@mail.gmail.com>
	(Magnus Damm's message of "Thu, 5 Oct 2006 22:56:51 +0900")
Message-ID: <m1lknu4ysu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> Hi Vivek,
>
> On 10/5/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
>> On Thu, Oct 05, 2006 at 07:28:35PM +0900, Magnus Damm wrote:
>> > Kexec is broken on x86_64 under 2.6.19-rc1.
>> >
>> > Or rather - kexec works ok under 2.6.19-rc1, but something related to
>> > the vmlinux format has probably changed and kexec-tools fails to load
>> > a vmlinux from 2.6.19-rc1.
>> >
>> > Loading bzImage works as usual, but vmlinux does not load properly.
>> >
>> > The kexec binary fails with the following message:
>> >
>> > Overlapping memory segments at 0x351000
>> > sort_segments failed
>> > / #
>> >
>>
>> Hi Magnus,
>>
>> Can you please post the readelf -l output of the vmlinux you are trying
>> to load. That's will give some indication if the segments are really
>> overlapping in vmlinux or is it some processing bug at kexec-tools part.
>
> Elf file type is EXEC (Executable file)
> Entry point 0x100100
> There are 4 program headers, starting at offset 64
>
> Program Headers:
>  Type           Offset             VirtAddr           PhysAddr
>                 FileSiz            MemSiz              Flags  Align
>  LOAD           0x0000000000100000 0xffffffff80100000 0x0000000000100000
>                 0x00000000001a4888 0x00000000001a4888  R E    100000
>  LOAD           0x00000000002a5000 0xffffffff802a5000 0x00000000002a5000
>                 0x000000000008e086 0x00000000000c1504  RWE    100000
>  LOAD           0x0000000000400000 0xffffffffff600000 0x00000000002fd000
>                 0x0000000000000c08 0x0000000000000c08  RWE    100000
>  NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                 0x0000000000000000 0x0000000000000000  R      8
>
> Section to Segment mapping:
>  Segment Sections...
>   00     .text __ex_table .rodata .pci_fixup __ksymtab __ksymtab_gpl
> __ksymtab_unused __ksymtab_strings __param
>   01     .data .data.cacheline_aligned .data.read_mostly
> .data.init_task .data.page_aligned .init.text .init.data .init.setup
> .initcall.init .con_initcall.init .altinstructions
> .altinstr_replacement .exit.text .init.ramfs .bss
>   02     .vsyscall_0 .xtime_lock .vxtime .vgetcpu_mode .sys_tz
> .sysctl_vsyscall .xtime .jiffies .vsyscall_1 .vsyscall_2 .vsyscall_3
>   03
>
> Thanks,

Ok.  There does not appear anything here that is not page aligned.  So
it looks like something is triggering a kexec-tools bug.

Eric

