Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVBQFHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVBQFHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVBQFHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:07:03 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9899 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262214AbVBQFG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:06:58 -0500
Subject: Re: [Fastboot] [PATCH] /proc/cpumem
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050216170224.4C66.ODA@valinux.co.jp>
References: <20050203154433.18E4.ODA@valinux.co.jp>
	 <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
	 <20050216170224.4C66.ODA@valinux.co.jp>
Content-Type: text/plain
Organization: 
Message-Id: <1108619891.5148.104.camel@terminator.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Feb 2005 11:28:11 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-02-16 at 14:19, Itsuro Oda wrote:

> 
> BTW, does not kexec/kdump run on 2.6.11-rc3-mm2 ?
> How do I get and examine the latest kexec/kdump ?

Currently kdump is broken. I am working on Elf Header generation part in
kexec-tools. Next week I should be able to post the initial patches.

---
> --- linux-2.6.11-rc3-mm2/arch/i386/mm/init.c    2005-02-16
> 15:36:29.000000000 +0900
> +++ linux-2.6.11-rc3-mm2-test/arch/i386/mm/init.c       2005-02-16
> 23:32:29.499709752 +0900
> @@ -248,6 +248,47 @@
>         return 0;
>  }
>  
> +int valid_phys_addr_range(unsigned long long phys_addr, size_t *size)
> +{
> +       int i;
> +       unsigned long long addr, end;
> +       efi_memory_desc_t *md;
> +
> +       if (efi_enabled) {
> +               for (i = 0; i < memmap.nr_map; i++) {
> +                       md = &memmap.map[i];
> +                       if (!is_available_memory(md)) {
> +                               continue;
> +                       }
> +                       addr = md->phys_addr;
> +                       end = md->phys_addr + (md->num_pages <<
> EFI_PAGE_SHIFT);
> +                       if ((phys_addr >= addr) && (phys_addr < end)) {
> +                               if (*size > end - phys_addr) {
> +                                       *size = end - phys_addr;
> +                               }
> +                               return 1;
> +                       }
> +               }
> +               return 0;
> +       }


I thought efi related data structures are of type __initdata and will be gone after initilization. (efi.c)


Thanks
Vivek


