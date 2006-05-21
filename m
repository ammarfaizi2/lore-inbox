Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWEUBdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWEUBdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 21:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWEUBdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 21:33:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932161AbWEUBdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 21:33:04 -0400
Date: Sat, 20 May 2006 18:32:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Andrey Savochkin <saw@sw.ru>
Subject: Re: 2.6.17-rc4-mm2
Message-Id: <20060520183202.73e61a1e.akpm@osdl.org>
In-Reply-To: <446FBB52.1080402@gmx.net>
References: <446FBB52.1080402@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net> wrote:
>
> Hi Andrew,
> 
> with 2.6.17-rc4-mm2, running "make" always relinks the kernel
> even if a previous run was completed successfully.

Then don't type "make" again (sorry, couldn't resist).

> kerncomp@p35:/sources/linux-2.6.17-rc4-mm2> make
>   CHK     include/linux/version.h

We update the kernel version.

>   CHK     include/linux/compile.h
>   CC      kernel/nsproxy.o
>   CC      kernel/utsname.o

Which affects utsname.

>   LD      kernel/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1

Which requires a relink.

Various blameworthy people cc'ed, but I expect that if this is fixable
we'll need to wait until Sam is back on deck and able to perform his magic
upon it.


> WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0x1667) and 'acpi_safe_halt'
> WARNING: drivers/atm/he.o - Section mismatch: reference to .init.text: from .text after 'he_init_one' (at offset 0x2195)
> WARNING: drivers/atm/idt77105.o - Section mismatch: reference to .init.text:idt77105_init from __ksymtab after '__ksymtab_idt77105_init' (at offset 0x0)
> WARNING: drivers/atm/iphase.o - Section mismatch: reference to .init.text: from .text between 'ia_init_one' (at offset 0x1772) and 'ia_int'
> WARNING: drivers/cdrom/cm206.o - Section mismatch: reference to .init.text:cm206_init from .text between 'init_module' (at offset 0xfe7) and 'cm206_timeout'
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x120) and '__param_str_force'
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x14c) and '__param_str_force'
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x178) and '__param_str_force'
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1a4) and '__param_str_force'
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference to .init.text: from .data between 'dmi_ids' (at offset 0x1d0) and '__param_str_force'
> WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_teles0 from .text between 'checkcard' (at offset 0x632) and 'hisax_init_pcmcia'
> WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_s0box from .text between 'checkcard' (at offset 0x64e) and 'hisax_init_pcmcia'
> WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text:setup_telespci from .text between 'checkcard' (at offset 0x65c) and 'hisax_init_pcmcia'

Yeah, I fixed a bunch of those yesterday.  There are many more.

