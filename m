Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVCIG5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVCIG5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 01:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVCIG5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 01:57:22 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:12258 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261553AbVCIG4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 01:56:49 -0500
Date: Wed, 09 Mar 2005 15:57:02 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: vivek goyal <vgoyal@in.ibm.com>
Subject: Re: Query: Kdump: Core Image ELF Format
Cc: fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       anderson@redhat.com, haren myneni <hbabu@us.ibm.com>,
       Maneesh Soni <maneesh@in.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
Message-Id: <20050309155055.C25B.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Now the issue is, on i386, whether to prepare core headers in ELF32 or
> ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
> don't know about "crash". Can "crash" support ELF64 core image file for
> i386 system?

Of course, It must be ELF64.

It is important to include all information. ELF core can be easily 
transfered to LKCD format. Then lcrash can be used.
(I use an own tool.)

Thanks.

On Tue, 08 Mar 2005 18:20:10 +0530
vivek goyal <vgoyal@in.ibm.com> wrote:

> Hi,
> 
> Kdump (A kexec based crash dumping mechanism) is going to export the
> kernel core image in ELF format. ELF was chosen as a format, keeping in
> mind that gdb can be used for limited debugging and "Crash" can be used
> for advanced debugging.
> 
> Core image ELF headers are prepared before crash and stored at a safe
> place in memory. These headers are retrieved over a kexec boot and final
> elf core image is prepared for analysis. 
> 
> Given the fact physical memory can be dis-contiguous, One program header
> of type PT_LOAD is created for every contiguous memory chunk present in
> the system. Other information like register states etc. is captured in
> notes section.
> 
> Now the issue is, on i386, whether to prepare core headers in ELF32 or
> ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
> don't know about "crash". Can "crash" support ELF64 core image file for
> i386 system?
> 
> Given the limitation of analysis tools, if core headers are prepared in
> ELF32 format then how to handle PAE systems? 
> 
> Any thoughts or suggestions on this?
> 
> Thanks
> Vivek
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Itsuro ODA <oda@valinux.co.jp>

