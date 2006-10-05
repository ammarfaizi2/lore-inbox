Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWJEN4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWJEN4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 09:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWJEN4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 09:56:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:6070 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750997AbWJEN4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 09:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fl3cVyzX6YnujGtt2oaWKAremUNWdGoLN0fI5eYxm3OnX4RCrZej9IDMbouJAMPeOvUTsubzt2g8yBLHVWsYgCW4AE3/Pqfeham1LIs+2qsrdLkvBoS1kDLeNw5XijPfsFarG+s32e3LqSfkV3O4bLYwaeZWw5cYlUFXpRGY36E=
Message-ID: <aec7e5c30610050656u6d287752pc9d1bcbb807442d3@mail.gmail.com>
Date: Thu, 5 Oct 2006 22:56:51 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: 2.6.19-rc1: kexec broken on x86_64
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Horms <horms@verge.net.au>, "Magnus Damm" <magnus@valinux.co.jp>
In-Reply-To: <20061005134522.GB20551@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <aec7e5c30610050328i2bf9e3b6qcacc1873231ece28@mail.gmail.com>
	 <20061005134522.GB20551@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 10/5/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, Oct 05, 2006 at 07:28:35PM +0900, Magnus Damm wrote:
> > Kexec is broken on x86_64 under 2.6.19-rc1.
> >
> > Or rather - kexec works ok under 2.6.19-rc1, but something related to
> > the vmlinux format has probably changed and kexec-tools fails to load
> > a vmlinux from 2.6.19-rc1.
> >
> > Loading bzImage works as usual, but vmlinux does not load properly.
> >
> > The kexec binary fails with the following message:
> >
> > Overlapping memory segments at 0x351000
> > sort_segments failed
> > / #
> >
>
> Hi Magnus,
>
> Can you please post the readelf -l output of the vmlinux you are trying
> to load. That's will give some indication if the segments are really
> overlapping in vmlinux or is it some processing bug at kexec-tools part.

Elf file type is EXEC (Executable file)
Entry point 0x100100
There are 4 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000100000 0xffffffff80100000 0x0000000000100000
                 0x00000000001a4888 0x00000000001a4888  R E    100000
  LOAD           0x00000000002a5000 0xffffffff802a5000 0x00000000002a5000
                 0x000000000008e086 0x00000000000c1504  RWE    100000
  LOAD           0x0000000000400000 0xffffffffff600000 0x00000000002fd000
                 0x0000000000000c08 0x0000000000000c08  RWE    100000
  NOTE           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  R      8

 Section to Segment mapping:
  Segment Sections...
   00     .text __ex_table .rodata .pci_fixup __ksymtab __ksymtab_gpl
__ksymtab_unused __ksymtab_strings __param
   01     .data .data.cacheline_aligned .data.read_mostly
.data.init_task .data.page_aligned .init.text .init.data .init.setup
.initcall.init .con_initcall.init .altinstructions
.altinstr_replacement .exit.text .init.ramfs .bss
   02     .vsyscall_0 .xtime_lock .vxtime .vgetcpu_mode .sys_tz
.sysctl_vsyscall .xtime .jiffies .vsyscall_1 .vsyscall_2 .vsyscall_3
   03

Thanks,

/ magnus
